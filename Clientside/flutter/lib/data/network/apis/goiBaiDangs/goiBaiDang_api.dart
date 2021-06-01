import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/goiBaiDang/goiBaiDang_list.dart';
import 'package:dio/dio.dart';

class GoiBaiDangApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  GoiBaiDangApi(this._dioClient, this._restClient);

  //Get all goi bai dang
  Future<GoiBaiDangList> getAllGoiBaiDangs() async {
    try {
      final res = await _dioClient.post(Endpoints.getAllGoiBaiDangs,
        data: {
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      return GoiBaiDangList.fromJson(res);
    } catch(e) {
      print("lỗi get all Goi bai dang" + e.toString());
      throw e;
    }
  }

  //Count all goi bai dang
  Future<dynamic> countAllGoiBaiDangs() async {
    try {
      final res = await _dioClient.post(
        Endpoints.countAllGoiBaiDangs,
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