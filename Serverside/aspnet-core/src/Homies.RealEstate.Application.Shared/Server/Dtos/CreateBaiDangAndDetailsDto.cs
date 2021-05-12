using System;
using System.Collections.Generic;
using System.Text;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateBaiDangAndDetailsDto
    {
        [Required]
        public CreateOrEditBaiDangDto BaiDang { get; set; }

        public List<CreateOrEditChiTietBaiDangDto> ChiTietBaiDangDtos { get; set; }

        [Required]
        public CreateOrEditChiTietHoaDonBaiDangDto HoaDonBaiDangDto { get; set; }

        [Required]
        public List<CreateOrEditHinhAnhDto> HinhAnhDtos { get; set; }
    }
}
