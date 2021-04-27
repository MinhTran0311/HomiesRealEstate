using Homies.RealEstate.Server;
using Homies.RealEstate.Server;
using Homies.RealEstate.Authorization.Users;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("ChiTietHoaDonBaiDangs")]
    public class ChiTietHoaDonBaiDang : Entity<Guid>
    {

        public virtual DateTime ThoiDiem { get; set; }

        public virtual double GiaGoi { get; set; }

        [Range(ChiTietHoaDonBaiDangConsts.MinSoNgayMuaValue, ChiTietHoaDonBaiDangConsts.MaxSoNgayMuaValue)]
        public virtual int SoNgayMua { get; set; }

        public virtual double TongTien { get; set; }

        [Required]
        [StringLength(ChiTietHoaDonBaiDangConsts.MaxGhiChuLength, MinimumLength = ChiTietHoaDonBaiDangConsts.MinGhiChuLength)]
        public virtual string GhiChu { get; set; }

        public virtual int? BaiDangId { get; set; }

        [ForeignKey("BaiDangId")]
        public BaiDang BaiDangFk { get; set; }

        public virtual int? GoiBaiDangId { get; set; }

        [ForeignKey("GoiBaiDangId")]
        public GoiBaiDang GoiBaiDangFk { get; set; }

        public virtual long? UserId { get; set; }

        [ForeignKey("UserId")]
        public User UserFk { get; set; }

    }
}