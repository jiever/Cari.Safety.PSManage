using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Safety.BLL.PSManage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace CariWeb.PS
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //var url = "http://47.98.157.173:8010/api/order/getorders";
            //var s = RequestToApi.Get(url);


            var url1 = "http://47.98.157.173:8010/api/order/getOrdersByPost";
            var data = new Dto()
            {
                ID = null,
                Name = ""
            };
            var ss = RequestToApi.Post(url1, JsonConvert.SerializeObject(data));
            if (ss.StatusCode == "OK")
            {
                var list = JsonConvert.DeserializeObject(ss.Content);
                _Repeater.DataSource = list;
                _Repeater.DataBind();
            }
        }
    }

    public class Dto
    {
        public int? ID { get; set; }
        public string Name { get; set; }
    }
}