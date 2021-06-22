import 'package:boilerplate/models/role/role.dart';
import 'package:flutter/widgets.dart';

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
  String avatar;
  String roleName;
  Image avatarImage;

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
    this.avatar,
    this.roleName,
    this.avatarImage,
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
    // permissionsList: json["result"]["roles"],
  );
  factory User.fromMap(Map<String, dynamic> json, String rolesName, String rolesDisplayName) => User(
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
    permissions: rolesDisplayName,
    permissionsList: json["roles"],
    roleName: rolesName,
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
  List<RoleCurrent>  listRole;

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
    this.listRole,
  });

  factory CurrentUserForEditdto.fromMap(Map<String, dynamic> json) {
    List<RoleCurrent> listRoles = List<RoleCurrent>();
    print("DuongLSGD");
    print(json);
    //posts = json["result"]["items"].map((post) => Post.fromMap(post)).toList();
    //print(json["result"]["items"][0].runtimeType);
    for (int i =0; i<json["result"]["roles"].length; i++) {
      listRoles.add(RoleCurrent.fromjson(json["result"]["roles"][i]));
    }
    return CurrentUserForEditdto(
      name: json["result"]["name"],
      surname: json["result"]["surname"],
      userName: json["result"]["userName"],
      emailAddress: json["result"]["emailAddress"],
      phoneNumber: json["result"]["phoneNumber"],
      profilePicture: json["result"]["profilePicture"],
      creationTime: json["result"]["creationTime"],
      UserID: json["result"]["userId"],
      listRole:listRoles,
    );
  }

  factory CurrentUserForEditdto.fromMapWallet(Map<String, dynamic> json) {
    return CurrentUserForEditdto(
      wallet: json["result"],
    );
  }
}
class RoleCurrent{
  int roleId;
  String roleName;
  String roleDisplayName;
  RoleCurrent({
    this.roleId,
    this.roleName,
    this.roleDisplayName,
  });
  factory RoleCurrent.fromjson(Map<String, dynamic> json) {
    return RoleCurrent(
      roleId: json["roleId"],
      roleName: json["roleName"],
      roleDisplayName: json["roleDisplayName"],
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