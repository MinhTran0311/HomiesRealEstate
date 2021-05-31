import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/models/role/role.dart';

class RoleList {
  final List<Role> roles;

  RoleList({
    this.roles,
  });

  factory RoleList.fromJson(Map<String, dynamic> json) {
    // print("Json Role: " + json.toString());
    List<Role> roles = List<Role>();
    // print(json.toString());
    if (json["result"]["items"].length > 0) {
      for (int i = 0; i < json["result"]["items"].length; i++) {
        roles.add(Role.fromMap(json["result"]["items"][i]));
      }
    }
    return RoleList(
      roles: roles,
    );
  }
}