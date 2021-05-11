import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh.dart';

class ThuocTinhList {
  final List<ThuocTinh> thuocTinhs;

  ThuocTinhList({
    this.thuocTinhs,
  });

  factory ThuocTinhList.fromJson(Map<String, dynamic> json) {
    List<ThuocTinh> thuocTinhs = List<ThuocTinh>();

    for (int i =0; i<json["result"]["items"].length; i++) {
      thuocTinhs.add(ThuocTinh.fromMap(json["result"]["items"][i]));
    }

    return ThuocTinhList(
      thuocTinhs: thuocTinhs,
    );
  }
}
