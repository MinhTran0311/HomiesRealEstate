import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/town/commune_list.dart';
import 'package:boilerplate/models/town/town.dart';
import 'package:boilerplate/models/town/town_list.dart';
import 'package:dio/dio.dart';

class TownApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  TownApi(this._dioClient, this._restClient);

  Future<TownList> getTowns() async {
    try {
      final res = await _dioClient.get("https://homies.exscanner.edu.vn/api/services/app/Huyens/GetAll?MaxResultCount=709",
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);

      return TownList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<CommuneList> getCommunes() async {
    try {
      final res = await _dioClient.get("https://homies.exscanner.edu.vn/api/services/app/Xas/GetAll?MaxResultCount=11309",
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);

      return CommuneList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
}
