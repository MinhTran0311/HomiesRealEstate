using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.Server;
using Homies.RealEstate.Authorization.Users;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("LichSuGiaoDichs")]
    public class LichSuGiaoDich : Entity<Guid>
    {

        public virtual double SoTien { get; set; }

        public virtual DateTime ThoiDiem { get; set; }

        [Required]
        [StringLength(LichSuGiaoDichConsts.MaxGhiChuLength, MinimumLength = LichSuGiaoDichConsts.MinGhiChuLength)]
        public virtual string GhiChu { get; set; }

        public virtual long? UserId { get; set; }

        [ForeignKey("UserId")]
        public User UserFk { get; set; }

        public virtual Guid? ChiTietHoaDonBaiDangId { get; set; }

        [ForeignKey("ChiTietHoaDonBaiDangId")]
        public ChiTietHoaDonBaiDang ChiTietHoaDonBaiDangFk { get; set; }

        public virtual long? KiemDuyetVienId { get; set; }

        [ForeignKey("KiemDuyetVienId")]
        public User KiemDuyetVienFk { get; set; }

    }
}