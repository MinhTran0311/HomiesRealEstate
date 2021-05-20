import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/hoadonbaidang/hoadonbaidang.dart';
import 'package:boilerplate/models/post/postProperties/postProperty.dart';

import '../post.dart';

class Newpost {
  Post post;
  List<Property> properties;
  Hoadonbaidang hoadonbaidang;
  List<AppImage> images;
  lichsugiaodich lichsugiaodichs;
  Newpost({
    this.post,
    this.properties,
    this.hoadonbaidang,
    this.images,
  });

  factory Newpost.fromMap(Map<String, dynamic> json) => Newpost(

    post: json["baiDang"],
    properties: json["chiTietBaiDangDtos"],
    hoadonbaidang: json["hoaDonBaiDangDto"],
    images: json["hinhAnhDtos"],

  );

  Map<String, dynamic> toMap() => {
    "baiDang": post.toMap(),
    //"chiTietBaiDangDtos": properties.toMap(),
    "hoaDonBaiDangDto": hoadonbaidang.toMap(),
    //"hinhAnhDtos": images,

  };

}
