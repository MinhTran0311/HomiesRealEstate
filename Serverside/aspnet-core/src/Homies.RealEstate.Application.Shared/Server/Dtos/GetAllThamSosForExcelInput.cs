using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllThamSosForExcelInput
    {
        public string Filter { get; set; }

        public string TenThamSoFilter { get; set; }

        public string KieuDuLieuFilter { get; set; }

        public string GiaTriFilter { get; set; }

    }
}