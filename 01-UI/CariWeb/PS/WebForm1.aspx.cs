using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Safety.BLL.PSManage;

namespace CariWeb.PS
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var url = "http://47.98.157.173:8010/api/order/getorders";
            var s = RequestToApi.Get(url);
        }
    }
}