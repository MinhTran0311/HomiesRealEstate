import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
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
  Future<User> getUserByID(int userID) async {
    try {
      final res = await _dioClient.get(Endpoints.getUsersByID,
        queryParameters: {
        "Id":userID
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get UserID Success ${res.toString()}");
      return User.UserByIDfromMap(res);
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

  Future<CurrentUserForEditdto> getCurrentWalletUser() async {
    try {
      final res = await _dioClient.get(Endpoints.getCurrenWalletUser,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get Wallet Success");
      return CurrentUserForEditdto.fromMapWallet(res);
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

  Future<dynamic> Naptien(double soTien, String thoiDiem,int userId) async {
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
