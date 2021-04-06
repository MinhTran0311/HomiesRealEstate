using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetChiTietBaiDangForEditOutput
    {
        public CreateOrEditChiTietBaiDangDto ChiTietBaiDang { get; set; }

        public string ThuocTinhTenThuocTinh { get; set; }

        public string BaiDangTieuDe { get; set; }

    }
}