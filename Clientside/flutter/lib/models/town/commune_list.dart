import 'dart:developer';

import 'package:boilerplate/models/town/commune .dart';
import 'package:flutter/material.dart';

class CommuneList {
  final List<Commune> communes;

  CommuneList({
    this.communes,
  });

  factory CommuneList.fromJson(Map<String, dynamic> json) {
    List<Commune> communes = List<Commune>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      communes.add(Commune.fromMap(json["result"]["items"][i]));
    }
    //print(communes);
    return CommuneList(
      communes: communes,
    );
  }
}
