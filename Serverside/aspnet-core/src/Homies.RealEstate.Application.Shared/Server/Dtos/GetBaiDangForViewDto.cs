namespace Homies.RealEstate.Server.Dtos
{
    public class GetBaiDangForViewDto
    {
        public BaiDangDto BaiDang { get; set; }

        public string UserName { get; set; }

        public string DanhMucTenDanhMuc { get; set; }

        public string XaTenXa { get; set; }

        public string HuyenTenHuyen { get; set; }

        public string TinhTenTinh { get; set; }

        public ChiTietHoaDonBaiDangDto ChiTietHoaDon { get; set; }
    }
}