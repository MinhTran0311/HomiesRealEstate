using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class DanhMucDto : EntityDto
    {
        public string TenDanhMuc { get; set; }

        public string Tag { get; set; }

        public string TrangThai { get; set; }

        public int? DanhMucCha { get; set; }

    }
}