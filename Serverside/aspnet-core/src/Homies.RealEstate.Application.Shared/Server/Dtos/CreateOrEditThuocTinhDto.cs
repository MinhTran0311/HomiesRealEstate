using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditThuocTinhDto : EntityDto<int?>
    {

        [Required]
        [StringLength(ThuocTinhConsts.MaxTenThuocTinhLength, MinimumLength = ThuocTinhConsts.MinTenThuocTinhLength)]
        public string TenThuocTinh { get; set; }

        [Required]
        [StringLength(ThuocTinhConsts.MaxKieuDuLieuLength, MinimumLength = ThuocTinhConsts.MinKieuDuLieuLength)]
        public string KieuDuLieu { get; set; }

        [Required]
        [StringLength(ThuocTinhConsts.MaxTrangThaiLength, MinimumLength = ThuocTinhConsts.MinTrangThaiLength)]
        public string TrangThai { get; set; }

    }
}