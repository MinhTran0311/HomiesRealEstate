using Homies.RealEstate.Server;
using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("ChiTietBaiDangs")]
    public class ChiTietBaiDang : Entity
    {

        [Required]
        public virtual string GiaTri { get; set; }

        public virtual int? ThuocTinhId { get; set; }

        [ForeignKey("ThuocTinhId")]
        public ThuocTinh ThuocTinhFk { get; set; }

        public virtual int? BaiDangId { get; set; }

        [ForeignKey("BaiDangId")]
        public BaiDang BaiDangFk { get; set; }

    }
}