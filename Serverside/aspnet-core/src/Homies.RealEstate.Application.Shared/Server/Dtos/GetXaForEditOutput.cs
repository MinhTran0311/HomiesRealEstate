using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetXaForEditOutput
    {
        public CreateOrEditXaDto Xa { get; set; }

        public string HuyenTenHuyen { get; set; }

    }
}