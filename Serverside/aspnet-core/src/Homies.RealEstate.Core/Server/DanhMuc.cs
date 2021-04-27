using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("DanhMucs")]
    public class DanhMuc : Entity
    {

        [Required]
        [StringLength(DanhMucConsts.MaxTenDanhMucLength, MinimumLength = DanhMucConsts.MinTenDanhMucLength)]
        public virtual string TenDanhMuc { get; set; }

        public virtual string Tag { get; set; }

        [Required]
        [StringLength(DanhMucConsts.MaxTrangThaiLength, MinimumLength = DanhMucConsts.MinTrangThaiLength)]
        public virtual string TrangThai { get; set; }

        public virtual int? DanhMucCha { get; set; }

    }
}