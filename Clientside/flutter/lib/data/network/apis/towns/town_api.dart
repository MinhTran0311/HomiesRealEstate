import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/town/commune_list.dart';
import 'package:boilerplate/models/town/province_list.dart';
import 'package:boilerplate/models/town/town_list.dart';
import 'package:dio/dio.dart';

class TownApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  TownApi(this._dioClient, this._restClient);

  Future<ProvinceList> getAllProvinces() async {
    try {
      final res = await _dioClient.get(Endpoints.getAllProvinces,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "MaxResultCount": Preferences.maxProvinceCount,
        }
      );
      return ProvinceList.fromJson(res);
    } catch (e) {
      throw e;
    }
  }

  Future<TownList> getTowns({String provinceFilter}) async {
    try {
      final res = await _dioClient.get(Endpoints.getAllTowns,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "MaxResultCount": Preferences.maxTownCount,
          "TinhTenTinhFilter": provinceFilter
        }
      );
      return TownList.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<CommuneList> getCommunes({String townFilter}) async {
    try {
      final res = await _dioClient.get(Endpoints.getAllCommunes ,
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
        queryParameters: {
          "MaxResultCount": Preferences.maxCommuneCount,
          "HuyenTenHuyenFilter": townFilter
        }
      );

      return CommuneList.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
}
