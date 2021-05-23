using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllXasInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string TenXaFilter { get; set; }

        public string HuyenTenHuyenFilter { get; set; }

        public int? HuyenIdFilter { get; set; }

    }
}