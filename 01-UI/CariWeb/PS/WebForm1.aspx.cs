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
            var json = new
            {
                nTotal=2,
                data = new List<Dto>() { new Dto(){ID = 1,Name = "jiangwei"},new Dto(){ID = 2,Name = "jiever"}}
            };
            var da = JsonConvert.SerializeObject(json);

            var content = JsonConvert.DeserializeObject<Result>(da);

            //var totla = content["nTotal"].ToString();
           // var rs = JsonConvert.DeserializeObject<List<Dto>>(content["data"].ToString()) ;
            //rs = rs.OrderByDescending(x => x.ID).ToList();


            List<string> strs = new List<string>(){"B级","C级","A级","D级","B", "C" };
            var order = strs.OrderBy(x => x);

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
                var list = JsonConvert.DeserializeObject<List<Dto>>(ss.Content);
                _Repeater.DataSource = list;
                _Repeater.DataBind();
            }
        }
    }

    public class Result
    {
        public string nTotal { get; set; }
        public List<Dto> Data{ get; set; }
    }
    public class Dto
    {
        private string Col;
        public int? ID { get; set; }
        public string Name { get; set; }

        public string Color
        {
            get
            {
                switch (ID)
                {
                    case 1:
                        Col = "red";
                        break;
                    case 2:
                        Col = "yellow";
                        break;
                    case 4:
                        Col = "orange";
                        break;
                }
                return Col;
            }
        }
    }
}