class Role {
  int id;
  String name;
  String displayName;
  bool isStatic;
  bool isDefault;
  String creationTime;

  Role ({
    this.id,
    this.name,
    this.displayName,
    this.isStatic,
    this.isDefault,
    this.creationTime,
  });

  factory Role.fromMap(Map<String, dynamic> json) => Role(
    id: json["id"],
    name: json["name"],
    displayName: json["displayName"],
    isStatic: json["isStatic"],
    isDefault: json["isDefault"],
    creationTime: json["creationTime"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "displayName": displayName,
    "isStatic": isStatic,
    "isDefault": isDefault,
    "creationTime": creationTime,
  };
}

