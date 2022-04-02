import 'package:boilerplate/models/image/image.dart';
import 'package:flutter/material.dart';

class ImageList {
  final List<AppImage> images;

  ImageList({
    this.images,
  });

  factory ImageList.fromJson(Map<String, dynamic> json) {
    List<AppImage> images = List<AppImage>();

    for (int i =0; i< json["result"]["items"].length; i++) {
      images.add(AppImage.fromMap(json["result"]["items"][i]["hinhAnh"]));
    }
    return ImageList(
      images: images,
    );
  }
}
