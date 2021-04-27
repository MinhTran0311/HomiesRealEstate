using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllThuocTinhsInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string TenThuocTinhFilter { get; set; }

        public string KieuDuLieuFilter { get; set; }

        public string TrangThaiFilter { get; set; }

    }
}