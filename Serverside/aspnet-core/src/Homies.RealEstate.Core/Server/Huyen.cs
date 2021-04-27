using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("Huyens")]
    public class Huyen : Entity
    {

        [Required]
        [StringLength(HuyenConsts.MaxTenHuyenLength, MinimumLength = HuyenConsts.MinTenHuyenLength)]
        public virtual string TenHuyen { get; set; }

        public virtual int? TinhId { get; set; }

        [ForeignKey("TinhId")]
        public Tinh TinhFk { get; set; }

    }
}