using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditThamSoDto : EntityDto<int?>
    {

        [Required]
        [StringLength(ThamSoConsts.MaxTenThamSoLength, MinimumLength = ThamSoConsts.MinTenThamSoLength)]
        public string TenThamSo { get; set; }

        [Required]
        [StringLength(ThamSoConsts.MaxKieuDuLieuLength, MinimumLength = ThamSoConsts.MinKieuDuLieuLength)]
        public string KieuDuLieu { get; set; }

        [Required]
        public string GiaTri { get; set; }

    }
}