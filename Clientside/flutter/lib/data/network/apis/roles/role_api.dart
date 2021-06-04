import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/role/role_list.dart';
import 'package:dio/dio.dart';

class RoleApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  RoleApi(this._dioClient, this._restClient);

  //get all role
  Future<RoleList> getAllRoles() async {
    try {
      final res = await _dioClient.post(Endpoints.getAllRole,
        data: {
        },
        options: Options(
          headers: {
            "Abp.TenantId": 1,
            "Authorization" : "Bearer ${Preferences.access_token}",
          }
        ),);
      print("Get All Role success" + res.toString());
      return RoleList.fromJson(res);
    } catch(e) {
      print("lỗi get all roles" + e.toString());
      throw e;
    }
  }

  //Count all role
  Future<dynamic> countAllRoles() async {
    try {
      final res = await _dioClient.post(
        Endpoints.coutAllRole,
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

  //Get current user role
  Future<dynamic> getCurrentUserRole() async {
    try {
      final res = await _dioClient.post(
        Endpoints.getCurrentUserRole,
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