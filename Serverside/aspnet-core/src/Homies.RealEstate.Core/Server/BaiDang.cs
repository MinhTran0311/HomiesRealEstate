using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.Server;
using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("BaiDangs")]
    public class BaiDang : Entity
    {

        [Required]
        [StringLength(BaiDangConsts.MaxTagLoaiBaiDangLength, MinimumLength = BaiDangConsts.MinTagLoaiBaiDangLength)]
        public virtual string TagLoaiBaiDang { get; set; }

        public virtual DateTime ThoiDiemDang { get; set; }

        public virtual DateTime ThoiHan { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxDiaChiLength, MinimumLength = BaiDangConsts.MinDiaChiLength)]
        public virtual string DiaChi { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxMoTaLength, MinimumLength = BaiDangConsts.MinMoTaLength)]
        public virtual string MoTa { get; set; }

        [Required]
        public virtual string ToaDoX { get; set; }

        [Required]
        public virtual string ToaDoY { get; set; }

        public virtual int? LuotXem { get; set; }

        public virtual int? LuotYeuThich { get; set; }

        public virtual decimal? DiemBaiDang { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxTrangThaiLength, MinimumLength = BaiDangConsts.MinTrangThaiLength)]
        public virtual string TrangThai { get; set; }

        public virtual string TagTimKiem { get; set; }

        [Required]
        [StringLength(BaiDangConsts.MaxTieuDeLength, MinimumLength = BaiDangConsts.MinTieuDeLength)]
        public virtual string TieuDe { get; set; }

        public virtual long? UserId { get; set; }

        [ForeignKey("UserId")]
        public User UserFk { get; set; }

        public virtual int? DanhMucId { get; set; }

        [ForeignKey("DanhMucId")]
        public DanhMuc DanhMucFk { get; set; }

        public virtual int? XaId { get; set; }

        [ForeignKey("XaId")]
        public Xa XaFk { get; set; }

        [Required]
        public virtual double Gia { get; set; }
        [Required]
        public virtual double DienTich { get; set; }
        [Required]
        public virtual String FeaturedImage { get; set; }

    }
}