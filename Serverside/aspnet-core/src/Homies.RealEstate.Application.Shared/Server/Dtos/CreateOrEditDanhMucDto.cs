using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditDanhMucDto : EntityDto<int?>
    {

        [Required]
        [StringLength(DanhMucConsts.MaxTenDanhMucLength, MinimumLength = DanhMucConsts.MinTenDanhMucLength)]
        public string TenDanhMuc { get; set; }

        public string Tag { get; set; }

        [Required]
        [StringLength(DanhMucConsts.MaxTrangThaiLength, MinimumLength = DanhMucConsts.MinTrangThaiLength)]
        public string TrangThai { get; set; }

        public int? DanhMucCha { get; set; }

    }
}