import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/models/danhMuc/danhMuc.dart';

class DanhMucList {
  final List<DanhMuc> danhMucs;

  DanhMucList({
    this.danhMucs,
  });

  factory DanhMucList.fromJson(Map<String, dynamic> json) {
    // print("Json Role: " + json.toString());
    // print("123123123123");
    List<DanhMuc> danhMucs = List<DanhMuc>();
    // print(json.toString());
    for (int i =0; i<json["result"]["items"].length; i++) {
      danhMucs.add(DanhMuc.fromMap(json["result"]["items"][i]["danhMuc"]));
    }
    return DanhMucList(
      danhMucs: danhMucs,
    );
  }
}