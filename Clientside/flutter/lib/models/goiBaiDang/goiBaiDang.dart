class GoiBaiDang {
  int id;
  String tenGoi;
  int phi;
  int doUuTien;
  int thoiGianToiThieu;
  String moTa;
  String trangThai;

  GoiBaiDang({
    this.id,
    this.tenGoi,
    this.phi,
    this.doUuTien,
    this.thoiGianToiThieu,
    this.moTa,
    this.trangThai,
  });

  factory GoiBaiDang.fromMap(Map<String, dynamic> json) => GoiBaiDang(
    id: json["id"],
    tenGoi: json["tenGoi"],
    phi: json["phi"],
    doUuTien: json["doUuTien"],
    thoiGianToiThieu: json["thoiGianToiThieu"],
    moTa: json["moTa"],
    trangThai: json["trangThai"],
  );
}