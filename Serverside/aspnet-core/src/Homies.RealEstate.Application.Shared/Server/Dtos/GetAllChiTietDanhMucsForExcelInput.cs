using Abp.Application.Services.Dto;
using System;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetAllChiTietDanhMucsForExcelInput
    {
        public string Filter { get; set; }

        public string GhiChuFilter { get; set; }

        public string ThuocTinhTenThuocTinhFilter { get; set; }

        public string DanhMucTenDanhMucFilter { get; set; }

    }
}