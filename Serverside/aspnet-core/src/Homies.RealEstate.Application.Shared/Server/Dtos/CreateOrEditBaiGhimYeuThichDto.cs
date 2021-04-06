using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditBaiGhimYeuThichDto : EntityDto<int?>
    {

        public DateTime ThoiGian { get; set; }

        [Required]
        [StringLength(BaiGhimYeuThichConsts.MaxTrangThaiLength, MinimumLength = BaiGhimYeuThichConsts.MinTrangThaiLength)]
        public string TrangThai { get; set; }

        public long? UserId { get; set; }

        public int? BaiDangId { get; set; }

    }
}