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
                InitData();
            }
            LoadData();
        }

        private void InitData()
        {

        }
        private void LoadData()
        {
            int count = 0;
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Accident/GetAccidentByCusInfos";
            var data = new AmQueryDto()
            {
                key = _key,
                strStart = _Start.Text,
                strEnd = _End.Text,
                arrDepts = _Dept.Text,
                arrLevel = _AmLevel.Text
            };

            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(data));
            if (responseDto.StatusCode == "OK")
            {
                var list = JsonConvert.DeserializeObject(responseDto.Content);

                _Repeater.DataSource = list;
                _Repeater.DataBind();
            }
        }


        protected void _RequestButton_Click(object sender, EventArgs e)
        {
            PageIndex.Value = "1";
            LoadData();
        }
    }
}