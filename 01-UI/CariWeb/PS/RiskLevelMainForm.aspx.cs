using Cari.Safety.BLL.PSManage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Framework.Utility;
using Cari.Safety.DTO.PSManage;

namespace CariWeb.PS
{
    public partial class RiskLevelMainForm : System.Web.UI.Page
    {
        private string _key = "";
        protected bool _type = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            //区分综合页面
            if (!string.IsNullOrWhiteSpace(Request.QueryString["type"]))
            {
                _type = true;
            }
            //取矿的key
            if (!string.IsNullOrWhiteSpace(Request.QueryString["key"]))
            {
                _key = Request.QueryString["key"];
            }

            if (!IsPostBack)
            {
                InitData(_type);
            }
            LoadData();
        }

        private void InitData(bool type)
        {
            if (type)
            {
                var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=";
                var responseDto = RequestToApi.Get(url);
                if (responseDto.StatusCode == "OK")
                {
                    var data = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
                    _Mine.DataSource = data;
                    _Mine.DataBind();
                    _Mine.Items.Insert(0, new ListItem() { Text = "所有矿井", Value = "" });
                }
            }
        }

        private void LoadData()
        {
            int count = 0;
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var key = _type ? _Mine.SelectedValue : _key;
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Risk/GetRiskLevel?key={key}";

            var responseDto = RequestToApi.Get(url);
            if (responseDto.StatusCode == "OK")
            {
                LogManager.Info($"1{responseDto.StatusCode}");
                List<object> list = new List<object>();
                LogManager.Info($"2{responseDto.Content}");
                if (responseDto.Content != null)
                {
                    var jobject = JsonConvert.DeserializeObject<JObject>(responseDto.Content);

                    if (jobject != null)
                    {
                        var tokens = jobject.Values().Select(x => x != null ? x.Path : "").ToList();
                        LogManager.Info($"3{JsonConvert.SerializeObject(tokens)}");
                        var risknames = tokens.Where(x => !x.Contains("Score")).ToList();
                        foreach (var item in risknames)
                        {
                            var name = jobject[item].ToString(); // 风险级别等级
                            var min = jobject[item + "Score1"]; // 下限
                            var max = jobject[item + "Score2"]; // 上限

                            var model = new { Name = name, Min = min, Max = max };
                            list.Add(model);
                        }
                        _Repeater.DataSource = list.Skip(pagesize * (pageIndex - 1)).Take(pagesize);
                        _Repeater.DataBind();
                        count = list.Count;
                    }
                }
                else
                {
                    LogManager.Info($"api/Risk/GetRiskLevel 取得数据为null,参数为：key={key}");
                }
            }
            else
            {
                LogManager.Error(
                    $"api/Risk/GetRiskLevel status:{responseDto.StatusCode},参数为：key={key}");
            }
            PageTotal.Value = count.ToString();

        }

        protected void _RequestButton_Click(object sender, EventArgs e)
        {
            PageIndex.Value = "1";
            LoadData();
        }
    }
}