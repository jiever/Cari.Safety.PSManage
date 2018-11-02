using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class HtcData
    {
        private string Col;
        public string JCR { get; set; }
        public DateTime JCSJ { get; set; }
        public string JCLX { get; set; }
        public string YHDD { get; set; }
        public string YHJB { get; set; }
        public string YHLX { get; set; }
        public string SSZY { get; set; }
        public string YHNR { get; set; }
        public string ZGSJ { get; set; }
        public string ZGR { get; set; }
        public string FCSJ { get; set; }
        public string FCR { get; set; }
        public string ZGQK { get; set; }
        public string ZGJG { get; set; }
        public string FCJG { get; set; }

        public string Color
        {
            get
            {
                if (YHJB.Contains("A"))
                {
                    Col = "red";
                }
                else if(YHJB.Contains("B"))
                {
                    Col = "orange";
                }
                else if (YHJB.Contains("C"))
                {
                    Col = "yellow";
                }
                return Col;
            }
        }
    }

    public class HtcDataResult
    {
        public int nTotal { get; set; }
        public List<HtcData> oVhtDetailBoth { get; set; }
    }
}
