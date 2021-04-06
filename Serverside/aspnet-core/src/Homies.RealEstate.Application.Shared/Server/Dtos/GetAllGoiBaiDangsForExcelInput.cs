using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllGoiBaiDangsForExcelInput
    {
        public string Filter { get; set; }

        public string TenGoiFilter { get; set; }

        public double? MaxPhiFilter { get; set; }
        public double? MinPhiFilter { get; set; }

        public int? MaxDoUuTienFilter { get; set; }
        public int? MinDoUuTienFilter { get; set; }

        public int? MaxThoiGianToiThieuFilter { get; set; }
        public int? MinThoiGianToiThieuFilter { get; set; }

        public string MoTaFilter { get; set; }

        public string TrangThaiFilter { get; set; }

    }
}