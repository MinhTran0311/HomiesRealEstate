using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditChiTietBaiDangDto : EntityDto<int?>
    {

        [Required]
        public string GiaTri { get; set; }

        public int? ThuocTinhId { get; set; }

        public int? BaiDangId { get; set; }

    }
}