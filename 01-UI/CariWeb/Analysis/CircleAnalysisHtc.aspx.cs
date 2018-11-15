using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using Cari.Framework.Utility;
using Cari.Safety.BLL.PSManage;
using Cari.Safety.DTO.PSManage;
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
            //var url1 = "http://47.98.157.173:8010/api/order/getOrdersByPost";
            //var data = new Dto()
            //{
            //    ID = null,
            //    Name = ""
            //};
            //var ss = RequestToApi.Post(url1, JsonConvert.SerializeObject(data));
            //var result = new List<RspD>();
            //if (ss.StatusCode == "OK")
            //{
            //    var list = JsonConvert.DeserializeObject<List<Dto>>(ss.Content);
            //    result.AddRange(list.Select(x => new RspD()
            //    {
            //        value = x.ID.HasValue ? x.ID.Value : 0,
            //        name = x.Name
            //    }));
            //}

            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/HiddenTrouble/GetHiddenTroubleCount";
            var postData = new
            {
                key = ConfigurationManager.AppSettings["AllMineKey"],
                strStart = DateTime.Now.Date.ToString("yyyy-MM-dd HH:mm:ss"),
                strEnd = DateTime.Now.Date.AddDays(1).AddSeconds(-1).ToString("yyyy-MM-dd HH:mm:ss"),
            };
            var result = new List<CircleDto>();
            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(postData));
            if (responseDto.StatusCode == "OK")
            {
                if (responseDto.Content != null)
                {
                    var list = JsonConvert.DeserializeObject<List<AnalysisHtcDto>>(responseDto.Content);
                    result.AddRange(list.Select(x=>new CircleDto()
                    {
                        value = x.nYHCount,
                        name= x.strFrameName
                    }));
                }
                else
                {
                    LogManager.Error($"api/HiddenTrouble/GetHiddenTroubleCount 取得数据为null,参数为：data={JsonConvert.SerializeObject(postData)}");
                }
            }
            Response.Clear();
            Response.Write(JsonConvert.SerializeObject(result));
            Response.End();
        }
    }
}