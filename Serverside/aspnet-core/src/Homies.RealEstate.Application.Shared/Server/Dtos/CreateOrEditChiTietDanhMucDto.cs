using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditChiTietDanhMucDto : EntityDto<int?>
    {

        [StringLength(ChiTietDanhMucConsts.MaxGhiChuLength, MinimumLength = ChiTietDanhMucConsts.MinGhiChuLength)]
        public string GhiChu { get; set; }

        public int? ThuocTinhId { get; set; }

        public int? DanhMucId { get; set; }

    }
}