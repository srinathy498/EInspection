using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;


namespace E_Inspection
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {

                lblerror.InnerText = "";
                if (inputEmail.Value != "" && inputPassword.Value != "")
                {
                    BusinessRules.Common objcom = new BusinessRules.Common();
                    DataSet Ds = objcom.login(inputEmail.Value, objcom.Encrypt(inputPassword.Value).ToString());
                    if (Ds.Tables.Count > 0)
                    {
                        if (Ds.Tables[0].Rows.Count > 0)
                        {
                            Session["Emailid"] = Ds.Tables[0].Rows[0]["EmailId"].ToString().Trim();
                            Session["UserType"] = Ds.Tables[0].Rows[0]["UserType"].ToString().Trim();
                            Session["Userid"] = Ds.Tables[0].Rows[0]["UserId"].ToString().Trim();
                            Session["UserCode"] = Ds.Tables[0].Rows[0]["UserCode"].ToString().Trim();
                            Session["UserName"] = Ds.Tables[0].Rows[0]["UserName"].ToString().Trim();
                            Response.Redirect("~/Home.aspx", false);
                            Context.ApplicationInstance.CompleteRequest();
                        }
                        else
                        {
                            lblerror.InnerText = "Invalid Username or Password";
                        }

                    }
                    else
                    {
                        lblerror.InnerText = "Invalid Username or Password";
                    }
                }
            }
            catch (Exception ex)
            {
                lblerror.InnerText= ex.Message;
            }
        }
    }
}