using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class YearIdentityDto
    {
        public string FGuid { get; set; }
        public int ND { get; set; }
        public string DD { get; set; }
        public string ZCR { get; set; }
        public string JLR { get; set; }
        public string CHRY { get; set; }
        public string HYNR { get; set; }
        public string BZ { get; set; }
        public int FXSL => LstYearIdentityRisks.Count;
        public List<Risks> LstYearIdentityRisks { get; set; }
        public string StrLstYearIdentityRisks { get; set; }
    }

    public class Risks
    {
        public string FGuid { get; set; }
        public string FXDD { get; set; } 
        public string FXMS { get; set; }
        public string FXLX { get; set; }
        public string ZYLX { get; set; }
        public string GKCS { get; set; }
        public string FZR { get; set; }
        public string JGR { get; set; }
        public string JKZQ { get; set; }
        public bool ZT { get; set; }
        public string ZHLX { get; set; }
        public string KNDZSG  { get; set; }
    }

    public class YearIdentityDtoResult
    {
        public int nTotal { get; set; }
        public List<YearIdentityDto> oYearIdentityModels { get; set; }
    }
}
