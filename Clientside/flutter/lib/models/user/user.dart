class User {
  int id;
  String name;
  String surName;
  String userName;
  String email;
  String phoneNumber;
  String profilePictureID;
  bool isActive;
  bool isEmailConfirmed;
  String creationTime;
  List<dynamic> permissionsList;
  String permissions;

  User({
    this.id,
    this.name,
    this.surName,
    this.userName,
    this.email,
    this.phoneNumber,
    this.profilePictureID,
    this.isActive,
    this.isEmailConfirmed,
    this.creationTime,
    this.permissionsList,
    this.permissions,
  });

  factory User.fromMap(Map<String, dynamic> json, String rolesName) => User(
    id: json["id"],
    name: json["name"],
    surName: json["surname"],
    userName: json["userName"],
    email: json["emailAddress"],
    phoneNumber: json["phoneNumber"],
    profilePictureID: json["profilePictureId"],
    isActive: json["isActive"],
    isEmailConfirmed: json["isEmailConfirmed"],
    creationTime: json["creationTime"],
    permissions: rolesName,
    permissionsList: json["roles"],
  );

  // factory User.fromJson(Map<String, dynamic> json) {
  //   return User(
  //     id: json["id"],
  //     name: json["name"],
  //     surName: json["surname"],
  //     userName: json["userName"],
  //     email: json["emailAddress"],
  //     phoneNumber: json["phoneNumber"],
  //     profilePictureID: json["profilePictureId"],
  //     isActive: json["isActive"],
  //     isEmailConfirmed: json["isEmailConfirmed"],
  //     creationTime: json["creationTime"],
  //   );
  // }

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "surname": surName,
    "userName": userName,
    "emailAddress": email,
    "phoneNumber": phoneNumber,
    "profilePictureId": profilePictureID,
    "isActive": isActive,
    "isEmailConfirmed": isEmailConfirmed,
    "creationTime": creationTime,
    "roles": permissionsList,
  };
}