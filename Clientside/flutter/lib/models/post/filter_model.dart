class filter_Model {
  String loaiBaiDang;
  String searchContent;
  String giaMin;
  String giaMax;
  String dienTichMin;
  String dienTichMax;
  String tenTinh;
  String tenHuyen;
  String tenXa;
  String diaChi;
  String username;
  String tagTimKiem;
  String xMax;
  String yMax;
  String xMin;
  String yMin;

  filter_Model({
    this.searchContent="",
    this.loaiBaiDang="",
    this.giaMin="",
    this.giaMax="",
    this.dienTichMin="",
    this.dienTichMax="",
    this.tenTinh,
    this.tenHuyen,
    this.tenXa,
    this.diaChi="",
    this.username="",
    this.tagTimKiem="",
    this.xMax="",
    this.yMax="",
    this.xMin="",
    this.yMin="",
  });
  Map<String, dynamic> toMap({int skipCount = 0 , int maxCount = 10}) => {
    "Filter": searchContent,
    // "TieuDeFilter": searchContent,
    "TagLoaiBaiDangFilter": loaiBaiDang,
    "DiaChiFilter": diaChi,
    "MaxGiaFilter": giaMax,
    "MinGiaFilter": giaMin,
    "MaxDienTichFilter": dienTichMin,
    "MinDienTichFilter": dienTichMax,
    "UserNameFilter": username,
    "TenXaFilter": tenXa,
    "TenHuyenFilter": tenHuyen,
    "TenTinhFilter": tenTinh,

    "ToaDoXMinFilter": xMin,
    "ToaDoYMinFilter": yMin,
    "ToaDoXMaxFilter": xMax,
    "ToaDoYMaxFilter": yMax,

    "TagTimKiemFilter": tagTimKiem,
    "SkipCount": skipCount,
    "MaxResultCount": maxCount,

  };

}
