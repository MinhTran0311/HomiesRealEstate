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
      final res = await _dioClient.get(Endpoints.getAllGoiBaiDangs,
        queryParameters: {
          "MaxResultCount": 100,
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

  //Update gói bài đăng
  Future<dynamic> updateGoiBaiDang(int id, String tenGoi, double phi, int doUuTien, int thoiGianToiThieu, String moTa, String trangThai) async {
    try {
      final res = await _dioClient.post(
        Endpoints.createOrEditGoiBaiDang,
        data: {
          "tenGoi": tenGoi,
          "phi": phi,
          "doUuTien": doUuTien,
          "thoiGianToiThieu": thoiGianToiThieu,
          "moTa": moTa,
          "trangThai": trangThai,
          "id": id,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      // bool resistingSuccess = res["canLogin"];
      return res;
    } catch (e) {
      throw e;
    }
  }

  //Create gói bài đăng
  Future<dynamic> createGoiBaiDang(String tenGoi, double phi, int doUuTien, int thoiGianToiThieu, String moTa, String trangThai) async {
    try {
      final res = await _dioClient.post(
        Endpoints.createOrEditGoiBaiDang,
        data: {
          "tenGoi": tenGoi,
          "phi": phi,
          "doUuTien": doUuTien,
          "thoiGianToiThieu": thoiGianToiThieu,
          "moTa": moTa,
          "trangThai": trangThai,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      // bool resistingSuccess = res["canLogin"];
      return res;
    } catch (e) {
      throw e;
    }
  }
}