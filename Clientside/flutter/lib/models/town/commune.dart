class Commune {
  String tenXa;
  int huyenId;
  int id;
  String huyenTenHuyen;
  Commune({
    this.tenXa,
    this.huyenId,
    this.id,
    this.huyenTenHuyen,
  });

  factory Commune.fromMap(Map<String, dynamic> json) => Commune(

    tenXa: json["xa"]["tenXa"],
    huyenId: json["xa"]["huyenId"],
    id: json["xa"]["id"],
    huyenTenHuyen: json["huyenTenHuyen"],
  );

  Map<String, dynamic> toMap() => {
    "tenXa": tenXa,
    "huyenId": huyenId,
    "id": id,
    "huyenTenHuyen": huyenTenHuyen,
  };

}
