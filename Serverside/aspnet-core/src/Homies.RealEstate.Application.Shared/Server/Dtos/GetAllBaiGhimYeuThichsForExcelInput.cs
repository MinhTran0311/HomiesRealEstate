using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllBaiGhimYeuThichsForExcelInput
    {
        public string Filter { get; set; }

        public DateTime? MaxThoiGianFilter { get; set; }
        public DateTime? MinThoiGianFilter { get; set; }

        public string TrangThaiFilter { get; set; }

        public string UserNameFilter { get; set; }

        public string BaiDangTieuDeFilter { get; set; }

    }
}