using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllBaiDangsForExcelInput
    {
        public string Filter { get; set; }

        public string TagLoaiBaiDangFilter { get; set; }

        public DateTime? MaxThoiDiemDangFilter { get; set; }
        public DateTime? MinThoiDiemDangFilter { get; set; }

        public DateTime? MaxThoiHanFilter { get; set; }
        public DateTime? MinThoiHanFilter { get; set; }

        public string DiaChiFilter { get; set; }

        public string MoTaFilter { get; set; }

        public string ToaDoXFilter { get; set; }

        public string ToaDoYFilter { get; set; }

        public int? MaxLuotXemFilter { get; set; }
        public int? MinLuotXemFilter { get; set; }

        public int? MaxLuotYeuThichFilter { get; set; }
        public int? MinLuotYeuThichFilter { get; set; }

        public decimal? MaxDiemBaiDangFilter { get; set; }
        public decimal? MinDiemBaiDangFilter { get; set; }

        public string TrangThaiFilter { get; set; }

        public string TagTimKiemFilter { get; set; }

        public string TieuDeFilter { get; set; }

        public string UserNameFilter { get; set; }

        public string DanhMucTenDanhMucFilter { get; set; }

        public string XaTenXaFilter { get; set; }

    }
}