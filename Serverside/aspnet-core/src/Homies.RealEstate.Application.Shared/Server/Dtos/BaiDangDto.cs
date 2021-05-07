using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class BaiDangDto : EntityDto
    {
        public string TagLoaiBaiDang { get; set; }

        public DateTime ThoiDiemDang { get; set; }

        public DateTime ThoiHan { get; set; }

        public string DiaChi { get; set; }

        public string MoTa { get; set; }

        public string ToaDoX { get; set; }

        public string ToaDoY { get; set; }

        public int? LuotXem { get; set; }

        public int? LuotYeuThich { get; set; }

        public decimal? DiemBaiDang { get; set; }

        public string TrangThai { get; set; }

        public string TagTimKiem { get; set; }

        public string TieuDe { get; set; }

        public long? UserId { get; set; }

        public int? DanhMucId { get; set; }

        public int? XaId { get; set; }

        public String FeaturedImage { get; set; }

        public double Gia { get; set; }

        public double DienTich { get; set; }

    }
}