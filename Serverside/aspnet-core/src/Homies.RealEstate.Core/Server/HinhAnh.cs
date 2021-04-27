using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("HinhAnhs")]
    public class HinhAnh : Entity
    {

        [Required]
        public virtual string DuongDan { get; set; }

        public virtual int? BaiDangId { get; set; }

        [ForeignKey("BaiDangId")]
        public BaiDang BaiDangFk { get; set; }

    }
}