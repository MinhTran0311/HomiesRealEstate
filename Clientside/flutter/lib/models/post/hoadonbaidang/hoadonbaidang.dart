class Hoadonbaidang {
  String thoiDiem;
  double giaGoi;
  int soNgayMua;
  double tongTien;
  String ghiChu;
  int baiDangId;
  int goiBaiDangId;
  int userId;
  int id;
  Hoadonbaidang({
    this.thoiDiem,
    this.giaGoi,
    this.soNgayMua,
    this.tongTien,
    this.ghiChu,
    this.baiDangId,
    this.goiBaiDangId,
    this.userId,
    this.id,
  });

  factory Hoadonbaidang.fromMap(Map<String, dynamic> json) => Hoadonbaidang(

    thoiDiem: json["chiTietHoaDonBaiDang"]["thoiDiem"],
    giaGoi: json["chiTietHoaDonBaiDang"]["giaGoi"],
    soNgayMua: json["chiTietHoaDonBaiDang"]["soNgayMua"],
    tongTien: json["chiTietHoaDonBaiDang"]["tongTien"],
    ghiChu: json["chiTietHoaDonBaiDang"]["ghiChu"],
    baiDangId: json["chiTietHoaDonBaiDang"]["baiDangId"],
    goiBaiDangId: json["chiTietHoaDonBaiDang"]["goiBaiDangId"],
    userId: json["chiTietHoaDonBaiDang"]["userId"],
    id: json["chiTietHoaDonBaiDang"]["id"],

  );

  Map<String, dynamic> toMap() => {
    "thoiDiem": "$thoiDiem",
    "giaGoi": giaGoi,
    "soNgayMua": soNgayMua,
    "tongTien": tongTien,
    "ghiChu": "$ghiChu",
    "baiDangId": baiDangId,
    "goiBaiDangId": goiBaiDangId,
    "userId": userId,
    "id": id,
  };

}
