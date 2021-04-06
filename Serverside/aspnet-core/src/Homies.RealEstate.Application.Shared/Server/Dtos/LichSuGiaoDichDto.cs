using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class LichSuGiaoDichDto : EntityDto<Guid>
    {
        public double SoTien { get; set; }

        public DateTime ThoiDiem { get; set; }

        public string GhiChu { get; set; }

        public long? UserId { get; set; }

        public Guid? ChiTietHoaDonBaiDangId { get; set; }

        public long? KiemDuyetVienId { get; set; }

    }
}