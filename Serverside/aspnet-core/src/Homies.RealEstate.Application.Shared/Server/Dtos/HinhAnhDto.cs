using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class HinhAnhDto : EntityDto
    {
        public string DuongDan { get; set; }

        public int? BaiDangId { get; set; }

    }
}