import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/thuocTinh/thuocTinh_list.dart';
import 'package:dio/dio.dart';

class ThuocTinhApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  ThuocTinhApi(this._dioClient, this._restClient);

  //Get all thuộc tính
  Future<ThuocTinhManagementList> getAllThuocTinhs() async {
    try {
      final res = await _dioClient.post(Endpoints.getAllThuocTinhs,
        data: {
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      return ThuocTinhManagementList.fromJson(res);
    } catch(e) {
      print("lỗi get all Thuoc Tinh" + e.toString());
      throw e;
    }
  }

  //Count all thuộc tính
  Future<dynamic> countAllThuocTinhs() async {
    try {
      final res = await _dioClient.post(
        Endpoints.countAllThuocTinhs,
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