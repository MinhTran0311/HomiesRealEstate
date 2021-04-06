using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllChiTietBaiDangsForExcelInput
    {
        public string Filter { get; set; }

        public string GiaTriFilter { get; set; }

        public string ThuocTinhTenThuocTinhFilter { get; set; }

        public string BaiDangTieuDeFilter { get; set; }

    }
}