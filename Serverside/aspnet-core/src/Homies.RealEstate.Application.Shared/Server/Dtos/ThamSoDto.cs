using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class ThamSoDto : EntityDto
    {
        public string TenThamSo { get; set; }

        public string KieuDuLieu { get; set; }

        public string GiaTri { get; set; }

    }
}