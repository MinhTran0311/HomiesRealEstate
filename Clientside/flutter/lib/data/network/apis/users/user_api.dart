import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:dio/dio.dart';

class UserApi {
  final DioClient _dioClient;
  
  final RestClient _restClient;
  
  UserApi(this._dioClient, this._restClient);
  
  Future<UserList> getAllUsers() async {
    try {
      final res = await _dioClient.post(Endpoints.getAllUsers,
        data: {
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All Success");
      return UserList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
}