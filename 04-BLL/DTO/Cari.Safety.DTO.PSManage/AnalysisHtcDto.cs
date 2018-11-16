using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class AnalysisRiskDto
    {
        public string strFrameName { get; set; }
        public int nRiskCount { get; set; }
        public int nDFX { get; set; }
        public int nYBFX { get; set; }
        public int nJDFX { get; set; }
        public int nZDFX { get; set; }
        public int nIndex { get; set; }
    }
}
