using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class RiskRangeDto
    {
        public string BSMC { get; set; }
        public string MS { get; set; }
        public string LX { get; set; }
        public string KSSJ { get; set; }
        public string JSSJ { get; set; }
    }

    public class RiskRangeDtoResult
    {
        public int nTotal { get; set; }
        public string oRiskRangeModels { get; set; }
    }
}
