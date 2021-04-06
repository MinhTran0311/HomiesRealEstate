using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetHinhAnhForEditOutput
    {
        public CreateOrEditHinhAnhDto HinhAnh { get; set; }

        public string BaiDangTieuDe { get; set; }

    }
}