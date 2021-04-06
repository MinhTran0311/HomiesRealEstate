using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllTinhsInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string TenTinhFilter { get; set; }

    }
}