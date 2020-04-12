using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Reflection;
using System.Runtime.CompilerServices;
using System.Security;
using System.Text;
using System.Threading.Tasks;
using Microsoft.VisualBasic;
using System.Data;
using System.Data.SqlClient;

namespace DataAccess
{
    public class Common
    {
        protected SqlConnection Conn = new SqlConnection(System.Configuration.ConfigurationSettings.AppSettings["conStr"]);
        private SqlDataAdapter Dad;
        private SqlCommand Cmd;
        private SqlDataReader Dr;
        private DataSet Ds;
        private SqlTransaction myTrans;


        public string GetConnectionString()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["conStr"];
        }
        public void ConnectionOpen()
        {
            if (Conn.State == ConnectionState.Closed)
                Conn.Open();
        }
        public void ConnectionClose()
        {
            if (Conn.State == ConnectionState.Open)
                Conn.Close();
        }
        public DataSet GetDataSet(string Sql, string TableName)
        {
            ConnectionOpen();
            Dad = new SqlDataAdapter(Sql, Conn);
            Ds = new DataSet();
            Dad.SelectCommand.CommandTimeout = 6000;
            Dad.Fill(Ds, TableName);
            ConnectionClose();
            return Ds;
        }
        
        public bool BeginTrans()
        {
            bool ret;
            ret = false;
            {
                var withBlock = Cmd.Connection;
                myTrans = withBlock.BeginTransaction();
                ret = true;
            }
            return ret;
        }

        public DataSet GetDataSet(string Sql, SqlParameter[] SqlParameters, string TableName)
        {
            ConnectionOpen();
            Dad = new SqlDataAdapter(Sql, Conn);
            Ds = new DataSet();
            Dad.SelectCommand.CommandTimeout = 6000;
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Dad.SelectCommand.Parameters.Add(para);
            }
            Dad.Fill(Ds, TableName);
            ConnectionClose();
            return Ds;
        }
        public DataSet GetDataSQLDS(string Sql, SqlParameter[] SqlParameters)
        {
            ConnectionOpen();
            Dad = new SqlDataAdapter(Sql, Conn);
            Ds = new DataSet();
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Dad.SelectCommand.Parameters.Add(para);
            }
            Dad.Fill(Ds);
            ConnectionClose();
            return Ds;
        }
        public SqlDataReader GetDataReader(string Sql, SqlParameter[] SqlParameters)
        {
            ConnectionOpen();
            Cmd = new SqlCommand();
            Cmd = new SqlCommand(Sql, Conn);
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }
            Dr = Cmd.ExecuteReader();
            // ConnectionClose()
            return Dr;
        }
        public SqlDataReader GetDataReader(string Sql, SqlParameter[] SqlParameters, SqlConnection Connection)
        {
            // ConnectionOpen()
            if (Connection.State == ConnectionState.Closed)
                Connection.Open();
            Cmd = new SqlCommand();
            Cmd = new SqlCommand(Sql, Connection);
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }
            Dr = Cmd.ExecuteReader();
            return Dr;
        }


        public string GetScalar(string Sql, SqlParameter[] SqlParameters)
        {
            string Scalar;
            ConnectionOpen();
            Cmd = new SqlCommand(Sql, Conn);
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }
            Scalar = Cmd.ExecuteScalar().ToString();
            ConnectionClose();
            return Scalar;
        }
        public string GetScalarString(string Sql)
        {
            string Scalar;
            ConnectionOpen();
            Cmd = new SqlCommand(Sql, Conn);
            Scalar = Cmd.ExecuteNonQuery().ToString();
            ConnectionClose();
            return Scalar;
        }
        public string GetScalarString(string Sql, SqlParameter[] SqlParameters)
        {
            string Scalar;
            ConnectionOpen();
            Cmd = new SqlCommand(Sql, Conn);
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }
            Scalar = Cmd.ExecuteScalar().ToString();
            ConnectionClose();
            return Scalar;
        }
        public string ExecuteQuery(string Sql, SqlParameter[] SqlParameters)
        {
            try
            { 
            string status;
            ConnectionOpen();
            Cmd = new SqlCommand();
            Cmd.CommandText = Sql;
            Cmd.Connection = Conn;
            Cmd.CommandTimeout = 180;
            Cmd.Parameters.Clear();
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }
            status = Cmd.ExecuteNonQuery().ToString();
            ConnectionClose();
                return status;
            }
            catch (Exception ex)
            {
                return null;
            }
           
        }
        




        public SqlParameter CreateSQLParameter(string ParameterName, System.Data.SqlDbType SQLParameterDBType, object ParameterValue)
        {
            SqlParameter para = new SqlParameter();
            {
                var withBlock = para;
                withBlock.ParameterName = "@" + ParameterName;
                withBlock.IsNullable = true;
                withBlock.SqlDbType = SQLParameterDBType;

                if (ParameterValue is DBNull)
                    withBlock.Value = DBNull.Value;
                else if (ParameterValue is System.String)
                {
                    if (ParameterValue == null)
                        withBlock.Value = DBNull.Value;
                    else
                        withBlock.Value = ParameterValue;
                }
                else if ((ParameterValue is System.Int16 | ParameterValue is System.Int32
                                                | ParameterValue is System.Int64 | ParameterValue is System.Double | ParameterValue is System.Decimal
                                                | ParameterValue is System.Single | ParameterValue is System.Byte | ParameterValue is System.UInt16 | ParameterValue is System.UInt32 | ParameterValue is System.UInt64))
                    withBlock.Value = ParameterValue;
                else if (ParameterValue == null)
                    withBlock.Value = DBNull.Value;
                else
                    withBlock.Value = ParameterValue;
            }

            return para;
        }
       

        public DataSet GetProcedure(string ProcedureName, SqlParameter[] SqlParameters)
        {
            ConnectionOpen();
            Cmd = new SqlCommand();
            Cmd.Connection = Conn;
            Cmd.CommandText = ProcedureName;
            Cmd.CommandType = CommandType.StoredProcedure;

            Cmd.Parameters.Clear();
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }

            Dad = new SqlDataAdapter(Cmd);
            Ds = new DataSet();
            Dad.SelectCommand.CommandTimeout = 6000;
            Dad.Fill(Ds);

            ConnectionClose();
            return Ds;
        }

        public string ExecuteProcedure(string ProcedureName, SqlParameter[] SqlParameters)
        {
            string status;

            ConnectionOpen();
            Cmd = new SqlCommand();
            Cmd.Connection = Conn;
            Cmd.CommandText = ProcedureName;
            Cmd.CommandType = CommandType.StoredProcedure;

            Cmd.Parameters.Clear();
            if (SqlParameters != null)
            {
                SqlParameter[] SqlParametersClone;
                SqlParametersClone = CloneSqlParameters(SqlParameters);

                foreach (SqlParameter para in SqlParametersClone)
                    Cmd.Parameters.Add(para);
            }

            status = Cmd.ExecuteNonQuery().ToString();
            ConnectionClose();
            return status;
        }

        public int ExecuteNonQuery(SqlCommand SqlCommand)
        {
            int ret;

            {
                var withBlock = SqlCommand;
                withBlock.Connection = Conn;
                withBlock.Connection.Open();
                ret = withBlock.ExecuteNonQuery();
                withBlock.Connection.Close();
                return ret;
            }
        }
        public SqlParameter[] CloneSqlParameters(SqlParameter[] SqlParameters)
        {
            SqlParameter[] SqlParametersCopy = new SqlParameter[SqlParameters.Length - 1 + 1];
            for (int i = 0; i <= SqlParameters.Length - 1; i++)
                SqlParametersCopy[i] = SqlParameters[i];
            return SqlParametersCopy;
        }
        public DataSet Login(string Username, string password)
        {
            string SQL;
            SqlParameter[] para = new SqlParameter[2];
            para[0] = CreateSQLParameter("Username", SqlDbType.VarChar, Username);
            para[1] = CreateSQLParameter("password", SqlDbType.VarChar, password);
            SQL = "Select * from tblUserDetails where EmailId=@Username  and Password=@password and isnull(Status,'') !='Delete' ";
            DataSet ds = GetDataSet(SQL, para, "Login");
            return ds;
        }  
        public string Register(string   Username,  string password, string EmailId, string pnoneno,string Status,string Address,string CreatedBy,string UserCode,string FirstName,string LastName,int UserTypeId)
        {
            string msg = string.Empty, Cmdstr,Userid=string.Empty;            
            
            SqlParameter[] para = new SqlParameter[11];
            SqlParameter[] para1 = new SqlParameter[1];
            para1[0] = CreateSQLParameter("EmailId", SqlDbType.VarChar, EmailId);
            string SQL = "Select * from tblUserDetails where EmailId=@EmailId and isnull(Status,'') !='Delete' ";
            DataSet ds = GetDataSet(SQL, para1, "TempEmail");
            if (ds.Tables[0].Rows.Count > 0 && EmailId != "")
                msg = "exist";
               // msg = "";
            else
            {
                para[0] = CreateSQLParameter("Username", SqlDbType.VarChar, Username);                
                para[1] = CreateSQLParameter("password", SqlDbType.VarChar, Convert.ToString(password));
                para[2] = CreateSQLParameter("EmailId", SqlDbType.VarChar, EmailId);
                para[3] = CreateSQLParameter("ContactNumber", SqlDbType.VarChar, pnoneno);
                para[4] = CreateSQLParameter("Address", SqlDbType.VarChar, Address);
                para[5] = CreateSQLParameter("UserType", SqlDbType.Int, UserTypeId);
                para[6] = CreateSQLParameter("LastName", SqlDbType.VarChar, LastName);
                para[7] = CreateSQLParameter("FirstName", SqlDbType.VarChar, FirstName);
                para[8] = CreateSQLParameter("CreatedBy", SqlDbType.VarChar, CreatedBy);
                para[9] = CreateSQLParameter("CreatedDate", SqlDbType.VarChar, DateTime.Now.ToString());
                para[10] = CreateSQLParameter("Status", SqlDbType.VarChar, "1");
                Cmdstr = "Insert into tblUserDetails(UserName, [password], EmailId, Address, ContactNumber,UserType,CreatedBy,CreatedDate,Status) VALUES" +
                    "(@Username, @password, @EmailId, @Address,@ContactNumber,@UserType,@CreatedBy,@CreatedDate,@Status )";
                msg = ExecuteQuery(Cmdstr, para);
            }
            return msg;
        }

        public string CompanyDetails(string CompanyName, string Size, string Location, string Address, string Status)
        {
            string msg = string.Empty, Cmdstr, Userid = string.Empty;

            SqlParameter[] para = new SqlParameter[4];
                para[0] = CreateSQLParameter("CompanyName", SqlDbType.VarChar, CompanyName);
                para[1] = CreateSQLParameter("Size", SqlDbType.VarChar,Size);
                para[2] = CreateSQLParameter("Location", SqlDbType.VarChar, Location);
                para[3] = CreateSQLParameter("Address", SqlDbType.VarChar, Address);
                para[4] = CreateSQLParameter("Status", SqlDbType.VarChar, Status);
                Cmdstr = "Insert into tblCompanyDetails(CompanyName,Size, Location, Address, Status) VALUES" +
                    "(@CompanyName, @Size, @Location, @Address,@Status )";
                msg = ExecuteQuery(Cmdstr, para);           
            return msg;
        }
        public string ShipDetails(string ShipCode, string ShipType, string Name, int ManagerId, string ContactNo,string Address,string CreatedBy,string Discription,string City)
        {
            string msg = string.Empty, Cmdstr, Userid = string.Empty;

            SqlParameter[] para = new SqlParameter[11];
            para[0] = CreateSQLParameter("ShipType", SqlDbType.VarChar, ShipType);
            para[1] = CreateSQLParameter("ShipCode", SqlDbType.VarChar, ShipCode);
            para[2] = CreateSQLParameter("Name", SqlDbType.VarChar, Name);
            para[3] = CreateSQLParameter("ManagerId", SqlDbType.Int, ManagerId);
            para[4] = CreateSQLParameter("Status", SqlDbType.VarChar, 1);
            para[5] = CreateSQLParameter("ContactNo", SqlDbType.VarChar, ContactNo);
            para[6] = CreateSQLParameter("Address", SqlDbType.VarChar, Address);
            para[7] = CreateSQLParameter("CreatedBy", SqlDbType.VarChar, CreatedBy);
            para[8] = CreateSQLParameter("Discription", SqlDbType.VarChar, Discription);
            para[9] = CreateSQLParameter("City", SqlDbType.VarChar, City);
            para[10] = CreateSQLParameter("CreatedDate", SqlDbType.Date, DateTime.Now);            
            Cmdstr = "Insert into tblShipMaster(ShipCode,Type,Name,ContactNumber,Address,SMangerId,CreatedBy,CreatedDate,Status,Discription,City) VALUES" +
                "(@ShipCode, @ShipType,@Name,@ContactNo ,@Address,@ManagerId,@CreatedBy,@CreatedDate,@Status,@Discription,@City); SELECT SCOPE_IDENTITY()";
            msg = GetScalar(Cmdstr, para);           
            return msg;
        }
        public string UserComShpDetails(string UserId, int CompanyId, string ShipId, string Status)
        {
            string msg = string.Empty, Cmdstr, Userid = string.Empty;

            SqlParameter[] para = new SqlParameter[3];
            para[0] = CreateSQLParameter("UserId", SqlDbType.Int, UserId);
            para[1] = CreateSQLParameter("CompanyId", SqlDbType.Int, CompanyId);
            para[2] = CreateSQLParameter("ShipId", SqlDbType.Int, ShipId);         
            para[3] = CreateSQLParameter("Status", SqlDbType.VarChar, Status);
            Cmdstr = "Insert into tblUserComShpDetails(UserId,CompanyId, ShipId, CompanyID, Status) VALUES" +
                "(@UserId, @CompanyId, @ShipId, @CompanyID,@Status )";
            msg = ExecuteQuery(Cmdstr, para);
            return msg;
        }
        public string ShipMapping(string UserId, string ShipId, string JobId, string Status,string CreatedBy,string VetterId)
        {
            string msg = string.Empty, Cmdstr, Userid = string.Empty;

            SqlParameter[] para = new SqlParameter[7];
            para[0] = CreateSQLParameter("UserId", SqlDbType.VarChar, UserId);
            para[1] = CreateSQLParameter("JobId", SqlDbType.VarChar, JobId);
            para[2] = CreateSQLParameter("ShipId", SqlDbType.VarChar, ShipId);
            para[3] = CreateSQLParameter("Status", SqlDbType.VarChar, 1);           
            para[4] = CreateSQLParameter("CreatedBy", SqlDbType.VarChar, CreatedBy);
            para[5] = CreateSQLParameter("CreatedDate", SqlDbType.VarChar, DateTime.Now);
            para[6] = CreateSQLParameter("VetterId", SqlDbType.VarChar, VetterId);
            Cmdstr = "Insert into tblShipMap(UserId,JobId, ShipId, CreatedBy, Status,CreatedDate,VetterId) VALUES" +
                "(@UserId,@JobId, @ShipId, @CreatedBy, @Status,@CreatedDate,@VetterId)";
            msg = ExecuteQuery(Cmdstr, para);
            return msg;
        }
        public DataSet GetManager()
        {
            string query = "";
            query = "Select UserId As Value,UserName As [Text] from tblUserDetails where UserType=1";
            DataSet ds = GetDataSet(query, "Manager");
            return ds;
        }
        public DataSet GetUserDetails()
        {
            string query = "";
            query = "Select U.*,T.Type from tblUserDetails U" +
                " Join tblUserType T on T.UserTypeId=U.UserType where U.Status ='1'";
            DataSet ds = GetDataSet(query, "Manager");           
            return ds;
        }
        public DataSet GetTankerDetails()
        {
            string query = "";
            query = "Select U.*,T.Type from tblUserDetails U" +
                " Join tblUserType T on T.UserTypeId=U.UserType where U.Status ='1' AND UserType in(2) ";
            DataSet ds = GetDataSet(query, "Manager");
            return ds;
        }
        public DataSet GetVetterDetails()
        {
            string query = "";
            query = "Select U.*,T.Type from tblUserDetails U" +
                " Join tblUserType T on T.UserTypeId=U.UserType where U.Status ='1' AND UserType in(4) ";
            DataSet ds = GetDataSet(query, "Manager");
            return ds;
        }
        public DataSet GetUserType()
        {
            string query = "";
            query = "Select UserTypeId As Value,Type As [Text] from tblUserType where Status=1";
            DataSet ds = GetDataSet(query, "Manager");
            return ds;
        }
        public DataSet GetShipFiles(string userid ,string shipId)
        {
            string query = "";
            query = "Select U.*,S.Name,t.UserName from tblShipFiles U "+
                    " Join tblShipMaster  S on U.shipId = S.ShipId "+
                    " Join tblUserDetails t on t.UserId = U.UserId ";
            //if (userid !="" && shipId!="")
            //{
            //    query = query + " Where U.UserId='" + userid + "' AND U.ShipId = '" + shipId + "'";
            //}
            if (shipId != "")
            {
                query = query + " Where U.ShipId = '" + shipId + "'";
            }
            DataSet ds = GetDataSet(query, "ShipFiles");
            return ds;
        }
        public DataSet GetShipDetails()
        {
            string query = "";
            query = "Select * from tblShipMaster where Status=1";
            DataSet ds = GetDataSet(query, "ShipMaster");
            return ds;
        }
        public string GetJobID()
        {
            string query = "";
            query = "Select Isnull(Max(Isnull(Jobid,0)),0) as ID from tblShipMap";
            DataSet ds = GetDataSet(query, "ShipMaster");
            if (ds.Tables[0].Rows.Count>0)
            {
                return (Convert.ToInt32(ds.Tables[0].Rows[0]["ID"].ToString())+1).ToString();
            }
            else
                return "1";

        }
        public DataSet GetJobID(string UserID)
        {
            string query = "";
            query = "Select M.*,S.Name from tblShipMap M "+
                " Join tblshipmaster S on M.ShipId=S.ShipId " +
                " where UserId='"+UserID+"'";
            DataSet ds = GetDataSet(query, "ShipMaster");
            return ds;

        }
        public DataSet GetVetterJobID(string UserID)
        {
            string query = "";
            query = "Select M.*,S.Name from tblShipMap M " +
                " Join tblshipmaster S on M.ShipId=S.ShipId " +
                " where VetterId='" + UserID + "'";
            DataSet ds = GetDataSet(query, "ShipMaster");
            return ds;

        }
        public string ShipFiles(string UserId, string FileName, string Extension, string Path,string ShipId,string FileType)
        {
            string msg = string.Empty, Cmdstr, Userid = string.Empty;
            SqlParameter[] para = new SqlParameter[8];
            para[0] = CreateSQLParameter("UserId", SqlDbType.VarChar, UserId);
            para[1] = CreateSQLParameter("Extension", SqlDbType.VarChar, Extension);
            para[2] = CreateSQLParameter("ShipId", SqlDbType.VarChar, ShipId);
            para[3] = CreateSQLParameter("Path", SqlDbType.VarChar, Path);
            para[4] = CreateSQLParameter("FileName", SqlDbType.VarChar, FileName);
            para[5] = CreateSQLParameter("CreatedDate", SqlDbType.Date, DateTime.Now);
            para[6] = CreateSQLParameter("Status", SqlDbType.Int, 1);
            para[7] = CreateSQLParameter("FileType", SqlDbType.VarChar, FileType);
            Cmdstr = "Insert into tblShipFiles(FileName,Extension,Path,ShipID,UserId,CreatedDate,CreatedBy,Status,FileType) VALUES" +
                "(@FileName,@Extension,@Path,@ShipID,@UserId,@CreatedDate,@UserId,@Status,@FileType)";
            msg = ExecuteQuery(Cmdstr, para);
            return msg;
        }
    }
}