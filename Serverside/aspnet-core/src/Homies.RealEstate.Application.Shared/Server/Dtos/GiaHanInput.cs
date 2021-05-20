using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class GiaHanInput
    {
        //public CreateOrEditBaiDangDto BaiDang { get; set; }
        [Required]
        public int baiDangId;
        [Required]
        public DateTime ThoiHan { get; set; }

        [Required]
        public CreateOrEditLichSuGiaoDichDto LichSuGiaoDichDto { get; set; }

        [Required]
        public CreateOrEditChiTietHoaDonBaiDangDto HoaDonBaiDangDto { get; set; }
    }
}
