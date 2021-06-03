using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllBaiGhimCurrentUserInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }
    }
}
