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
                    _Mine.Items.Insert(0, new ListItem(){Text = "所有矿井", Value = ""});
                }
            }
            var jclx = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=检查类型");
            if (jclx.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(jclx.Content);
                _CheckType.DataSource = data;
                _CheckType.DataBind();
            }
            var sszy = RequestToApi.Get($"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/common/GetDictionary?type=专业类型");
            if (sszy.StatusCode == "OK")
            {
                var data = JsonConvert.DeserializeObject<List<DictionaryDto>>(sszy.Content);
                _Major.DataSource = data;
                _Major.DataBind();
            }
        }

        private void LoadData()
        {
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/HiddenTrouble/GetHiddentroubleByCusInfos";
            var postData = new 
            {
                key = _type? "" : _key,//_type 为true 综合页面
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
                var content = JsonConvert.DeserializeObject<HtcDtoResult>(responseDto.Content);
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
