import 'dart:developer';

import 'package:boilerplate/models/post/post_category.dart';
import 'package:flutter/material.dart';

class PostCategoryList {
  final List<Postcategory> categorys;

  PostCategoryList({
    this.categorys,
  });

  factory PostCategoryList.fromJson(Map<String, dynamic> json) {
    List<Postcategory> categorys = List<Postcategory>();
    for (int i =0; i<json["result"]["items"].length; i++) {
      categorys.add(Postcategory.fromMap(json["result"]["items"][i]));
    }
    return PostCategoryList(
      categorys:categorys ,
    );
  }
}
