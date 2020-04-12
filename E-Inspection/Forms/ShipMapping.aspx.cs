using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace E_Inspection.Forms
{
    public partial class ShipMapping : System.Web.UI.Page
    {
        BusinessRules.Common blobj = new BusinessRules.Common();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // CreateTable();
                GetShipDetail();
                GetTankerDetails();
                GetVetterDetails();
            }
        }
        public DataSet GetUserDetails()
        {

            System.Data.DataSet ds = blobj.GetUserDetails();
            return ds;
        }
        public void GetTankerDetails()
        {

            System.Data.DataSet ds = blobj.GetTankerDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlUser.DataSource = ds;
                ddlUser.DataValueField = "UserId";
                ddlUser.DataTextField = "UserName";
                ddlUser.DataBind();
            }
        }
        public void GetVetterDetails()
        {

            System.Data.DataSet ds = blobj.GetVetterDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlVetter.DataSource = ds;
                ddlVetter.DataValueField = "UserId";
                ddlVetter.DataTextField = "UserName";
                ddlVetter.DataBind();
            }
        }
        public void GetShipDetail()
        {

            System.Data.DataSet ds = blobj.GetShipDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlShip.DataSource = ds;
                ddlShip.DataValueField = "ShipId";
                ddlShip.DataTextField = "Name";
                ddlShip.DataBind();
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           // PreviousCreateTable();
            string msg = "";
            lblerror.InnerText = "";
            if (btnhdn.Value=="Update")
            {
               
            }
            else
            {
                //int count = 0;
                //string[] tablecontents = HiddenField1.Value.Split(',');
                //string[] tblps = null;
                //string JobId = blobj.GetJobID();
                //for (int i = 0; i < tablecontents.Length; i++)
                //{
                //    tblps = tablecontents[i].Split(':');

                //    msg = blobj.ShipMapping(tblps[0], tblps[2], JobId, "1", Session["UserId"].ToString());
                //    count++;
                //}
                //if (count > 0)
                //{
                //    string s = "Mapped Successfully.";

                //    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert('" + s + "');", true);
                //}
                msg = blobj.ShipMapping(ddlUser.Value, ddlShip.Value, txtJobId.Value, "1", Session["UserId"].ToString(),ddlVetter.Value);
                if (msg == "1")
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert('Updated Successfully');", true);
                }
                else
                {
                    lblerror.InnerText = "Failed.";
                    lblerror.Focus();
                }
            }            
        }        
        public void CreateTable()
        {
            DataSet tablecontents = GetUserDetails();
            string[] tblps = null;
            HtmlTableRow row = new HtmlTableRow();
            HtmlTableCell cell = new HtmlTableCell();
            for (int i = 0; i < tablecontents.Tables[0].Rows.Count; i++)
            {
                row = new HtmlTableRow();
                cell = new HtmlTableCell();
                cell.InnerText = tablecontents.Tables[0].Rows[i]["UserId"].ToString();
                row.Cells.Add(cell);
                cell.Attributes.Add("style", "display:none;");
                row.Cells.Add(cell);
                
                cell = new HtmlTableCell();
                cell.InnerText = tablecontents.Tables[0].Rows[i]["UserName"].ToString();                                
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                HtmlSelect inputselect = new HtmlSelect();
                inputselect.ID = "ddlship" + tablecontents.Tables[0].Rows[i]["UserId"];
                inputselect.Attributes.Add("class", "form-control");
                inputselect.Attributes.Add("style", "width:100%;");
                DataSet ds = blobj.GetShipDetails();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    inputselect.DataSource = ds;
                    inputselect.DataTextField = "Name";
                    inputselect.DataValueField = "ShipId";
                    inputselect.DataBind();
                    //inputselect.Value = tblps[1].ToString();
                }
                cell.Controls.Add(inputselect);
                row.Cells.Add(cell);
                tblMapping.Rows.Add(row);
            }
            
        }
        public void PreviousCreateTable()
        {
            string[] tablecontents = HiddenField1.Value.Split(',');
            string[] tblps = null;
            HtmlTableRow row = new HtmlTableRow();
            HtmlTableCell cell = new HtmlTableCell();
            for (int i = 0; i < tablecontents.Length; i++)
            {
                tblps = tablecontents[i].Split(':');
                row = new HtmlTableRow();
                cell = new HtmlTableCell();
                cell.InnerText = tblps[0];
                row.Cells.Add(cell);
                cell.Attributes.Add("style", "display:none;");
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                cell.InnerText = tblps[1];
                row.Cells.Add(cell);

                cell = new HtmlTableCell();
                HtmlSelect inputselect = new HtmlSelect();
                inputselect.ID = "ddlship" + tblps[0];
                inputselect.Attributes.Add("class", "form-control");
                inputselect.Attributes.Add("style", "width:100%;");
                DataSet ds = blobj.GetShipDetails();
                if (ds.Tables[0].Rows.Count > 0)
                {
                    inputselect.DataSource = ds;
                    inputselect.DataTextField = "Name";
                    inputselect.DataValueField = "ShipId";
                    inputselect.DataBind();
                    inputselect.Value = tblps[2].ToString();
                }
                cell.Controls.Add(inputselect);
                row.Cells.Add(cell);
                tblMapping.Rows.Add(row);
            }

        }
    }
}