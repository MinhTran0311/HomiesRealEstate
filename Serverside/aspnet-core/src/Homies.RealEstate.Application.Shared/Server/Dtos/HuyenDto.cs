using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class HuyenDto : EntityDto
    {
        public string TenHuyen { get; set; }

        public int? TinhId { get; set; }

    }
}