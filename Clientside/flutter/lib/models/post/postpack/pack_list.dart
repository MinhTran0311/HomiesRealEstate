import 'dart:developer';

import 'package:boilerplate/models/post/postpack/pack.dart';
import 'package:flutter/material.dart';

class PackList {
  final List<Pack> packs;

  PackList({
    this.packs,
  });

  factory PackList.fromJson(Map<String, dynamic> json) {
    List<Pack> categorys = List<Pack>();
    for (int i =0; i<json["result"]["items"].length; i++) {
      categorys.add(Pack.fromMap(json["result"]["items"][i]));
    }
    return PackList(
      packs:categorys ,
    );
  }
}
