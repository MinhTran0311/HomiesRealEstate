using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditXaDto : EntityDto<int?>
    {

        [Required]
        [StringLength(XaConsts.MaxTenXaLength, MinimumLength = XaConsts.MinTenXaLength)]
        public string TenXa { get; set; }

        public int? HuyenId { get; set; }

    }
}