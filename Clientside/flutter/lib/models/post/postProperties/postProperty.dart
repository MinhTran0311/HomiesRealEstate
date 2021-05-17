class Property {
  String giaTri;
  int baiDangId;
  int thuocTinhId;
  int id;
  String thuocTinhTenThuocTinh;

  Property({
    this.giaTri,
    this.baiDangId,
    this.thuocTinhId,
    this.id,
    this.thuocTinhTenThuocTinh,

  });

  factory Property.fromMap(Map<String, dynamic> json) => Property(
    giaTri: json["chiTietBaiDang"]["giaTri"],
    baiDangId: json["chiTietBaiDang"]["baiDangId"],
    thuocTinhId: json["chiTietBaiDang"]["thuocTinhId"],
    id: json["chiTietBaiDang"]["id"],
    thuocTinhTenThuocTinh: json["thuocTinhTenThuocTinh"].toString(),
  );
  Map<String, dynamic> toMap() => {
    "giaTri": "$giaTri",
    "baiDangId": baiDangId,
    "thuocTinhId": thuocTinhId,
    "id": id,
  };

}
