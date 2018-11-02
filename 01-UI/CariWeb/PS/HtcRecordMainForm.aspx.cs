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
using Newtonsoft.Json.Linq;

namespace CariWeb.PS
{
    public partial class HtcRecordMainForm : System.Web.UI.Page
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
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/HiddenTrouble/GetHiddentroubleByCusInfos";
            var postData = new 
            {
                key = _key,
                strStart = _Start.Text,
                strEnd = _End.Text,
                arrCatagories = _Major.Text,
                arrCheckType = _CheckType.Text,
                nPageIndex = pageIndex,
                nPageSize = pagesize
            };

            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(postData));
            if (responseDto.StatusCode == "OK")
            {
                var content = JsonConvert.DeserializeObject<HtcDataResult>(responseDto.Content);
                var list = content.oVhtDetailBoth.OrderBy(x => x.YHJB).ThenByDescending(x=>x.JCSJ).ToList();
                
                _Repeater.DataSource = list;
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
