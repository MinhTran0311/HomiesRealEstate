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
    // this.permissions,
  });

  factory User.fromMap(Map<String, dynamic> json) => User(
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
    // permissions: json["roles"],
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
    // "roles": permissions,
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

  CurrentUserForEditdto({
    this.name,
    this.emailAddress,
    this.phoneNumber,
    this.surname,
    this.profilePicture,
    this.creationTime,
    this.wallet,
    this.userName
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
