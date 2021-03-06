﻿using Cari.Safety.BLL.PSManage;
using Newtonsoft.Json;
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
    public partial class YearIdentityMainFrom : System.Web.UI.Page
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
            var url = $"{ConfigurationManager.AppSettings["IPToApi"].ToString()}/api/Risk/GetYearIdentityByCusInfos";
            var data = new 
            {
                Key = _type ? _Mine.SelectedValue : _key,//_type 为true 综合页面
                arrYear =_Year.Text
            };
            var responseDto = RequestToApi.Post(url, JsonConvert.SerializeObject(data));
            if (responseDto.StatusCode == "OK")
            {
                if (responseDto.Content != null)
                {
                    var content = JsonConvert.DeserializeObject<YearIdentityDtoResult>(responseDto.Content);
                   
                    if (content.oYearIdentityModels != null)
                    {
                        var list = content.oYearIdentityModels.Skip(pagesize * (pageIndex - 1)).Take(pagesize).ToList();
                        list.ForEach(x => x.StrLstYearIdentityRisks = JsonConvert.SerializeObject(x.LstYearIdentityRisks));
                        _Repeater.DataSource = list;
                        _Repeater.DataBind();
                        count = content.nTotal;
                    }
                }
                else
                {
                    LogManager.Error($"api/Risk/GetYearIdentityByCusInfos 取得数据为null,参数为：data={JsonConvert.SerializeObject(data)}");
                }
            }
            else
            {
                LogManager.Error(
                    $"api/Risk/GetYearIdentityByCusInfos status:{responseDto.StatusCode},参数为：data={JsonConvert.SerializeObject(data)}");
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