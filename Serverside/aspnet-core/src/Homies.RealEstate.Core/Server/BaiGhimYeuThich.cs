using Homies.RealEstate.Authorization.Users;
using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("BaiGhimYeuThichs")]
    public class BaiGhimYeuThich : Entity
    {

        public virtual DateTime ThoiGian { get; set; }

        [Required]
        [StringLength(BaiGhimYeuThichConsts.MaxTrangThaiLength, MinimumLength = BaiGhimYeuThichConsts.MinTrangThaiLength)]
        public virtual string TrangThai { get; set; }

        public virtual long? UserId { get; set; }

        [ForeignKey("UserId")]
        public User UserFk { get; set; }

        public virtual int? BaiDangId { get; set; }

        [ForeignKey("BaiDangId")]
        public BaiDang BaiDangFk { get; set; }

    }
}