using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllHinhAnhsForExcelInput
    {
        public string Filter { get; set; }

        public string DuongDanFilter { get; set; }

        public string BaiDangTieuDeFilter { get; set; }

    }
}