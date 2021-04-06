using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetBaiDangForEditOutput
    {
        public CreateOrEditBaiDangDto BaiDang { get; set; }

        public string UserName { get; set; }

        public string DanhMucTenDanhMuc { get; set; }

        public string XaTenXa { get; set; }

    }
}