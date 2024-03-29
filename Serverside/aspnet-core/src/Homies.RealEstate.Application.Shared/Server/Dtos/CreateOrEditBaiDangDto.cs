﻿using System;
using Abp.Application.Services.Dto;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;

namespace Homies.RealEstate.Server.Dtos
{
    public class CreateOrEditBaiDangDto : EntityDto<int?>
    {

        [Required]
        [StringLength(BaiDangConsts.MaxTagLoaiBaiDangLength, MinimumLength = BaiDangConsts.MinTagLoaiBaiDangLength)]
        public string TagLoaiBaiDang { get; set; }

        [Required]
        public DateTime ThoiDiemDang { get; set; }

        [Required]
        public DateTime ThoiHan { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxDiaChiLength, MinimumLength = BaiDangConsts.MinDiaChiLength)]
        public string DiaChi { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxMoTaLength, MinimumLength = BaiDangConsts.MinMoTaLength)]
        public string MoTa { get; set; }

        [Required]
        public string ToaDoX { get; set; }

        [Required]
        public string ToaDoY { get; set; }

        public int? LuotXem { get; set; }

        public int? LuotYeuThich { get; set; }

        public decimal? DiemBaiDang { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxTrangThaiLength, MinimumLength = BaiDangConsts.MinTrangThaiLength)]
        public string TrangThai { get; set; }
        
        public string TagTimKiem { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxTieuDeLength, MinimumLength = BaiDangConsts.MinTieuDeLength)]
        public string TieuDe { get; set; }

        [Required]
        public long UserId { get; set; }

        public int? DanhMucId { get; set; }

        [Required]
        public int XaId { get; set; }

        [Required]
        public String FeaturedImage { get; set; }
        [Required]
        public double Gia { get; set; }
        [Required]
        public double DienTich { get; set; }

    }
}