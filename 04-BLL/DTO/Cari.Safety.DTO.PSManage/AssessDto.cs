using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class AssessDto
    {
        public string ND { get; set; }
        public string FXLY { get; set; }
        public string FXDD { get; set; }
        public string FXMS { get; set; }
        public string FXLX { get; set; }
        public string ZYLX { get; set; }
        public string ZHLX { get; set; }
        public string KNDZSG { get; set; }
        public string GLCS { get; set; }
        public string ZRR { get; set; }
        public string FXJB { get; set; }
    }

    public class AssessDtoResult
    {
        public int nTotal { get; set; }
        public List<AssessDto> oRiskAssessmentModels { get; set; }
    }
}
