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
        }
        private void LoadData()
        {
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
                var content = JsonConvert.DeserializeObject<AmDtoResult>(responseDto.Content);

                _Repeater.DataSource = content.OAccidentModels;
                _Repeater.DataBind();
                PageTotal.Value = content.nTotal.ToString();
            }
        }


        protected void _RequestButton_Click(object sender, EventArgs e)
        {
            PageIndex.Value = "1";
            LoadData();
        }
    }
}