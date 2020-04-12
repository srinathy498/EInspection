using BusinessRules;
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
    public partial class User : System.Web.UI.Page
    {
        BusinessRules.Common blobj = new BusinessRules.Common();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                GetUserType();
            }
        }
        public void GetUserType()
        {
            BusinessRules.Common blobj = new BusinessRules.Common();
            System.Data.DataSet ds = blobj.GetUserType();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlUserType.DataSource = ds;
                ddlUserType.DataValueField = "Value";
                ddlUserType.DataTextField = "Text";
                ddlUserType.DataBind();
            }
        }
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string msg = "";
            Common objcom = new Common();
            if (btnhdn.Value == "Update")
            {

            }
            else
            {
                msg = objcom.Register(txtName.Value, objcom.Encrypt(password1.Value), txtEmail.Value, txtContact.Value, "Active",txtAddress.Value, Session["UserId"].ToString(), "", "", "", Convert.ToInt32(ddlUserType.Value));

            }
            if (msg == "exist")
            {
                lblerror.InnerText = "User already exist, please try another Email Id";
            }
            else
            {
                //sendCustomeremail();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert('Updated Successfully.');", true);                
            }
        }
        [WebMethod, ScriptMethod]
        public static string GetUserDetails()
        {
            BusinessRules.Common blobj = new BusinessRules.Common();
            DataSet ds = blobj.GetUserDetails();
            return JsonConvert.SerializeObject(ds);
        }
    }
}