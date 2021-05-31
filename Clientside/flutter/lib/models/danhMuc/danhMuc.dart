class DanhMuc {
  int id;
  String tenDanhMuc;
  String tag;
  String trangThai;
  int danhMucCha;

  DanhMuc({
    this.id,
    this.tenDanhMuc,
    this.tag,
    this.trangThai,
    this.danhMucCha,
  });

  factory DanhMuc.fromMap(Map<String, dynamic> json) => DanhMuc(
    id: json["id"],
    tenDanhMuc: json["tenDanhMuc"],
    tag: json["tag"],
    trangThai: json["trangThai"],
    danhMucCha: json["danhMucCha"],
  );
}