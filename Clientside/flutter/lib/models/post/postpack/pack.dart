class Pack {
  String tenGoi;
  double phi;
  int doUuTien;
  int thoiGianToiThieu;
  String moTa;
  String trangThai;
  int id;
  Pack({
    this.tenGoi,
    this.phi,
    this.doUuTien,
    this.thoiGianToiThieu,
    this.moTa,
    this.trangThai,
    this.id,
  });

  factory Pack.fromMap(Map<String, dynamic> json) => Pack(

    tenGoi: json["goiBaiDang"]["tenGoi"],
    phi: json["goiBaiDang"]["phi"],
    doUuTien: json["goiBaiDang"]["doUuTien"],
    thoiGianToiThieu: json["goiBaiDang"]["thoiGianToiThieu"],
    moTa: json["goiBaiDang"]["moTa"],
    trangThai: json["goiBaiDang"]["trangThai"],
    id: json["goiBaiDang"]["id"],

  );

  Map<String, dynamic> toMap() => {
    "goiBaiDang": tenGoi,
    "phi": phi,
    "doUuTien": doUuTien,
    "thoiGianToiThieu": thoiGianToiThieu,
    "moTa": moTa,
    "trangThai": trangThai,
    "id": id,
  };

}
