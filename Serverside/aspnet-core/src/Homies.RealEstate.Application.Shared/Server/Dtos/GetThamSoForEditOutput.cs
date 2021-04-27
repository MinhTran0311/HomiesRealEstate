using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetThamSoForEditOutput
    {
        public CreateOrEditThamSoDto ThamSo { get; set; }

    }
}