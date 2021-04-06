using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetChiTietHoaDonBaiDangForEditOutput
    {
        public CreateOrEditChiTietHoaDonBaiDangDto ChiTietHoaDonBaiDang { get; set; }

        public string BaiDangTieuDe { get; set; }

        public string GoiBaiDangTenGoi { get; set; }

        public string UserName { get; set; }

    }
}