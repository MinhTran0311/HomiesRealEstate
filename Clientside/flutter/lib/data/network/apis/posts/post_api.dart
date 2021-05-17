import 'dart:async';
import 'dart:math';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
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
  Future<PostList> getPosts(int skipCount, int maxResultCount) async {
    try {
      final res = await _dioClient.get(Endpoints.getAllBaiDang,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "SkipCount": skipCount,
          "MaxResultCount": maxResultCount,
        },
      );
      return PostList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

    Future<PropertyList> getPostProperties(String postId) async {
    try{
      final res = await _dioClient.get(Endpoints.getAllChiTietBaiDangByPostId,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "postId": postId,
        },
      );

      return PropertyList.fromJson(res);
    }catch(e){
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


  Future<PostList> searchPosts(filter_Model filter_model) async {
    try {

      final res = await _dioClient.get(Endpoints.searchPosts,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: filter_model.toMap(skipCount: 0, maxCount: 10),
      );
      print('search results: ');
      print(res);
      return PostList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

}
