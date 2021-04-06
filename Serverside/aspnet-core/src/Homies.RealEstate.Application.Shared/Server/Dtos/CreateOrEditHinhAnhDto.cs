using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditHinhAnhDto : EntityDto<int?>
    {

        [Required]
        public string DuongDan { get; set; }

        public int? BaiDangId { get; set; }

    }
}