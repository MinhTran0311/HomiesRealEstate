import 'dart:developer';

import 'package:boilerplate/models/town/town.dart';
import 'package:flutter/material.dart';

class TownList {
  final List<Town> towns;

  TownList({
    this.towns,
  });

  factory TownList.fromJson(Map<String, dynamic> json) {
    List<Town> towns = List<Town>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      towns.add(Town.fromMap(json["result"]["items"][i]));
    }

    return TownList(
      towns: towns,
    );
  }
}
