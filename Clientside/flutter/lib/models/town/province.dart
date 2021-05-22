class Province {
  String tenTinh;
  int id;
  Province({
    this.id,
    this.tenTinh,
  });

  factory Province.fromMap(Map<String, dynamic> json) => Province(
    tenTinh: json["tinh"]["tenTinh"],
    id: json["tinh"]["id"],
  );

  Map<String, dynamic> toMap() => {
    "tenTinh": tenTinh,
    "id": id,
  };
}
