import 'dart:async';
import 'dart:math';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/postpack/pack_list.dart';

import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:developer';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<PostList> getPosts() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAll",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );

      return PostList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  /// Returns list of postcategory in response
  Future<PostCategoryList> getPostCategorys() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/DanhMucs/GetAll?MaxResultCount=50",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      print("111111111111111111");

      return PostCategoryList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<PackList> getPacks() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/GoiBaiDangs/GetAll",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      print("111111111111111111");

      return PackList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<ThuocTinhList> getThuocTinhs() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/ThuocTinhs/GetAll",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );
      print("111111111111111111");

      return ThuocTinhList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
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
            "hinhAnhDtos": [
              for (var item in newpost.images) item.toMap()
            ]
          });
    } catch (e) {
      throw e;
    }
  }

  Future<PostList> getPostsforcur() async {
    try {
      final res = await _dioClient.get(
        "https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAllBaiDangsByCurrentUser",
        options: Options(headers: {
          "Abp.TenantId": 1,
          "Authorization": "Bearer ${Preferences.access_token}",
        }),
      );

      return PostList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
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

}
