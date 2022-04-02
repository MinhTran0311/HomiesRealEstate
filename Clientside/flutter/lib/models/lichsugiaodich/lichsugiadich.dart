class lichsugiaodich{
  String id;
  int kiemDuyetVienId;
  String chiTietHoaDonBaiDangId;
  int userId;
  String ghiChu;
  String thoiDiem;
  double soTien;
  String UserName;
  String UserNameKiemDuyet;
  String chiTietHoaDonBaiDangName;


  lichsugiaodich({
    this.id,
    this.kiemDuyetVienId,
    this.chiTietHoaDonBaiDangId,
    this.userId,
    this.ghiChu,
    this.thoiDiem,
    this.soTien,
    this.UserName,
    this.UserNameKiemDuyet,
    this.chiTietHoaDonBaiDangName,
  });

  factory lichsugiaodich.fromMap(Map<String, dynamic> json) => lichsugiaodich(
    id: json["lichSuGiaoDich"]["id"],
    kiemDuyetVienId: json["lichSuGiaoDich"]["kiemDuyetVienId"],
    chiTietHoaDonBaiDangId: json["lichSuGiaoDich"]["chiTietHoaDonBaiDangId"],
    userId: json["lichSuGiaoDich"]["userId"],
    ghiChu: json["lichSuGiaoDich"]["ghiChu"],
    thoiDiem: json["lichSuGiaoDich"]["thoiDiem"],
    soTien: json["lichSuGiaoDich"]["soTien"],
    UserName: json["userName"],
    UserNameKiemDuyet: json["userName2"],
    chiTietHoaDonBaiDangName: json["chiTietHoaDonBaiDangGhiChu"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "kiemDuyetVienId": kiemDuyetVienId,
    "chiTietHoaDonBaiDangId": chiTietHoaDonBaiDangId,
    "userId": userId,
    "ghiChu": "$ghiChu",
    "thoiDiem": "$thoiDiem",
    "soTien": soTien,
  };
}


class listLSGD{
  final List<lichsugiaodich> listLSGDs;

  listLSGD({
    this.listLSGDs,
  });

  factory listLSGD.fromJson(Map<String, dynamic> json) {
    List<lichsugiaodich> listLSGDs = List<lichsugiaodich>();
    //posts = json["result"]["items"].map((post) => Post.fromMap(post)).toList();
    //print(json["result"]["items"][0].runtimeType);
    for (int i =0; i<json["result"]["items"].length; i++) {
      listLSGDs.add(lichsugiaodich.fromMap(json["result"]["items"][i]));
    }
    return listLSGD(
      listLSGDs: listLSGDs,
    );
  }
}






