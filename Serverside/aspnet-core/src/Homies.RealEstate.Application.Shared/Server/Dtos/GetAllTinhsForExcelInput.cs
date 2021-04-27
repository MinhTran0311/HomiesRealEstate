using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllTinhsForExcelInput
    {
        public string Filter { get; set; }

        public string TenTinhFilter { get; set; }

    }
}