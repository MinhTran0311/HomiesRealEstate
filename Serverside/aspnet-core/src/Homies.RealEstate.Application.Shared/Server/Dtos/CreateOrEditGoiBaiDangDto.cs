using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditGoiBaiDangDto : EntityDto<int?>
    {

        [Required]
        [StringLength(GoiBaiDangConsts.MaxTenGoiLength, MinimumLength = GoiBaiDangConsts.MinTenGoiLength)]
        public string TenGoi { get; set; }

        public double Phi { get; set; }

        [Range(GoiBaiDangConsts.MinDoUuTienValue, GoiBaiDangConsts.MaxDoUuTienValue)]
        public int DoUuTien { get; set; }

        [Range(GoiBaiDangConsts.MinThoiGianToiThieuValue, GoiBaiDangConsts.MaxThoiGianToiThieuValue)]
        public int ThoiGianToiThieu { get; set; }

        [Required]
        [StringLength(GoiBaiDangConsts.MaxMoTaLength, MinimumLength = GoiBaiDangConsts.MinMoTaLength)]
        public string MoTa { get; set; }

        [Required]
        [StringLength(GoiBaiDangConsts.MaxTrangThaiLength, MinimumLength = GoiBaiDangConsts.MinTrangThaiLength)]
        public string TrangThai { get; set; }

    }
}