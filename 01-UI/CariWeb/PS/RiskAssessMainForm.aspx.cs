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

namespace CariWeb.PS
{
    public partial class RiskAssessMainForm : System.Web.UI.Page
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
            var fxlx = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=风险类型");
            if (fxlx.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(fxlx.Content);
                _FXLX.DataSource = data;
                _FXLX.DataBind();
            }
            var zylx = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=专业类型");
            if (zylx.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(zylx.Content);
                _ZYLX.DataSource = data;
                _ZYLX.DataBind();
            }
        }

        private void LoadData()
        {
            int count = 0;
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Risk/GetRiskAssessmentByCusInfos";
            var data = new
            {
                key = _type ? _Mine.SelectedValue : _key,//_type 为true 综合页面
                nPageSize = pagesize,
                nPageIndex = pageIndex,
                arrYear = _Year.Text,
                arrFXLX = _FXLX.Text,
                arrZYLX = _ZYLX.Text,
                arrZRR = _ZRR.Text,
            };
            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(data));
            if (responseDto.StatusCode == "OK")
            {
                if (responseDto.Content != null)
                {
                    var content = JsonConvert.DeserializeObject<AssessDtoResult>(responseDto.Content);
                    if (content.oRiskAssessmentModels != null)
                    {
                        _Repeater.DataSource = content.oRiskAssessmentModels;
                        _Repeater.DataBind();
                        count = content.nTotal;
                    }
                }
                else
                {
                    LogManager.Error($"api/Risk/GetRiskAssessmentByCusInfos 取得数据为null,参数为：data={JsonConvert.SerializeObject(data)}");
                }
            }
            else
            {
                LogManager.Error(
                    $"api/Risk/GetRiskAssessmentByCusInfos status:{responseDto.StatusCode},参数为：data={JsonConvert.SerializeObject(data)}");
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