using BusinessRules;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace E_Inspection
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetUserType();
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            Common objcom = new Common();
            string msg = objcom.Register(txtUserName.Value, objcom.Encrypt(password1.Value), txtEmail.Value, "", "Active", "","","","","",Convert.ToInt32(ddlUser.Value));

            if (msg == "exist")
            {
                lblerror.InnerText = "User already exist, please try another Email Id";
            }
            else
            {
                //sendCustomeremail();
                ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert();", true);
                //Response.Redirect("~/Login.aspx",false);
                //Context.ApplicationInstance.CompleteRequest();
            }
        }
        public void GetUserType()
        {
            BusinessRules.Common blobj = new BusinessRules.Common();
            System.Data.DataSet ds = blobj.GetUserType();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlUser.DataSource = ds;
                ddlUser.DataValueField = "Value";                
                ddlUser.DataTextField = "Text";
                ddlUser.DataBind();
            }
        }
    }
}