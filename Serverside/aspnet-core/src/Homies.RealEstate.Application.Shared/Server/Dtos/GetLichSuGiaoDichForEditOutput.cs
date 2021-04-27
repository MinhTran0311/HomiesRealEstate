using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetLichSuGiaoDichForEditOutput
    {
        public CreateOrEditLichSuGiaoDichDto LichSuGiaoDich { get; set; }

        public string UserName { get; set; }

        public string ChiTietHoaDonBaiDangGhiChu { get; set; }

        public string UserName2 { get; set; }

    }
}