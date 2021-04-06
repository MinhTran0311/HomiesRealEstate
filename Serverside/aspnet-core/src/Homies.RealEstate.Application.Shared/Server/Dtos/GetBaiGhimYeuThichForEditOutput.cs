using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetBaiGhimYeuThichForEditOutput
    {
        public CreateOrEditBaiGhimYeuThichDto BaiGhimYeuThich { get; set; }

        public string UserName { get; set; }

        public string BaiDangTieuDe { get; set; }

    }
}