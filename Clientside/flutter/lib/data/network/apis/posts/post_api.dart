import 'dart:async';
import 'dart:math';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/postpack/pack_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<PostList> getPosts(int skipCount, int maxResultCount, filter_Model filter_model) async {
    if (filter_model==null)
      filter_model=filter_Model.instance;
    try {
      final res = await _dioClient.get(
        Endpoints.searchPosts,
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters: filter_model.toMap(skipCount: skipCount, maxCount: maxResultCount)
        ,
      );
      return PostList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }
  /// Get all Posts
  Future<PostList> getAllPosts() async {
    try {
      final res = await _dioClient.get(
        Endpoints.searchPosts,
        queryParameters: {
          "MaxResultCount": Preferences.maxPostCount,
        },
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),

      );
      return PostList.fromJson(res);
    } catch (e) {
      // print("lỗi get all Post" + e.toString());
      throw e;
    }
  }
  Future<dynamic> addViewForPost(int postId) async {
    try {
      final res = await _dioClient.post(
        Endpoints.addViewForPost,
        options: Options(headers: {
          "Abp.TenantId": 1,
        }),
        queryParameters: {
          "baidangId": postId
        }
        ,
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  // Future<PostList> searchPosts(int skipCount, int maxResultCount, filter_Model filter_model) async {
  //   Map<String,dynamic> count = {
  //     "SkipCount": skipCount,
  //     "MaxResultCount": maxResultCount,};
  //   var combination = {};
  //   combination.addAll(count);
  //   combination.addAll(filter_model.toMap());
  //
  //   try {
  //     final res = await _dioClient.get(
  //       Endpoints.searchPosts,
  //       options: Options(headers: {
  //         "Abp.TenantId": 1,
  //         "Authorization": "Bearer ${Preferences.access_token}",
  //       }),
  //       queryParameters: combination,
  //     );
  //     return PostList.fromJson(res);
  //   } catch (e) {
  //     throw e;
  //   }
  // }

  /// Returns list of postcategory in response
  Future<PostCategoryList> getPostCategorys() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/DanhMucs/GetAllDanhMucForView",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      return PostCategoryList.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<PackList> getPacks() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/GoiBaiDangs/GetAllGoiBaiDangForView",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      return PackList.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<ThuocTinhList> getThuocTinhs() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/ThuocTinhs/GetAllThuocTinhForView",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      return ThuocTinhList.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<PropertyList> getPostProperties(String postId) async {
    try {
      final res = await _dioClient.get(
        Endpoints.getAllChiTietBaiDangByPostId,
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters: {
          "postId": postId,
        },
      );
      return PropertyList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<String> postPost(Newpost newpost) async {
      try {
        final res = await _dioClient.post(
            "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/CreateBaiDangAndDetails",
            options: Options(
              headers: {
                "Abp.TenantId": 1,
                "Authorization": "Bearer ${Preferences.access_token}",
                "Content-Type": "application/json",
              },
            ),
            data: {
              "baiDang": (newpost.post.toMap()),
              "chiTietBaiDangDtos": [
                if (newpost.properties != null)
                  for (var item in newpost.properties) item.toMap()
              ],
              "hoaDonBaiDangDto": (newpost.hoadonbaidang.toMap()),
              "lichSuGiaoDichDto": (newpost.lichsugiaodichs.toMap()),
              "hinhAnhDtos": [for (var item in newpost.images) item.toMap()]
            });
      } catch (e) {
      throw e;
    }
  }

  Future<PostList> getPostsforcur(int skipCount, int maxResultCount, String filter, int key,) async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAllBaiDangsByCurrentUser",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
          queryParameters:{"skipCount": skipCount, "maxResultCount":maxResultCount,"filter":filter,"phanLoaiBaiDang":key },
      );
      return PostList.fromJsonmypost(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<PostList> getPostsforcheck(int skipCount, int maxResultCount, String filter, int key,) async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAllForModerator",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters:{"Filter":filter,"phanLoaiBaiDang":key,"SkipCount": skipCount, "MaxResultCount":maxResultCount },
      );
      return PostList.fromJsonmypost(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<String> getsobaidang() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAllBaiDangsByCurrentUser",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters:{"skipCount": 0, "maxResultCount":1},
      );
      return (res["result"]["totalCount"].toString());
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<String> getsobaidangall() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAllForModerator",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters:{"skipCount": 0, "maxResultCount":1},
      );
      return (res["result"]["totalCount"].toString());
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

  Future<dynamic> isBaiGhimYeuThichOrNot(String postId) async {
    try {
      final res = await _dioClient.post(
        Endpoints.isBaiDangYeuThichOrNot,
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters: {
          "postId": postId,
        },
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createOrChangeStatusBaiGhimYeuThich(
      String postId, bool status) async {
    try {
      DateTime now = DateTime.now();
      String fomattedDate = DateTime.now().toIso8601String();
      final res =
          await _dioClient.post(Endpoints.createOrChangeStatusBaiGhimYeuThich,
              options: Options(headers: {
                "Abp.TenantId": 1,
                "Authorization": "Bearer ${Preferences.access_token}",
              }),
              data: {
                "trangThai": status ? "On" : "Off",
                "baiDangId": postId,
                "thoiGian": fomattedDate,
          });
      return res;
    } catch (e) {
      throw e;
    }
  }



  Future<String> editpost(Newpost newpost) async {
    try {
      final res = await _dioClient.post(
          "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/EditBaiDangAndDetails",
          options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization": "Bearer ${Preferences.access_token}",
              "Content-Type": "application/json",
            },
          ),
          data: {
            "baiDang": (newpost.post.toMap()),
            "chiTietBaiDangDtos": [
              if (newpost.properties != null)
                for (var item in newpost.properties) item.toMap()
            ],
            "hinhAnhDtos": [for (var item in newpost.images) item.toMap()]
          });
    } catch (e) {
      throw e;
    }
  }

  Future<String> Delete(Post post) async {
    try {
      final res = await _dioClient.post(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/CreateOrEdit",
        options: Options(
          headers: {
            "Abp.TenantId": 1,
            "Authorization": "Bearer ${Preferences.access_token}",
            "Content-Type": "application/json",
          },
        ),
        data: post.toMap(),
      );
    } catch (e) {
      throw e;
    }
  }

  Future<String> giahan(Newpost newpost) async {
    try {
      final res = await _dioClient.post(
          "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GiaHanBaiDang",
          options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization": "Bearer ${Preferences.access_token}",
            },
          ),
          data: {
            "baiDangId": newpost.post.id,
            "thoiHan": newpost.post.thoiHan,
            "lichSuGiaoDichDto": newpost.lichsugiaodichs.toMap(),
            "hoaDonBaiDangDto": newpost.hoadonbaidang.toMap(),
          });
    } catch (e) {
      throw e;
    }
  }

  Future<double> getpackprice(int idpost) async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/GoiBaiDangs/GetAllGoiBaiDangForView",
        options: Options(
          headers: {
            "Abp.TenantId": 1,
            "Authorization": "Bearer ${Preferences.access_token}",
          },
        ),
        queryParameters: {"id": idpost},
      );
      return res["result"]["goiBaiDang"]["phi"];
    } catch (e) {
      throw e;
    }
  }
  Future<PostList> getfavopost(int iduser, int skipCountmypost, int maxCount, String s) async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiGhimYeuThichs/GetAllBaiGhimByCurrentUser",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
        queryParameters: {"id": iduser,"skipCount": skipCountmypost, "maxResultCount":maxCount,"filter":s},
      );
      return PostList.fromJsonfavopost(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  //Đếm số bài đăng mới trong tháng
  Future<dynamic> countNewBaiDangInMonth() async {
    try {
      final res = await _dioClient.post(
        Endpoints.countNewBaiDangInMonth,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
      );

      return res["result"];
    } catch (e) {
      throw e;
    }
  }
}
