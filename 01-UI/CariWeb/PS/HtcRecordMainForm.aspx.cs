using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace CariWeb.PS
{
    public partial class HtcRecordMainForm : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                InitData();
                LoadData();
            }
        }

        private void InitData()
        {
            
        }

        private void LoadData()
        {
            
        }

        protected void _RequestButton_Click(object sender, EventArgs e)
        {
            
        }
    }
}