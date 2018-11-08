using System;
using System.Collections.Generic;
using System.Linq;
using Cari.Safety.BLL.PSManage;
using CariWeb.PS;
using Newtonsoft.Json;

namespace CariWeb.Analysis
{
    public partial class CircleAnalysisHtc : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var type = Request.QueryString["type"];
            if (type == "data")
            {
                GetData();
            }
        }

        private void GetData()
        {
            var url1 = "http://47.98.157.173:8010/api/order/getOrdersByPost";
            var data = new Dto()
            {
                ID = null,
                Name = ""
            };
            var ss = RequestToApi.Post(url1, JsonConvert.SerializeObject(data));
            var result = new List<RspD>();
            if (ss.StatusCode == "OK")
            {
                var list = JsonConvert.DeserializeObject<List<Dto>>(ss.Content);
                result.AddRange(list.Select(x => new RspD()
                {
                    value = x.ID.HasValue?x.ID.Value:0,
                    name = x.Name
                }));
            }

            Response.Clear();
            Response.Write(JsonConvert.SerializeObject(result));
            Response.End();
        }
    }

    public class RspD
    {
        public int value { get; set; }
        public string name { get; set; }
    }
}