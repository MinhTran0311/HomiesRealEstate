using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetTinhForEditOutput
    {
        public CreateOrEditTinhDto Tinh { get; set; }

    }
}