using System;
using System.Collections.Generic;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class EditBaiDangAndDetailsDto
    {
        public CreateOrEditBaiDangDto BaiDang { get; set; }

        public List<CreateOrEditChiTietBaiDangDto> ChiTietBaiDangDtos { get; set; }

        public List<CreateOrEditHinhAnhDto> HinhAnhDtos { get; set; }
    }
}
