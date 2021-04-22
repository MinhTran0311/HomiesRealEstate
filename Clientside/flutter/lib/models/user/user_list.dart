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
    List<String> rolesName = List<String>();
    if(json["result"]["totalCount"] > 0) {
      for (int i=0; i<json["result"]["items"].length; i++) {
        users.add(User.fromMap(json["result"]["items"][i], rolesName));
        if (json["result"]["items"][i]["roles"].length > 0) {
          for (int j=0; j<json["result"]["items"][i]["roles"].length; j++) {
            rolesName.add(json["result"]["items"][i]["roles"]["roleName"]);
          }
        }
      }
      return UserList(
        users: users,
      );
    }
  }
  // Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
}