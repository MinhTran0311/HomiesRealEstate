import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/danhMuc/danhMuc_list.dart';
import 'package:dio/dio.dart';

class DanhMucApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  DanhMucApi(this._dioClient, this._restClient);

  //Get all danh mục
  Future<DanhMucList> getAllDanhMucs() async {
    try {
      // print("123123123123dat");
      final res = await _dioClient.get(Endpoints.getAllDanhMucs,
        // data: {
        // },
        queryParameters: {
          "MaxResultCount": 100,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      return DanhMucList.fromJson(res);
    } catch(e) {
      print("lỗi get all Danh Muc" + e.toString());
      throw e;
    }
  }

  //Count all danh mục
  Future<dynamic> countAllDanhMucs() async {
    try {
      final res = await _dioClient.post(
        Endpoints.countAllDanhMucs,
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