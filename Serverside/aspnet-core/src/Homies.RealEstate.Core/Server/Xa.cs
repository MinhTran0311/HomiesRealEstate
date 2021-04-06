using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("Xas")]
    public class Xa : Entity
    {

        [Required]
        [StringLength(XaConsts.MaxTenXaLength, MinimumLength = XaConsts.MinTenXaLength)]
        public virtual string TenXa { get; set; }

        public virtual int? HuyenId { get; set; }

        [ForeignKey("HuyenId")]
        public Huyen HuyenFk { get; set; }

    }
}