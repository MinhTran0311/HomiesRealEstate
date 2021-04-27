using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditTinhDto : EntityDto<int?>
    {

        [Required]
        [StringLength(TinhConsts.MaxTenTinhLength, MinimumLength = TinhConsts.MinTenTinhLength)]
        public string TenTinh { get; set; }

    }
}