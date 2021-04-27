using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllHuyensForExcelInput
    {
        public string Filter { get; set; }

        public string TenHuyenFilter { get; set; }

        public string TinhTenTinhFilter { get; set; }

    }
}