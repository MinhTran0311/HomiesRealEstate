using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllChiTietHoaDonBaiDangsForExcelInput
    {
        public string Filter { get; set; }

        public DateTime? MaxThoiDiemFilter { get; set; }
        public DateTime? MinThoiDiemFilter { get; set; }

        public double? MaxGiaGoiFilter { get; set; }
        public double? MinGiaGoiFilter { get; set; }

        public int? MaxSoNgayMuaFilter { get; set; }
        public int? MinSoNgayMuaFilter { get; set; }

        public double? MaxTongTienFilter { get; set; }
        public double? MinTongTienFilter { get; set; }

        public string GhiChuFilter { get; set; }

        public string BaiDangTieuDeFilter { get; set; }

        public string GoiBaiDangTenGoiFilter { get; set; }

        public string UserNameFilter { get; set; }

    }
}