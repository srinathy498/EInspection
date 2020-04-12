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
    public partial class ShipFiles : System.Web.UI.Page
    {
        BusinessRules.Common blobj = new BusinessRules.Common();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GetShipDetail();
            }
        }
        
        public void GetShipDetail()
        {
            
            System.Data.DataSet ds = blobj.GetShipDetails();
            if (ds.Tables[0].Rows.Count > 0)
            {
                ddlship.DataSource = ds;
                ddlship.DataValueField = "ShipId";                
                ddlship.DataTextField = "Name";
                ddlship.DataBind();
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

                if ((shipfileupload.PostedFile != null) && (shipfileupload.PostedFile.ContentLength > 0))
                {
                    DataSet ds=new DataSet();
                    string shipname = "",shipId="";
                    if (Session["UserType"].ToString() != "3" && Session["UserType"].ToString() != "1")
                    {
                        if (Session["UserType"].ToString() == "2")
                        {
                            ds = blobj.GetJobID(Session["UserId"].ToString());
                        }
                        else if (Session["UserType"].ToString() == "4")
                        {
                            ds = blobj.GetVetterJobID(Session["UserId"].ToString());
                        }
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            shipname = ds.Tables[0].Rows[0]["Name"].ToString();
                            shipId = ds.Tables[0].Rows[0]["ShipId"].ToString();
                        }
                    }
                    else
                    {
                        shipname = ddlship.Items[ddlship.SelectedIndex].Text;
                        shipId = ddlship.Value;
                    }

                    string root = MapPath("..\\ShipFiles\\" + shipname + "\\"+ Session["UserName"].ToString()+"\\" + ddlTypeFiles.Value);
                    if (System.IO.Directory.Exists(root))
                    { 
                    }
                    else
                        System.IO.Directory.CreateDirectory(root);

                    var count = 0;
                    foreach (HttpPostedFile uploadedFile in shipfileupload.PostedFiles)
                    {
                        string fn = System.IO.Path.GetFileName(uploadedFile.FileName).Replace(" ","");
                        string SaveLocation = root+"\\" + fn;
                        string path = "ShipFiles/" + shipname + "/" + Session["UserName"].ToString() + "/" + ddlTypeFiles.Value+"/" + fn;
                        try
                        {
                            uploadedFile.SaveAs(SaveLocation);
                          msg = blobj.ShipFiles(Session["UserId"].ToString(), uploadedFile.FileName.Replace(" ", ""), "", path, shipId,ddlTypeFiles.Value);
                            count++;
                        }
                        catch (Exception ex)
                        {
                            lblerror.InnerText = "Error: " + ex.Message;
                        }
                    }
                    if (count > 0)
                    {
                       string s = count + " files has been uploaded.";

                        ScriptManager.RegisterStartupScript(this, GetType(), "Popup", "successalert('"+s+"');", true);
                    }
                }
                else
                {
                    lblerror.InnerText = "Please select a file to upload.";
                }
            }            
        }
        [WebMethod, ScriptMethod]
        public static string GetShipFileDetails(string UserId,string ShipId)
        {
            BusinessRules.Common blobj = new BusinessRules.Common();
            DataSet ds = blobj.GetShipFiles(UserId,ShipId);
            return JsonConvert.SerializeObject(ds);
        }
    }
}