import 'package:boilerplate/models/town/province.dart';

class ProvinceList {
  final List<Province> provinces;

  ProvinceList({
    this.provinces,
  });

  factory ProvinceList.fromJson(Map<String, dynamic> json) {
    List<Province> provinces = List<Province>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      provinces.add(Province.fromMap(json["result"]["items"][i]));
    }

    return ProvinceList(
      provinces: provinces,
    );
  }
}
