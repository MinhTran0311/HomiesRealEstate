import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:dio/dio.dart';

import '../../dio_client.dart';
import '../../rest_client.dart';

class lichsugiaodichApi{
  final DioClient _dioClient;

  final RestClient _restClient;

  lichsugiaodichApi(this._dioClient, this._restClient);

  Future<listLSGD> getCurrenlichsugiaodich() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrenlichsugiaodich,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      // log("Get All Success");
      return listLSGD.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
  
  Future<dynamic> countLichSuGiaoDichChuaKiemDuyet() async {
    try {
      final res = await _dioClient.post(
        Endpoints.getLSGDChuaKiemDuyet,
        options: Options(
          headers: {
            "Abp.TenantId": 1,
            "Authorization" : "Bearer ${Preferences.access_token}",
          }
        ),
      );
      return res["result"];
    }catch (e) {
      throw e;
    }
  }
  
}