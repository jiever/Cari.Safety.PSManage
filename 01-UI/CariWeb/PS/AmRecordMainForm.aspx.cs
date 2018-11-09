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
    public partial class AmRecordMainForm : System.Web.UI.Page
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
                var url =
                    $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetCoalKeys?strCoalName=";
                var responseDto = RequestToApi.Get(url);
                if (responseDto.StatusCode == "OK")
                {
                    var data = JsonConvert.DeserializeObject<List<CoalKeyDto>>(responseDto.Content);
                    _Mine.DataSource = data;
                    _Mine.DataBind();
                    _Mine.Items.Insert(0, new ListItem() {Text = "所有矿井", Value = ""});
                }
            }
            var sgbm = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=部门");
            if (sgbm.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(sgbm.Content);
                _Dept.DataSource = data;
                _Dept.DataBind();
            }
            var sgdj = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=事故性质");
            if (sgdj.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(sgdj.Content);
                _AmLevel.DataSource = data;
                _AmLevel.DataBind();
            }
        }
        private void LoadData()
        {
            int count = 0;
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Accident/GetAccidentByCusInfos";
            var data = new
            {
                key = _type ? _Mine.SelectedValue : _key,//_type 为true 综合页面
                strStart = _Start.Text,
                strEnd = _End.Text,
                arrDepts = _Dept.Text,
                arrLevel = _AmLevel.Text,
                nPageIndex = pageIndex,
                nPageSize = pagesize
            };

            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(data));
            if (responseDto.StatusCode == "OK")
            {
                if (responseDto.Content != null)
                {
                    var content = JsonConvert.DeserializeObject<AmDtoResult>(responseDto.Content);
                    if (content.OAccidentModels != null)
                    {
                        _Repeater.DataSource = content.OAccidentModels;
                        _Repeater.DataBind();
                        count = content.nTotal;
                    }
                }
                else
                {
                    LogManager.Error($"api/Accident/GetAccidentByCusInfos 取得数据为null,参数为：data={JsonConvert.SerializeObject(data)}");
                }
            }
            else
            {
                LogManager.Error(
                    $"api/Accident/GetAccidentByCusInfos status:{responseDto.StatusCode},参数为：data={JsonConvert.SerializeObject(data)}");
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