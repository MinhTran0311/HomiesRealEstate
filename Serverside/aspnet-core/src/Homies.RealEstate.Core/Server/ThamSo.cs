using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("ThamSos")]
    public class ThamSo : Entity
    {

        [Required]
        [StringLength(ThamSoConsts.MaxTenThamSoLength, MinimumLength = ThamSoConsts.MinTenThamSoLength)]
        public virtual string TenThamSo { get; set; }

        [Required]
        [StringLength(ThamSoConsts.MaxKieuDuLieuLength, MinimumLength = ThamSoConsts.MinKieuDuLieuLength)]
        public virtual string KieuDuLieu { get; set; }

        [Required]
        public virtual string GiaTri { get; set; }

    }
}