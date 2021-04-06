using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class ChiTietBaiDangDto : EntityDto
    {
        public string GiaTri { get; set; }

        public int? ThuocTinhId { get; set; }

        public int? BaiDangId { get; set; }

    }
}