import 'dart:ffi';

class Post {
  String userName;
  String danhMuc;
  String tenXa;
  String tagLoaiBaidang;
  String thoiDiemDang;
  String thoiHan;
  String diaChi;
  String moTa;
  String toaDoX;
  String toaDoY;
  int luotXem;
  int luotYeuThich;
  num diemBaiDang;
  String trangThai;
  String tagTimKiem;
  String tieuDe;
  int userId;
  int danhMucId;
  int xaId;
  int id;
  String featuredImage;
  double dienTich;
  double gia;

  Post({
    this.userName,
    this.danhMuc,
    this.tenXa,
    this.tagLoaiBaidang,
    this.thoiDiemDang,
    this.thoiHan,
    this.diaChi,
    this.moTa,
    this.toaDoX,
    this.toaDoY,
    this.luotXem,
    this.luotYeuThich,
    this.diemBaiDang,
    this.trangThai,
    this.tagTimKiem,
    this.tieuDe,
    this.userId,
    this.danhMucId,
    this.xaId,
    this.id,
    this.featuredImage,
    this.dienTich,
    this.gia
  });

  factory Post.fromMap(Map<String, dynamic> json) => Post(
    userName: json["userName"],
    danhMuc: json["danhMucTenDanhMuc"],
    tenXa: json["xaTenXa"],
    tagLoaiBaidang: json["baiDang"]["tagLoaiBaiDang"],
    thoiDiemDang: json["baiDang"]["thoiDiemDang"],
    thoiHan: json["baiDang"]["thoiHan"],
    diaChi: json["baiDang"]["diaChi"],
    moTa: json["baiDang"]["moTa"],
    toaDoX: json["baiDang"]["toaDoX"],
    toaDoY: json["baiDang"]["toaDoY"],
    luotXem: json["baiDang"]["luotXem"],
    luotYeuThich: json["baiDang"]["luotYeuThich"],
    diemBaiDang: json["baiDang"]["diemBaiDang"],
    trangThai: json["baiDang"]["trangThai"],
    tagTimKiem: json["baiDang"]["tagTimKiem"],
    tieuDe: json["baiDang"]["tieuDe"],
    userId: json["baiDang"]["userId"],
    danhMucId: json["baiDang"]["danhMucId"],
    xaId: json["baiDang"]["xaId"],
    id: json["baiDang"]["id"],
    featuredImage: json["baiDang"]["featuredImage"],
    dienTich: json["baiDang"]["dienTich"],
    gia: json["baiDang"]["gia"],
      );

  Map<String, dynamic> toMap() => {
    "tagLoaiBaiDang": "$tagLoaiBaidang",
    "thoiDiemDang": "$thoiDiemDang",
    "thoiHan": "$thoiHan",
    "diaChi": "$diaChi ",
    "moTa":"$moTa",
    "toaDoX": "$toaDoX",
    "toaDoY": "$toaDoY",
    "luotXem": luotXem,
    "luotYeuThich": luotYeuThich,
    "diemBaiDang": diemBaiDang,
    "trangThai": "$trangThai",
    "tagTimKiem": "$tagTimKiem",
    "tieuDe": "$tieuDe",
    "userId": userId,
    "danhMucId": danhMucId,
    "xaId": xaId,
    "featuredImage": "$featuredImage",
    "dienTich": dienTich,
    "id": id,
    "gia": gia,
  };
  
}
