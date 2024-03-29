﻿using Abp.Application.Services.Dto;
using System;
using System.Collections.Generic;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllLSGDCurrentUserInput : PagedAndSortedResultRequestDto
    {
        public int? phanLoaiLSGD { get; set; }

        public DateTime? MaxThoiGianFilter { get; set; }
        public DateTime? MinThoiGianFilter { get; set; }
    }
}
