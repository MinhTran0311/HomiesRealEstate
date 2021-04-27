using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllLichSuGiaoDichsInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public double? MaxSoTienFilter { get; set; }
        public double? MinSoTienFilter { get; set; }

        public DateTime? MaxThoiDiemFilter { get; set; }
        public DateTime? MinThoiDiemFilter { get; set; }

        public string GhiChuFilter { get; set; }

        public string UserNameFilter { get; set; }

        public string ChiTietHoaDonBaiDangGhiChuFilter { get; set; }

        public string UserName2Filter { get; set; }

    }
}