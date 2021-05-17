using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditLichSuGiaoDichDto : EntityDto<Guid?>
    {

        public double SoTien { get; set; }

        public DateTime ThoiDiem { get; set; }

        [Required]
        [StringLength(LichSuGiaoDichConsts.MaxGhiChuLength, MinimumLength = LichSuGiaoDichConsts.MinGhiChuLength)]
        public string GhiChu { get; set; }

        public long? UserId { get; set; }

        public Guid? ChiTietHoaDonBaiDangId { get; set; }

        public long? KiemDuyetVienId { get; set; }

    }
}