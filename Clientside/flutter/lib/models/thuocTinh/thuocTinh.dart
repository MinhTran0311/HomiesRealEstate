class ThuocTinhManagement {
  int id;
  String tenThuocTinh;
  String kieuDuLieu;
  String trangThai;

  ThuocTinhManagement({
    this.id,
    this.tenThuocTinh,
    this.kieuDuLieu,
    this.trangThai,
  });

  factory ThuocTinhManagement.fromMap(Map<String, dynamic> json) => ThuocTinhManagement(
    id: json["id"],
    tenThuocTinh: json["tenThuocTinh"],
    kieuDuLieu: json["kieuDuLieu"],
    trangThai: json["trangThai"],
  );
}