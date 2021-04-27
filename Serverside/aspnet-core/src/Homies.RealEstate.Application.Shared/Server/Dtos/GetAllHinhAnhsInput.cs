﻿using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllHinhAnhsInput : PagedAndSortedResultRequestDto
    {
        public string Filter { get; set; }

        public string DuongDanFilter { get; set; }

        public string BaiDangTieuDeFilter { get; set; }

    }
}