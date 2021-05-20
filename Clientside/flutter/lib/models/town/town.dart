class Town {
  String tenHuyen;
  int tinhId;
  int id;
  String tinhTenTinh;
  Town({
    this.tenHuyen,
    this.tinhId,
    this.id,
    this.tinhTenTinh,
  });

  factory Town.fromMap(Map<String, dynamic> json) => Town(

    tenHuyen: json["huyen"]["tenHuyen"],
    tinhId: json["huyen"]["tinhId"],
    id: json["huyen"]["id"],
    tinhTenTinh: json["tinhTenTinh"],
  );

  Map<String, dynamic> toMap() => {
    "tenHuyen": tenHuyen,
    "tinhId": tinhId,
    "id": id,
    "tinhTenTinh": tinhTenTinh,
  };

}
