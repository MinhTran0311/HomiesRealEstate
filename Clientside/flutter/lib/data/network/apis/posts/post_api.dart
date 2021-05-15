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

  Future<dynamic> isBaiGhimYeuThichOrNot(String postId) async {
    try {
      final res = await _dioClient.post(
        Endpoints.isBaiDangYeuThichOrNot,
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
      return res;
    } catch (e) {
      throw e;
    }
  }

  Future<dynamic> createOrChangeStatusBaiGhimYeuThich(String postId,bool status) async {
    try {
      DateTime now = DateTime.now();
      String fomattedDate = DateFormat('yyyy-mm-dd').format(now);
      print(fomattedDate);
      final res = await _dioClient.post(
        Endpoints.createOrChangeStatusBaiGhimYeuThich,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        data: {
          "trangThai": status ? "On":"Off",
          "baiDangId": postId,
        }
      );
      return res;
    } catch (e) {
      throw e;
    }
  }


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
