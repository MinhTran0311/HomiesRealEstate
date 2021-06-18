using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllDanhMucForViewInput 
    {
        public string Filter { get; set; }

        public string TenDanhMucFilter { get; set; }

        public string TagFilter { get; set; }

        public string TrangThaiFilter { get; set; }

        public int? MaxDanhMucChaFilter { get; set; }
        public int? MinDanhMucChaFilter { get; set; }

    }
}