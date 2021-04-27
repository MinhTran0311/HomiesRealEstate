using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditChiTietHoaDonBaiDangDto : EntityDto<Guid?>
    {

        public DateTime ThoiDiem { get; set; }

        public double GiaGoi { get; set; }

        [Range(ChiTietHoaDonBaiDangConsts.MinSoNgayMuaValue, ChiTietHoaDonBaiDangConsts.MaxSoNgayMuaValue)]
        public int SoNgayMua { get; set; }

        public double TongTien { get; set; }

        [Required]
        [StringLength(ChiTietHoaDonBaiDangConsts.MaxGhiChuLength, MinimumLength = ChiTietHoaDonBaiDangConsts.MinGhiChuLength)]
        public string GhiChu { get; set; }

        public int? BaiDangId { get; set; }

        public int? GoiBaiDangId { get; set; }

        public long? UserId { get; set; }

    }
}