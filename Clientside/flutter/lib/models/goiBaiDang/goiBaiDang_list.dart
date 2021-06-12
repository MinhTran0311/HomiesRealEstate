import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/models/goiBaiDang/goiBaiDang.dart';

class GoiBaiDangList {
  final List<GoiBaiDang> goiBaiDangs;

  GoiBaiDangList({
    this.goiBaiDangs,
  });

  factory GoiBaiDangList.fromJson(Map<String, dynamic> json) {
    // print("Json Role: " + json.toString());
    List<GoiBaiDang> goiBaiDangs = List<GoiBaiDang>();
    // print(json.toString());
    for (int i = 0; i < json["result"]["items"].length; i++) {
      goiBaiDangs.add(GoiBaiDang.fromMap(json["result"]["items"][i]["goiBaiDang"]));
    }
    return GoiBaiDangList(
      goiBaiDangs: goiBaiDangs,
    );
  }
}