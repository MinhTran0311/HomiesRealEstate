class ThuocTinh {
  String tenThuocTinh;
  String kieuDuLieu;
  String trangThai;
  int id;
  ThuocTinh({
    this.tenThuocTinh,
    this.kieuDuLieu,
    this.trangThai,
    this.id,
  });

  factory ThuocTinh.fromMap(Map<String, dynamic> json) => ThuocTinh(
    tenThuocTinh: json["thuocTinh"]["tenThuocTinh"],
    kieuDuLieu: json["thuocTinh"]["kieuDuLieu"],
    trangThai: json["thuocTinh"]["trangThai"],
    id: json["thuocTinh"]["id"],
  );

  Map<String, dynamic> toMap() => {
    "tenThuocTinh": tenThuocTinh,
    "kieuDuLieu": kieuDuLieu,
    "trangThai": trangThai,
    "id": id,
  };

}
