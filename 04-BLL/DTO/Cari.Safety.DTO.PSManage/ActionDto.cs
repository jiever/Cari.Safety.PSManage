using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class ActionDto
    {
        public int FID { get; set; }
        public string BAQXWRY { get; set; }
        public string FSRQ { get; set; }
        public string BAQXWMS { get; set; }
        public string JCR { get; set; }
        public string BM { get; set; }
        public string BC { get; set; }
        public string CLYJ { get; set; }
        public string GZ { get; set; }
        public List<Fine> lstFine { get; set; }
        public string StrFines { get; set; }
    }

    public class Fine
    {
        public string XM { get; set; }
        public string ZW { get; set; }
        public string DW { get; set; }
        public string FKYY { get; set; }
        public string FKDW { get; set; }
        public string FKJE { get; set; }
        public string FKSJ { get; set; }
        public string JBR { get; set; }
        public string SFTZ { get; set; }
    }

    public class ActionDtoResult
    {
        public int nTotal { get; set; }
        public List<ActionDto> oThreeViolationModels { get; set; }
    }
}
