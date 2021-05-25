using System;
using System.Collections.Generic;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class YearReportByUser
    {
        public List<MothReportDto> YearReport { get; set; }

        public String Username { get; set; }
        
        public long UserId { get; set; }
    }
}
