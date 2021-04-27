using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetThuocTinhForEditOutput
    {
        public CreateOrEditThuocTinhDto ThuocTinh { get; set; }

    }
}