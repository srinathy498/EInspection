using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DataAccess;
using System.Net.Mail;
using System.Net;
using System.Data;

namespace BusinessRules
{
    public class Common
    {
        DataAccess.Common DataObj = new DataAccess.Common();
        public string GetConnectionString()
        {
            return System.Configuration.ConfigurationSettings.AppSettings["conStr"];
        }
        public string Encrypt(string password)
        {
            try
            {
                byte[] encData_byte = new byte[password.Length];
                encData_byte = System.Text.Encoding.UTF8.GetBytes(password);
                string encodedData = Convert.ToBase64String(encData_byte);
                return encodedData;
            }
            catch (Exception ex)
            {
                throw new Exception("Error in base64Encode" + ex.Message);
            }
        } //this function Convert to Decord your Password
        public string Decrypt(string encodedData)
        {
            System.Text.UTF8Encoding encoder = new System.Text.UTF8Encoding();
            System.Text.Decoder utf8Decode = encoder.GetDecoder();
            byte[] todecode_byte = Convert.FromBase64String(encodedData);
            int charCount = utf8Decode.GetCharCount(todecode_byte, 0, todecode_byte.Length);
            char[] decoded_char = new char[charCount];
            utf8Decode.GetChars(todecode_byte, 0, todecode_byte.Length, decoded_char, 0);
            string result = new String(decoded_char);
            return result;
        }
        public string SendMail(string frommail, string tomail, string hostname, string Subject, string Body, string template)
        {
            MailMessage Msg = new MailMessage();
            // Sender e-mail address.
            Msg.From = new MailAddress("sreenath.yaramati@websynergies.in");
            // Recipient e-mail address.
            Msg.To.Add("srinathy498@gmail.com");
            Msg.Subject = "Enquiry";
            Msg.Body = "Sender : " + "sreenath.yaramati@websynergies.in" + "\n" + "Name : " + "Test" + "\n" + "Phone : " + "Phone" + "\n" + "Address:" + "Address" + "\n" + "Enquiry:" + "En";
            // your remote SMTP server IP.
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "mail.websynergies.in";
            smtp.Port = 25;
            smtp.Credentials = new System.Net.NetworkCredential("sreenath.yaramati@websynergies.in", "srinath@57");
            smtp.EnableSsl = false;
            smtp.Send(Msg);
            return "";
        }
        public DataSet login(string Username, string Password)
        {
            DataSet Ds = DataObj.Login(Username, Password);
            return Ds;
        }
        public string Register(string Username, string password, string EmailId, string pnoneno, string Status, string Address, string CreatedBy, string UserCode, string FirstName, string LastName, int UserTypeId)
        {
            string msg;
            msg = DataObj.Register(Username, password, EmailId, pnoneno, Status, Address, CreatedBy, UserCode, FirstName, LastName, UserTypeId);
            return msg;
        }
        public string CompanyDetails(string CompanyName, string Size, string Location, string Address, string Status)
        {
            string msg;
            msg = DataObj.CompanyDetails(CompanyName, Size, Location, Address, Status);
            return msg;
        }
        public string ShipDetails(string ShipCode, string ShipType, string Name, int ManagerId, string ContactNo, string Address, string CreatedBy, string Discription, string City)
        {
            string msg;
            msg = DataObj.ShipDetails(ShipCode, ShipType, Name, ManagerId, ContactNo, Address, CreatedBy, Discription, City);
            return msg;
        }
        public string UserComShpDetails(string UserId, int CompanyId, string ShipId, string Status)
        {
            string msg;
            msg = DataObj.UserComShpDetails(UserId,  CompanyId,  ShipId,  Status);
            return msg;
        }
        public DataSet GeManager()
        {
            DataSet Ds = DataObj.GetManager();
            return Ds;
        }
        public DataSet GetUserDetails()
        {
            DataSet Ds = DataObj.GetUserDetails();
            if (Ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < Ds.Tables[0].Rows.Count; i++)
                {
                    Ds.Tables[0].Rows[i]["Password"] = Decrypt(Ds.Tables[0].Rows[i]["Password"].ToString());
                }                
            }
            return Ds;
        }
        public string ShipMapping(string UserId, string ShipId, string JobId, string Status, string CreatedBy,string VetterId)
        {
            string msg;
            msg = DataObj.ShipMapping(UserId, ShipId, JobId, Status, CreatedBy, VetterId);
            return msg;
        }
        public string GetJobID()
        {
            string msg;
            msg = DataObj.GetJobID();
            return msg;
        }
        public DataSet GetShipFiles(string userid, string shipId)
        {
            DataSet Ds = DataObj.GetShipFiles(userid,shipId);
            return Ds;
        }
        public DataSet GetShipDetails()
        {
            DataSet Ds = DataObj.GetShipDetails();
            return Ds;
        }
        public DataSet GetJobID(string UserId)
        {
            DataSet Ds = DataObj.GetJobID(UserId);
            return Ds;
        }
        public DataSet GetVetterJobID(string UserId)
        {
            DataSet Ds = DataObj.GetVetterJobID(UserId);
            return Ds;
        }
        public DataSet GetTankerDetails()
        {
            DataSet Ds = DataObj.GetTankerDetails();
            return Ds;
        }
        public DataSet GetVetterDetails()
        {
            DataSet Ds = DataObj.GetVetterDetails();
            return Ds;
        }
        public DataSet GetUserType()
        {
            DataSet Ds = DataObj.GetUserType();
            return Ds;
        }
        public string ShipFiles(string UserId, string FileName, string Extension, string Path, string ShipId,string FileType)
        {
            string msg;
            msg = DataObj.ShipFiles(UserId, FileName, Extension, Path, ShipId, FileType);
            return msg;
        }

    }
}
