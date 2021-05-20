class AppImage {
  String duongDan;
  String baiDangId;
  String id;

  AppImage({
    this.duongDan,
    this.baiDangId,
    this.id
  });

  factory AppImage.fromMap(Map<String, dynamic> json) => AppImage(
    duongDan: json["duongDan"],
    baiDangId: json["baiDangId"].toString(),
    id: json["id"].toString(),
  );

  Map<String, dynamic> toMap() => {
    "duongDan": "$duongDan",
    "baiDangId": baiDangId,
    "id": id,
  };

}
