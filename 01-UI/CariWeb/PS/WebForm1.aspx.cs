using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Cari.Safety.BLL.PSManage;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace CariWeb.PS
{
    public partial class WebForm1 : System.Web.UI.Page
    {
        protected bool _type = false;
        protected void Page_Load(object sender, EventArgs e)
        {
            //区分综合页面
            if (!string.IsNullOrWhiteSpace(Request.QueryString["type"]))
            {
                _type = true;
            }
            var score = new
            {
                F1 = "低风险",
                F2 = "一般风险",
                F3 = "较大风险",
                F4 ="重大风险",
                F1Score1 = 3,
                F2Score1 = 3,
                F2Score2 = 7,
                F3Score1 = 9,
                F3Score2 = 18,
                F4Score2 = 15,
            };

            var scire = JsonConvert.SerializeObject(score);
            List<object> listS = new List<object>();

            var jobject = JObject.Parse(scire);
            var tokens = jobject.Values().Select(x => x.Path).ToList();

            var risknames = tokens.Where(x => !x.Contains("Score")).ToList();
            foreach (var item in risknames)
            {
                var name = jobject[item].ToString(); // 风险级别等级
                var min = jobject[item + "Score1"]; // 下限
                var max = jobject[item + "Score2"]; // 上限

                var model = new { Name = name, Min = min, Max = max };
                listS.Add(model);
            }


            var json = new
            {
                nTotal=2,
                data = new List<Dto>() { new Dto(){ID = 1,Name = "jiangwei"},new Dto(){ID = 2,Name = "jiever"}}
            };
            var da = JsonConvert.SerializeObject(json);

            var content = JsonConvert.DeserializeObject<Result>(da);

            //var totla = content["nTotal"].ToString();
           // var rs = JsonConvert.DeserializeObject<List<Dto>>(content["data"].ToString()) ;
            //rs = rs.OrderByDescending(x => x.ID).ToList();


            List<string> strs = new List<string>(){"B级","C级","A级","D级","B", "C" };
            var order = strs.OrderBy(x => x);

            //var url = "http://47.98.157.173:8010/api/order/getorders";
            //var s = RequestToApi.Get(url);

            

            var url1 = "http://47.98.157.173:8010/api/order/getOrdersByPost";
            var data = new Dto()
            {
                ID =string.IsNullOrWhiteSpace(_Fruit.SelectedValue)?(int?)null: Int32.Parse(_Fruit.SelectedValue),
                Name = string.IsNullOrWhiteSpace(_Fruit.SelectedValue) ? "":_Fruit.SelectedItem.Text
            };
            var ss = RequestToApi.Post(url1, JsonConvert.SerializeObject(data));
            if (ss.StatusCode == "OK")
            {
                var list = JsonConvert.DeserializeObject<List<Dto>>(ss.Content);
                list.ForEach(x=>x.Childs  = JsonConvert.SerializeObject(ss.Content));
                if (!IsPostBack)
                {
                    if (_type)
                    {
                       
                            _Mine.DataSource = list;
                            _Mine.DataBind();
                            _Mine.Items.Insert(0, new ListItem() { Text = "所有矿井", Value = "" });
                        
                    }
                    _Fruit.DataSource = list;
                    _Fruit.DataBind();
                }

                _Repeater.DataSource = list;
                _Repeater.DataBind();
            }
        }

        protected void _RequestButton_Click(object sender, EventArgs e)
        {
            
        }
    }

    public class Result
    {
        public string nTotal { get; set; }
        public List<Dto> Data{ get; set; }
    }
    public class Dto
    {
        private string Col;
        public int? ID { get; set; }
        public string Name { get; set; }

        public string Color
        {
            get
            {
                switch (ID)
                {
                    case 1:
                        Col = "red";
                        break;
                    case 2:
                        Col = "yellow";
                        break;
                    case 4:
                        Col = "orange";
                        break;
                }
                return Col;
            }
        }

        public string Childs { get; set; }
    }
}