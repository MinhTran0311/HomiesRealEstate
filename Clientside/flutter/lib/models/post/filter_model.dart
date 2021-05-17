class filter_Model {
  String loaiBaiDang;
  String searchContent;
  String giaMin;
  String giaMax;
  String dienTichMin;
  String dienTichMax;
  int tinhId;
  int huyenId;
  int xaId;
  String diaChi;
  String username;
  String tagTimKiem;

  filter_Model({
    this.searchContent="",
    this.loaiBaiDang="",
    this.giaMin="",
    this.giaMax="",
    this.dienTichMin="",
    this.dienTichMax="",
    this.tinhId,
    this.huyenId,
    this.xaId,
    this.diaChi="",
    this.username="",
    this.tagTimKiem="",
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
    "XaIdFilter": xaId,
    "HuyenIdFilter": huyenId,
    "TinhTenTinhFilter": tinhId,
    "MaxResultCount": 10,

    //"toaDoX": toaDoX,
    //"toaDoY": toaDoY,
    "TagTimKiemFilter": tagTimKiem,
    "SkipCount": skipCount,
    "MaxResultCount": maxCount,

  };

}
