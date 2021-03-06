﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Cari.Safety.DTO.PSManage
{
    public class AmDto
    {
        public string SGFSSJ { get; set; }
        public string SGFSDD { get; set; }
        public string SGZRBM { get; set; }
        public string SGMS { get; set; }
        public string SGJJCS { get; set; }
        public string XB { get; set; }
        public string XM { get; set; }
        public string NL { get; set; }
        public string GZ { get; set; }
        public string SSBW { get; set; }
        public string SSCD { get; set; }
        public string SGJB { get; set; }
        public string SSZY { get; set; }
    }

    public class AmDtoResult
    {
        public int nTotal { get; set; }
        public List<AmDto> OAccidentModels { get; set; }
    }
}
