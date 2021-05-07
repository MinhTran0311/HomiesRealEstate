import 'dart:async';
import 'dart:math';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:dio/dio.dart';

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
      final res = await _dioClient.get("https://homies.exscanner.edu.vn/api/services/app/BaiDangs/GetAll",
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);

      return PostList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<PostCategoryList> getPostCategorys() async {
    try {
      final res = await _dioClient.get("https://homies.exscanner.edu.vn/api/services/app/DanhMucs/GetAll",
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      print("111111111111111111");

      return PostCategoryList.fromJson(res);
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
