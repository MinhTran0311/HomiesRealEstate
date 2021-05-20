class Postcategory {
  String tenDanhMuc;
  String tag;
  String trangThai;
  int danhMucCha;
  int id;
  Postcategory({
    this.tenDanhMuc,
    this.id,
    this.tag,
    this.trangThai,
    this.danhMucCha,
  });

  factory Postcategory.fromMap(Map<String, dynamic> json) => Postcategory(

    tenDanhMuc: json["danhMuc"]["tenDanhMuc"],
    tag: json["danhMuc"]["tag"],
    trangThai: json["danhMuc"]["trangThai"],
    danhMucCha: json["danhMuc"]["danhMucCha"],
    id: json["danhMuc"]["id"],
  );

  Map<String, dynamic> toMap() => {
    "tenDanhMuc": tenDanhMuc,
    "tag": tag,
    "trangThai": trangThai,
    "danhMucCha": danhMucCha,
    "id": id,
  };

}
