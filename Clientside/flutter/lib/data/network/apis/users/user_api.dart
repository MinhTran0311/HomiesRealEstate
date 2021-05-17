import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/user/user.dart';
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
      // log("Get All Success");
      return UserList.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<CurrentUserForEditdto> getCurrentUser() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrenUser,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All Success");
      return CurrentUserForEditdto.fromMap(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<dynamic> getAvatarByUser(int userId) async {
    try {
      final res = await _dioClient.get(Endpoints.getAvatarByUserName,
      options: Options(
        headers: {
          "Abp.TenantId": 1,
          "Authorization" : "Bearer ${Preferences.access_token}",
        }
      ),
        queryParameters: {
          "userId": userId,
        },
      );
      return res["result"]["profilePicture"];
    } catch (e) {
      throw e;
    }
  }

//Minh làm
Future<CurrentUserForEditdto> getUserOfCurrentDetailPost(int Id) async {
  try {
    final res = await _dioClient.get(Endpoints.getUserOfCurrentPost,
    options: Options(
        headers: {
          "Abp.TenantId": 1,
          "Authorization" : "Bearer ${Preferences.access_token}",
        }
    ),
    queryParameters: {
      "Id": Id,
    },);
    return CurrentUserForEditdto.fromMap(res);
    } catch (e) {
    throw e;
    }
  }

  Future<double> getCurrentWalletUser() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrenWalletUser,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All Success");
      return CurrentUserForEditdto.fromMapWallet(res);
      log("Get Wallet Success");
      double getCurrentWallet = res["result"];
      return getCurrentWallet;
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<String> getCurrentPictureUser() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrentPictureUser,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get Wallet Success");
      String getCurrentPicture = res["result"]["profilePicture"];
      return getCurrentPicture;
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<dynamic> updatetCurrentUser(String name,String surname,String phonenumber,String email,String userName) async {
    try {
      final res = await _dioClient.put(Endpoints.updateCurrenUser,
        data: {
          "name": name,
          "surname": surname,
          "emailAddress": email,
          "phoneNumber":phonenumber,
          "userName":userName,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
            ),);
          log("updateUser Success");
          bool updateUserSuccess = res["success"];

          print(res);
          return updateUserSuccess;
        } catch (e) {
          throw e;
        }
        //   return CurrenUserForEditdyo.fromMap(res);
        // } catch (e) {
        //   print("lỗi" + e.toString());
        //   throw e;
        // }
    }
    //   return CurrenUserForEditdyo.fromMap(res);
    // } catch (e) {
    //   print("lỗi" + e.toString());
    //   throw e;
    // }


  Future<dynamic> updatetPictureCurrentUser(String fileToken) async {
    try {
      final res = await _dioClient.put(Endpoints.updateCurrenUser,
        data: {
          "fileToken": fileToken,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("updateUser Success");
      bool updateUserSuccess = res["success"];

      print(res);
      return updateUserSuccess;
    } catch (e) {
      throw e;
    }
    //   return CurrenUserForEditdyo.fromMap(res);
    // } catch (e) {
    //   print("lỗi" + e.toString());
    //   throw e;
    // }
  }

  Future<listLSGD> getLSGD() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrenlichsugiaodich,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All LSGD Success");
      return listLSGD.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<bool> Naptien(double soTien, String thoiDiem,int userId) async {
    String ghiChu = "Nạp Tiền";
    try {
      final res = await _dioClient.post(Endpoints.CreateOrEditLSGD,
        data: {
          "soTien": soTien,
          "ghiChu": ghiChu,
          "thoiDiem": thoiDiem,
          "userId": userId,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization": "Bearer ${Preferences.access_token}",
            }
        ),);
      log("CreateLSGD Success");
      bool CreateLSGDSuccess = res["success"];

      print(res);
      return CreateLSGDSuccess;
    } catch (e) {
      throw e;
    }
  }
  // Future<dynamic> KiemDuyetNaptien(int userId, String idLSGD,int kiemDuyetVienID) async {
  //   String ghiChu = "Nạp Tiền";
  //   try {
  //     final res = await _dioClient.post(Endpoints.CreateOrEditLSGD,
  //       data: {
  //         "ghiChu": ghiChu,
  //         "userId": userId,
  //         "kiemDuyetVienId": kiemDuyetVienID,
  //         "id": idLSGD,
  //       },
  //       options: Options(
  //           headers: {
  //             "Abp.TenantId": 1,
  //             "Authorization": "Bearer ${Preferences.access_token}",
  //           }
  //       ),);
  //     log("CreateLSGD Success");
  //     bool CreateLSGDSuccess = res["success"];
  //
  //     print(res);
  //     return CreateLSGDSuccess;
  //   } catch (e) {
  //     throw e;
  //   }
  // }
  Future<bool> KiemDuyetGiaoDich(String idLSGD) async {
    try {
      final res = await _dioClient.post(Endpoints.kiemDuyetGiaoDich,
        data: {
          "id": idLSGD,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization": "Bearer ${Preferences.access_token}",
            }
        ),);
      log("CreateLSGD Success");
      bool CreateLSGDSuccess = res["success"];

      print(res);
      return CreateLSGDSuccess;
    } catch (e) {
      throw e;
    }
  }

  Future<listLSGD> getAllLSGD() async {
    try {
      final res = await _dioClient.get(Endpoints.getAllLSGD,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All LSGD Success");
      return listLSGD.fromJson(res);
    } catch (e) {
      print("lỗi" + e.toString());
      throw e;
    }
  }

}
