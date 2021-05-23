using System;
using System.Collections.Generic;
using System.Text;

namespace Homies.RealEstate.Server.Dtos
{
    public class GetBaiGhimYeuThichForViewByUserDto
    {
        public BaiGhimYeuThichDto BaiGhimYeuThich { get; set; }

        public BaiDangDto BaiDang { get; set; }

        public string UserName { get; set; }

        public string XaTenXa { get; set; }

        public string HuyenTenHuyen { get; set; }

        public string TinhTenTinh { get; set; }

    }
}
