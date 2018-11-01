using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Web.UI;
using AjaxPro;
using Cari.Safety.Utility;

namespace CariWeb
{
    public partial class Default : BasePage
    {
        //private DefaultViewPresenter _presenter;
        protected  DataSet _systemInfo;
        DataSet _systemInfoLink;
        private Hashtable _userPageHt;


//        protected UserInfoBLL _ubll;

        protected Dictionary<string, string> UserInfo;

        protected string Mid = "";

        protected void Page_Load(object sender, EventArgs e)
        {
//            _ubll = UserInfoCache.GetInstance(this.User.Identity.Name);
            Mid = Request.QueryString["mid"];
            if (!IsPostBack)
            {
               if (Page.User.Identity.IsAuthenticated)
                {
                }
            }
            Utility.RegisterTypeForAjax(typeof(Default));
        }
        

   
    }
}
