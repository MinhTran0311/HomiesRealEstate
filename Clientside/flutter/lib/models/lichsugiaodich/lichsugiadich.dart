class lichsugiadich{
  String id;
  String chiTietHoaDonBaiDangId;
  int sotien;
  String idnguoigui;
  String idnguoikiemduyet;
  DateTime thoigianxacnhan;
  String ghichu;
  lichsugiadich({
  this.idnguoigui,
  this.idnguoikiemduyet,
  this.sotien,
  this.thoigianxacnhan,
  this.ghichu,
  this.id,
  this.chiTietHoaDonBaiDangId,
  });

  factory lichsugiadich.fromMap(Map<String, dynamic> json) => lichsugiadich(
    id: json["id"],
    sotien: json["soTien"],
    idnguoigui: json["userId"],
    idnguoikiemduyet: json["kiemDuyetVienId"],
    chiTietHoaDonBaiDangId: json["chiTietHoaDonBaiDangId"],
    thoigianxacnhan: json["thoiDiem"],
  );
}


class lichsugiadichs{
  String userName;
  String chiTietHoaDonBaiDangGhiChu;
  int userName2;
  lichsugiadich lichSuGiaoDich;
  lichsugiadichs({
    this.userName,
    this.chiTietHoaDonBaiDangGhiChu,
    this.userName2,
    this.lichSuGiaoDich,
  });

  factory lichsugiadichs.fromMap(Map<String, dynamic> json) => lichsugiadichs(
    userName: json["userName"],
    chiTietHoaDonBaiDangGhiChu: json["chiTietHoaDonBaiDangGhiChu"],
    userName2: json["userName2"],
    lichSuGiaoDich: json["lichSuGiaoDich"],
  );
}

class listlichsugiadichs{
  int totalCount;
  lichsugiadichs items;
  listlichsugiadichs({
    this.totalCount,
    this.items,
  });

  factory listlichsugiadichs.fromMap(Map<String, dynamic> json) => listlichsugiadichs(
    totalCount: json["totalCount"],
    items: json["items"],
  );
}




