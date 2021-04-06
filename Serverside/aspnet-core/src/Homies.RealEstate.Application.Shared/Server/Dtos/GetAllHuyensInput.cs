using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllHuyensInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string TenHuyenFilter { get; set; }

        public string TinhTenTinhFilter { get; set; }

    }
}