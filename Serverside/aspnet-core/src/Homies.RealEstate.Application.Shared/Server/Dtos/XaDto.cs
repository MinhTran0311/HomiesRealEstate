using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class XaDto : EntityDto
    {
        public string TenXa { get; set; }

        public int? HuyenId { get; set; }

    }
}