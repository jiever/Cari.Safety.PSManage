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
    public partial class BarAnalysisRiskLevel : System.Web.UI.Page
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
            var levels = new List<string>() { "低风险", "一般风险", "较大风险", "重大风险" };
            var apiData = new Dictionary<string, List<int>>();
            var xAxisData = new List<string>(){};//矿名
            var series = new List<object>();
            //var mines = new List<CoalKeyDto>();

            //var responseDto = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=");
            //if (responseDto.StatusCode == "OK")
            //{
            //    mines = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
            //}
            //获取当年风险等级数据
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Risk/GetRiskCount";
            var postData = new
            {
                key = ConfigurationManager.AppSettings["AllMineKey"],
                arrYear = DateTime.Now.Year.ToString(),
            };
            var rDto = RequestToApi.Post(url, JsonConvert.SerializeObject(postData));
            var riskList = new List<AnalysisRiskDto>();
            if (rDto.StatusCode == "OK")
            {
                if (rDto.Content != null)
                {
                     var content = JsonConvert.DeserializeObject<List<AnalysisRiskDto>>(rDto.Content);
                    riskList = content.OrderBy(x => x.nIndex).ToList();
                }
            }

            var dData = new List<int>();
            var ybData = new List<int>();
            var jdData = new List<int>();
            var zdData = new List<int>();
            foreach (var item in riskList)
            {
                xAxisData.Add(item.strFrameName);
                dData.Add(item.nDFX);
                ybData.Add(item.nYBFX);
                jdData.Add(item.nJDFX);
                zdData.Add(item.nZDFX);
            }
            //for (int i = 0; i < mines.Count; i++)
            //{
            //    xAxisData.Add(mines[i].CoalName);
            //    var @default = riskList.FirstOrDefault(x => x.strFrameName == mines[i].CoalName);
            //    dData.Add(@default?.nDFX ?? 0);
            //    ybData.Add(@default?.nYBFX ?? 0);
            //    jdData.Add(@default?.nJDFX ?? 0);
            //    zdData.Add(@default?.nZDFX ?? 0);
            //}
            apiData.Add("低风险", dData);
            apiData.Add("一般风险", ybData);
            apiData.Add("较大风险", jdData);
            apiData.Add("重大风险", zdData);
            for (int i = 0; i < levels.Count; i++)
            {
                var data =new List<int>();
                apiData.TryGetValue(levels[i], out data);
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