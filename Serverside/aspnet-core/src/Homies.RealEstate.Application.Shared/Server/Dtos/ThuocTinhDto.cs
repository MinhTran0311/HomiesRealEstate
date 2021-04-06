using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class ThuocTinhDto : EntityDto
    {
        public string TenThuocTinh { get; set; }

        public string KieuDuLieu { get; set; }

        public string TrangThai { get; set; }

    }
}