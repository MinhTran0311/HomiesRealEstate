using Homies.RealEstate.Server;
using Homies.RealEstate.Server;
using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("ChiTietDanhMucs")]
    public class ChiTietDanhMuc : Entity
    {

        [StringLength(ChiTietDanhMucConsts.MaxGhiChuLength, MinimumLength = ChiTietDanhMucConsts.MinGhiChuLength)]
        public virtual string GhiChu { get; set; }

        public virtual int? ThuocTinhId { get; set; }

        [ForeignKey("ThuocTinhId")]
        public ThuocTinh ThuocTinhFk { get; set; }

        public virtual int? DanhMucId { get; set; }

        [ForeignKey("DanhMucId")]
        public DanhMuc DanhMucFk { get; set; }

    }
}