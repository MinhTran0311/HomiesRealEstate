using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllBaiDangByCurrentUserInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public int? phanLoaiBaiDang { get; set; }
    }
}
