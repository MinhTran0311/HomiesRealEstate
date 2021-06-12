import 'dart:convert';
import 'dart:developer';

import 'package:boilerplate/models/thuocTinh/thuocTinh.dart';

class ThuocTinhManagementList {
  final List<ThuocTinhManagement> thuocTinhs;

  ThuocTinhManagementList({
    this.thuocTinhs,
  });

  factory ThuocTinhManagementList.fromJson(Map<String, dynamic> json) {
    // print("Json Role: " + json.toString());
    List<ThuocTinhManagement> thuocTinhs = List<ThuocTinhManagement>();
    // print(json.toString());
    for (int i = 0; i < json["result"]["items"].length; i++) {
      thuocTinhs.add(ThuocTinhManagement.fromMap(json["result"]["items"][i]["thuocTinh"]));
    }
    return ThuocTinhManagementList(
      thuocTinhs: thuocTinhs,
    );
  }
}