using System;
using Abp.Application.Services.Dto;

namespace Homies.RealEstate.Server.Dtos
{
    public class BaiGhimYeuThichDto : EntityDto
    {
        public DateTime ThoiGian { get; set; }

        public string TrangThai { get; set; }

        public long? UserId { get; set; }

        public int? BaiDangId { get; set; }

    }
}