using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("ThuocTinhs")]
    public class ThuocTinh : Entity
    {

        [Required]
        [StringLength(ThuocTinhConsts.MaxTenThuocTinhLength, MinimumLength = ThuocTinhConsts.MinTenThuocTinhLength)]
        public virtual string TenThuocTinh { get; set; }

        [Required]
        [StringLength(ThuocTinhConsts.MaxKieuDuLieuLength, MinimumLength = ThuocTinhConsts.MinKieuDuLieuLength)]
        public virtual string KieuDuLieu { get; set; }

        [Required]
        [StringLength(ThuocTinhConsts.MaxTrangThaiLength, MinimumLength = ThuocTinhConsts.MinTrangThaiLength)]
        public virtual string TrangThai { get; set; }

    }
}