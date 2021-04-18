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

  factory UserList.fromJson(List<dynamic> json) {
    List<User> users = List<User>();
    users = json.map((user) => User.fromMap(user)).toList();

    return UserList(
      users: users,
    );
  }

  // Map<String, dynamic> data = new Map<String, dynamic>.from(json.decode(response.body));
}