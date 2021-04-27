using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("Tinhs")]
    public class Tinh : Entity
    {

        [Required]
        [StringLength(TinhConsts.MaxTenTinhLength, MinimumLength = TinhConsts.MinTenTinhLength)]
        public virtual string TenTinh { get; set; }

    }
}