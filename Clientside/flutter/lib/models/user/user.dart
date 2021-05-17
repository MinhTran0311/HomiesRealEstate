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

  // List<String> permissions;

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
  factory User.UserByIDfromMap(Map<String, dynamic> json) => User(
    id: json["result"]["user"]["id"],
    name: json["result"]["user"]["name"],
    surName: json["result"]["user"]["surname"],
    userName: json["result"]["user"]["userName"],
    email: json["result"]["user"]["emailAddress"],
    phoneNumber: json["result"]["user"]["phoneNumber"],
    profilePictureID: json["result"]["user"]["profilePictureId"],
    isActive: json["result"]["user"]["isActive"],
    isEmailConfirmed: json["result"]["user"]["isEmailConfirmed"],
    creationTime: json["result"]["user"]["creationTime"],
    // permissions: json["roles"],
  );
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

class CurrentUserForEditdto{
  String name;
  String surname;
  String userName;
  String emailAddress;
  String phoneNumber;
  String profilePicture;
  String creationTime;
  double wallet;
  int  UserID;
  String  picture;

  CurrentUserForEditdto({
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.surname,
    this.profilePicture,
    this.creationTime,
    this.wallet,
    this.userName,
    this.UserID,
    this.picture,
  });

  factory CurrentUserForEditdto.fromMap(Map<String, dynamic> json) {
    return CurrentUserForEditdto(
      name: json["result"]["name"],
      surname: json["result"]["surname"],
      userName: json["result"]["userName"],
      emailAddress: json["result"]["emailAddress"],
      phoneNumber: json["result"]["phoneNumber"],
      profilePicture: json["result"]["profilePicture"],
      creationTime: json["result"]["creationTime"],
      UserID: json["result"]["userId"],
    );
  }

  factory CurrentUserForEditdto.fromMapWallet(Map<String, dynamic> json) {
    return CurrentUserForEditdto(
      wallet: json["result"],
    );
  }
}

// class CurrenUserForEditdyo{
//   dynamic result;
//   CurrenUserForEditdyo({
//     this.result
// });
//   factory CurrenUserForEditdyo.fromMap(Map<String, dynamic> json){
//     return CurrenUserForEditdyo(
//       result: json["result"],
//     );
//   }
// }