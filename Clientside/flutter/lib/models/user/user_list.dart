import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/models/user/user.dart';

class UserList {
  final List<User> users;

  UserList({
    this.users,
  });

  // factory UserList.fromJson(Map<String, dynamic> json) {
  //   List<User> users = List<User>();
  // }

  // factory UserList.fromJsonMap(Map<String, dynamic> json) =>UserList(
  //   users: json["items"],
  // );

  factory UserList.fromJson(Map<String, dynamic> json) {
    List<User> users = List<User>();
    String roleName;
    String roleDisplayName;
    for (int i=0; i<json["result"]["items"].length; i++) {
      if (json["result"]["items"][i]["roles"].length > 0) {
        roleName = "";
        roleDisplayName = "";
        for (int j=0; j<json["result"]["items"][i]["roles"].length; j++) {
          if (j > 0) {
            roleName = roleName + ", ";
            roleDisplayName = roleDisplayName + ", ";
          }
          roleName = roleName + json["result"]["items"][i]["roles"][j]["roleName"];
          roleDisplayName = roleDisplayName + json["result"]["items"][i]["roles"][j]["roleDisplayName"];
        }
        users.add(User.fromMap(json["result"]["items"][i], roleName.toString(), roleDisplayName.toString()));
      }
    }
    return UserList(
      users: users,
    );
  }
}