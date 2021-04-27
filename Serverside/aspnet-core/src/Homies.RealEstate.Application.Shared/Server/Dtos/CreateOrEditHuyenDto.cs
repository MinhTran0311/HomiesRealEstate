using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditHuyenDto : EntityDto<int?>
    {

        [Required]
        [StringLength(HuyenConsts.MaxTenHuyenLength, MinimumLength = HuyenConsts.MinTenHuyenLength)]
        public string TenHuyen { get; set; }

        public int? TinhId { get; set; }

    }
}