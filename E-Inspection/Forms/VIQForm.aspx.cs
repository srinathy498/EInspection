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
    public partial class VIQForm : System.Web.UI.Page
    {
        BusinessRules.Common blobj = new BusinessRules.Common();
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }
        
       

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
           
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