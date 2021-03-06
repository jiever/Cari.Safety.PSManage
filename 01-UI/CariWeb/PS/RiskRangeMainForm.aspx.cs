﻿using System;
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
    public partial class RiskRangeMainForm : System.Web.UI.Page
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
                }
            }
        }

        private void LoadData()
        {
            int count = 0;
            int pagesize = 10;
            var pageIndex = Cari.Safety.Utility.Utils.GetInt(this.PageIndex.Value, 1);

            var key = _type ? _Mine.SelectedValue : _key;
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Risk/GetRiskRange?key={key}";
            var responseDto = RequestToApi.Get(url);
            if (responseDto.StatusCode == "OK")
            {
                if (responseDto.Content != null)
                {
                    var content = JsonConvert.DeserializeObject<RiskRangeDtoResult>(responseDto.Content);
                    if (content.oRiskRangeModels != null)
                    {
                        var list = content.oRiskRangeModels.Skip(pagesize * (pageIndex - 1)).Take(pagesize);
                        _Repeater.DataSource = list;
                        _Repeater.DataBind();
                        count = content.nTotal;
                    }
                }
                else
                {
                    LogManager.Error($"api/Risk/GetRiskRange 取得数据为null,参数为：key={key}");
                }
            }
            else
            {
                LogManager.Error(
                    $"api/Risk/GetRiskRange status:{responseDto.StatusCode},参数为：key={key}");
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