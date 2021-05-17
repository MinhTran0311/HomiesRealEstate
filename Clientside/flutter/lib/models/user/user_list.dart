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
    String rolesName;
    if(json["result"]["totalCount"] > 0) {
      for (int i=0; i<json["result"]["items"].length; i++) {
        if (json["result"]["items"][i]["roles"].length > 0) {
          rolesName = "";
          for (int j=0; j<json["result"]["items"][i]["roles"].length; j++) {
            if (j > 0) {
              rolesName = rolesName + ", ";
            }
            rolesName = rolesName + json["result"]["items"][i]["roles"][j]["roleName"];
          }
          users.add(User.fromMap(json["result"]["items"][i], rolesName.toString()));
        }
      }
      return UserList(
        users: users,
      );
    }
  }
}