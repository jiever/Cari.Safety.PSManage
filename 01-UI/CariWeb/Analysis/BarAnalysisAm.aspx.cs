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
            var mines = new List<CoalKeyDto>();
            
            var responseDto = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=");
            if (responseDto.StatusCode == "OK")
            {
                mines = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
            }
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/HiddenTrouble/GetHiddenTroubleCount";
            var postData = new
            {
                key = ConfigurationManager.AppSettings["AllMineKey"],
                strStart = DateTime.Now.AddYears(-2).Date.ToString("yyyy-MM-dd HH:mm:ss"),
                strEnd = DateTime.Now.Date.AddDays(1).AddSeconds(-1).ToString("yyyy-MM-dd HH:mm:ss"),
            };
            var rDto = RequestToApi.Post(url, JsonConvert.SerializeObject(postData));
            var amList = new List<AnalysisAmDto>();
            if (rDto.StatusCode == "OK")
            {
                if (rDto.Content != null)
                {
                    amList = JsonConvert.DeserializeObject<List<AnalysisAmDto>>(responseDto.Content);
                }
            }

            var ybData = new List<int>();
            var zdData = new List<int>();
            var tdData = new List<int>();
            var tbzdData = new List<int>();
            for (int i = 0; i < mines.Count; i++)
            {
                xAxisData.Add(mines[i].CoalName);
                var @default = amList.FirstOrDefault(x => x.strFrameName == mines[i].CoalName);

                ybData.Add(@default?.nYB ?? 0);
                zdData.Add(@default?.nZD ?? 0);
                tdData.Add(@default?.nTD ?? 0);
                tbzdData.Add(@default?.nTBZD ?? 0);
            }

            apiData.Add("一般事故", ybData);
            apiData.Add("重大事故", zdData);
            apiData.Add("特大事故", tdData);
            apiData.Add("特别重大事故", tbzdData);
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