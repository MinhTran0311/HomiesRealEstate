using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetChiTietDanhMucForEditOutput
    {
        public CreateOrEditChiTietDanhMucDto ChiTietDanhMuc { get; set; }

        public string ThuocTinhTenThuocTinh { get; set; }

        public string DanhMucTenDanhMuc { get; set; }

    }
}