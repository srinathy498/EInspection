using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Inspection.Forms
{
    public partial class ShipMaster : System.Web.UI.Page
    {
        BusinessRules.Common blobj = new BusinessRules.Common();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetManagers();
            }
        }
        
        public void GetManagers()
        {
            
            System.Data.DataSet ds = blobj.GeManager();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlManager.DataSource = ds;
                ddlManager.DataValueField = "Value";                
                ddlManager.DataTextField = "Text";
                ddlManager.DataBind();
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string msg = "";
            lblerror.InnerText = "";
            if (btnhdn.Value=="Update")
            {
               
            }
            else
            {
                msg = blobj.ShipDetails("", txtType.Value, txtName.Value, Convert.ToInt32(ddlManager.Value), txtContact.Value, txtAddress.Value, Session["UserId"].ToString(), txtDiscription.Value, txtCity.Value);
                System.IO.Directory.CreateDirectory(MapPath("..\\ShipFiles\\" +txtName.Value));
                
            }
            if (Convert.ToInt32(msg) >= 1)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert('Updated Successfully');", true);
            }
            else
            {
                lblerror.InnerText = "Failed.";
                lblerror.Focus();
            }
        }
        [WebMethod, ScriptMethod]
        public static string GetShipDetails()
        {
            BusinessRules.Common blobj = new BusinessRules.Common();
            DataSet ds = blobj.GetShipDetails();
            return JsonConvert.SerializeObject(ds);
        }
    }
}