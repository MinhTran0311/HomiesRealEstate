using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllBaiDangByFilterInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string TagLoaiBaiDangFilter { get; set; }

        public string DiaChiFilter { get; set; }

        public string ToaDoXMinFilter { get; set; }
        public string ToaDoXMaxFilter { get; set; }

        public string ToaDoYMinFilter { get; set; }
        public string ToaDoYMaxFilter { get; set; }

        public double? MaxGiaFilter { get; set; }
        public double? MinGiaFilter { get; set; }
        
        public double? MaxDienTichFilter { get; set; }
        public double? MinDienTichFilter { get; set; }

        public string TagTimKiemFilter { get; set; }

        public string TieuDeFilter { get; set; }

        public string UserNameFilter { get; set; }

        public string XaTenXaFilter { get; set; }

        public int? XaIdFilter { get; set; }

        public int? HuyenIdFilter { get; set; }

        public int? TinhTenTinhFilter { get; set; }

    }
}