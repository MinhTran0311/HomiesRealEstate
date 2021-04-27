using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class ChiTietHoaDonBaiDangDto : EntityDto<Guid>
    {
        public DateTime ThoiDiem { get; set; }

        public double GiaGoi { get; set; }

        public int SoNgayMua { get; set; }

        public double TongTien { get; set; }

        public string GhiChu { get; set; }

        public int? BaiDangId { get; set; }

        public int? GoiBaiDangId { get; set; }

        public long? UserId { get; set; }

    }
}