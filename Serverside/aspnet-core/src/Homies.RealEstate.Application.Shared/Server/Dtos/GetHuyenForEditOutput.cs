using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetHuyenForEditOutput
    {
        public CreateOrEditHuyenDto Huyen { get; set; }

        public string TinhTenTinh { get; set; }

    }
}