class lichsugiaodich{
  String id;
  int kiemDuyetVienId;
  String chiTietHoaDonBaiDangId;
  int userId;
  String ghiChu;
  String thoiDiem;
  double soTien;


  lichsugiaodich({
  this.id,
  this.kiemDuyetVienId,
  this.chiTietHoaDonBaiDangId,
  this.userId,
  this.ghiChu,
  this.thoiDiem,
  this.soTien,
  });

  factory lichsugiaodich.fromMap(Map<String, dynamic> json) => lichsugiaodich(
    id: json["lichSuGiaoDich"]["id"],
    kiemDuyetVienId: json["lichSuGiaoDich"]["kiemDuyetVienId"],
    chiTietHoaDonBaiDangId: json["lichSuGiaoDich"]["chiTietHoaDonBaiDangId"],
    userId: json["lichSuGiaoDich"]["userId"],
    ghiChu: json["lichSuGiaoDich"]["ghiChu"],
    thoiDiem: json["lichSuGiaoDich"]["thoiDiem"],
    soTien: json["lichSuGiaoDich"]["soTien"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kiemDuyetVienId": kiemDuyetVienId,
    "chiTietHoaDonBaiDangId": chiTietHoaDonBaiDangId,
    "userId": userId,
    "ghiChu": ghiChu,
    "thoiDiem": thoiDiem,
    "soTien": soTien,
  };
}


class listLSGD{
  final List<lichsugiaodich> lichsugiaodichs;

  listLSGD({
    this.lichsugiaodichs,
  });

  factory listLSGD.fromJson(Map<String, dynamic> json) {
    List<lichsugiaodich> lichsugiaodichs = List<lichsugiaodich>();
    print("DuongLSGD");
    print(json);
    //posts = json["result"]["items"].map((post) => Post.fromMap(post)).toList();
    //print(json["result"]["items"][0].runtimeType);
    for (int i =0; i<json["result"]["items"].length; i++) {
      lichsugiaodichs.add(lichsugiaodich.fromMap(json["result"]["items"][i]));
    }
    return listLSGD(
      lichsugiaodichs: lichsugiaodichs,
    );
  }
}






