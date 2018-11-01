using System;
using System.Configuration;

namespace CariWeb.Shared
{
    public partial class Dialog : System.Web.UI.MasterPage
    {
        protected static string MainHost = "//" + ConfigurationManager.AppSettings["MainHost"];

        protected void Page_Load(object sender, EventArgs e)
        {

        }
    }
}