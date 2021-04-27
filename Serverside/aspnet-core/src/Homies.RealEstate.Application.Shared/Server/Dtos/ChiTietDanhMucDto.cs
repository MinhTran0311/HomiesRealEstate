using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class ChiTietDanhMucDto : EntityDto
    {
        public string GhiChu { get; set; }

        public int? ThuocTinhId { get; set; }

        public int? DanhMucId { get; set; }

    }
}