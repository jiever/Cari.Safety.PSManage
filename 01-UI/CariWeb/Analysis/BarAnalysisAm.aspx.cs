using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Safety.BLL.PSManage;
using Cari.Safety.DTO.PSManage;
using Newtonsoft.Json;

namespace CariWeb.Analysis
{
    public partial class BarAnalysisAm : System.Web.UI.Page
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
            var levels = new List<string>() { "一般事故", "重大事故", "特大事故", "特别重大事故" };
            var apiData = new Dictionary<string, List<int>>();
            var xAxisData = new List<string>(){};//矿名
            var series = new List<object>();

            var url =
                $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=";
            var responseDto = RequestToApi.Get(url);
            if (responseDto.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
                xAxisData.AddRange(data.Select(x=>x.CoalName));
            }

            for (int i = 0; i < xAxisData.Count; i++)
            {
                
            }
            
            for (int i = 0; i < levels.Count; i++)
            {
                var data =new List<int>();
                apiData.TryGetValue(xAxisData[i], out data);
                series.Add(new
                {
                    name = levels[i],
                    type = "bar",
                    data = data
                });
            }
            var result = new
            {
                xAxis = xAxisData,
                series = series,
                legend = levels
            };
            Response.Clear();
            Response.Write(JsonConvert.SerializeObject(result));
            Response.End();
        }
    }
}