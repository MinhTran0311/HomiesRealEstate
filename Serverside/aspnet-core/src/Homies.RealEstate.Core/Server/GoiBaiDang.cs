using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Abp.Domain.Entities.Auditing;
using Abp.Domain.Entities;

namespace Homies.RealEstate.Server
{
    [Table("GoiBaiDangs")]
    public class GoiBaiDang : Entity
    {

        [Required]
        [StringLength(GoiBaiDangConsts.MaxTenGoiLength, MinimumLength = GoiBaiDangConsts.MinTenGoiLength)]
        public virtual string TenGoi { get; set; }

        public virtual double Phi { get; set; }

        [Range(GoiBaiDangConsts.MinDoUuTienValue, GoiBaiDangConsts.MaxDoUuTienValue)]
        public virtual int DoUuTien { get; set; }

        [Range(GoiBaiDangConsts.MinThoiGianToiThieuValue, GoiBaiDangConsts.MaxThoiGianToiThieuValue)]
        public virtual int ThoiGianToiThieu { get; set; }

        [Required]
        [StringLength(GoiBaiDangConsts.MaxMoTaLength, MinimumLength = GoiBaiDangConsts.MinMoTaLength)]
        public virtual string MoTa { get; set; }

        [Required]
        [StringLength(GoiBaiDangConsts.MaxTrangThaiLength, MinimumLength = GoiBaiDangConsts.MinTrangThaiLength)]
        public virtual string TrangThai { get; set; }

    }
}