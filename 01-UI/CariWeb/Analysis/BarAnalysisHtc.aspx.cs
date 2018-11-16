using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Framework.Utility;
using Cari.Safety.BLL.PSManage;
using Cari.Safety.DTO.PSManage;
using Newtonsoft.Json;

namespace CariWeb.Analysis
{
    public partial class BarAnalysisHtc : System.Web.UI.Page
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
            var levels = new List<string>() { "A", "B", "C", "D" };
            var apiData = new Dictionary<string, List<int>>();
            var xAxisData = new List<string>(){};//矿名
            var series = new List<object>();
            //var mines = new List<CoalKeyDto>();
            
            //var responseDto = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=");
            //if (responseDto.StatusCode == "OK")
            //{
            //    mines = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
            //}
            //获取当天隐患数据
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/HiddenTrouble/GetHiddenTroubleCount";
            var postData = new
            {
                key = ConfigurationManager.AppSettings["AllMineKey"],
                strStart = DateTime.Now.Date.AddDays(-7).ToString("yyyy-MM-dd HH:mm:ss"),
                strEnd = DateTime.Now.Date.AddDays(1).AddSeconds(-1).ToString("yyyy-MM-dd HH:mm:ss"),
            };
            var rDto = RequestToApi.Post(url, JsonConvert.SerializeObject(postData));
            var htcList = new List<AnalysisHtcDto>();
            if (rDto.StatusCode == "OK")
            {
                if (rDto.Content != null)
                {
                    var content = JsonConvert.DeserializeObject<List<AnalysisHtcDto>>(rDto.Content);
                    htcList = content.OrderBy(x => x.nIndex).ToList();
                }
            }

            var aData = new List<int>();
            var bData = new List<int>();
            var cData = new List<int>();
            var dData = new List<int>();
            foreach (var item in htcList)
            {
                xAxisData.Add(item.strFrameName);
                aData.Add(item.nA);
                bData.Add(item.nB);
                cData.Add(item.nC);
                dData.Add(item.nD);
            }

            //for (int i = 0; i < mines.Count; i++)
            //{
            //    xAxisData.Add(mines[i].CoalName);
            //    var @default = htcList.FirstOrDefault(x => x.strFrameName == mines[i].CoalName);
            //    aData.Add(@default?.nA ?? 0);
            //    bData.Add(@default?.nB ?? 0);
            //    cData.Add(@default?.nC ?? 0);
            //    dData.Add(@default?.nD ?? 0);
            //}
            apiData.Add("A", aData);
            apiData.Add("B", bData);
            apiData.Add("C", cData);
            apiData.Add("D", dData);
            for (int i = 0; i < levels.Count; i++)
            {
                List<int> data;
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
            LogManager.Info($"BarAnalysisHtc Data:{JsonConvert.SerializeObject(result)}");
            Response.Clear();
            Response.Write(JsonConvert.SerializeObject(result));
            Response.End();
        }
    }
}