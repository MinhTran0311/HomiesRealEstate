import 'dart:async';
import 'dart:developer';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/report/ListReport.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:dio/dio.dart';

class UserApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  UserApi(this._dioClient, this._restClient);

  Future<UserList> getAllUsers(int skipCount, int maxResultCount, String filter) async {
    try {
      final res = await _dioClient.post(Endpoints.getAllUsers,
        data: {
          "maxResultCount":maxResultCount,
          "skipCount": skipCount,
          "filter": filter,
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
      // print("lỗi2" + e.toString());
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
      // print("lỗi" + e.toString());
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
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  Future<dynamic> getAvatarByUser(int userId) async {
    try {
      final res = await _dioClient.get(Endpoints.getAvatarByUser,
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
      log("Get Wallet Success");
      double getCurrentWallet = res["result"];
      return getCurrentWallet;
    } catch (e) {
      // print("lỗi" + e.toString());
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
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  Future<dynamic> updatetCurrentUser(String name,String surname,String phonenumber,String email,String userName, int id) async {
    try {
      final res = await _dioClient.put(Endpoints.updateCurrenUser,
        data: {
          "name": name,
          "surname": surname,
          "emailAddress": email,
          "phoneNumber":phonenumber,
          "userName":userName,
          "id":id,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
            ),);
          bool updateUserSuccess = res["success"];

          // print(res);
          return res;
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

      // print(res);
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

  Future<listLSGD> getLSGD(int skipCount, int maxResultCount,String LoaiLSGD,String MinThoiDiem,String MaxThoiDiem) async {
    int Loai=0;
    if(LoaiLSGD=="Nạp tiền"){
      Loai=-1;
    }
    else if(LoaiLSGD == "Thanh toán"){
      Loai=1;
    }
    else{
      Loai=0;
    }
    try {
      final res = await _dioClient.get(Endpoints.getCurrenlichsugiaodich,
        queryParameters: {
        "skipCount": skipCount,
          "maxCount": maxResultCount,
          "phanLoaiLSGD":Loai,
          "MinThoiGianFilter":MinThoiDiem,
          "MaxThoiGianFilter":MaxThoiDiem,

        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);

      log("Get All LSGD Success");
      return listLSGD.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
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

      // print(res);
      return res;
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

      // print(res);
      return CreateLSGDSuccess;
    } catch (e) {
      throw e;
    }
  }

  Future<listLSGD> getAllLSGD(int skipCount, int maxResultCount,String LoaiLSGD,String MinThoiDiem,String MaxThoiDiem) async {
    int Loai=0;
    if(LoaiLSGD=="Nạp tiền"){
      Loai=-1;
    }
    else if(LoaiLSGD == "Thanh toán"){
      Loai=1;
    }
    else{
      Loai=0;
    }
    try {
      final res = await _dioClient.get(Endpoints.getAllLSGD,
        queryParameters: {
          "skipCount": skipCount,
          "maxCount": maxResultCount,
          "phanLoaiLSGD":Loai,
          "MinThoiGianFilter":MinThoiDiem,
          "MaxThoiGianFilter":MaxThoiDiem,
        },
        options:
          Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);

    // try{
    //   final res = await _dioClient.get(Endpoints.getAllLSGD,
    //     queryParameters: {
    //       "MaxResultCount": 1000,
    //       "Sorting": "thoiDiem desc",
    //     },
    //     options: Options(
    //         headers: {
    //           "Abp.TenantId": 1,
    //           "Authorization" : "Bearer ${Preferences.access_token}",
    //         }
    //     ),);
      log("Get All LSGD Success ${res}");
      return listLSGD.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }
  //getReportData
  Future<listitemReport> getReportData() async {
    try {
      final res = await _dioClient.get(Endpoints.getReportDate,

        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),);
      log("Get All LSGD Success");
      return listitemReport.fromJson(res);
    } catch (e) {
      // print("lỗi" + e.toString());
      throw e;
    }
  }

  //Update user
  Future<dynamic> updateUser(int id, String userName, String surname, String name, String email, String phoneNumber, bool isActive, List<dynamic> roleName) async {
    try {
      // List<String> roleNames = new List<String>();
      // roleName.forEach((element) {roleNames.add(element["roleName"]);});
      final res = await _dioClient.post(
        Endpoints.createOrUpdateUser,
        data: {
          "user": {
            "id": id,
            "userName": userName,
            "name": name,
            "surname": surname,
            "emailAddress": email,
            "phoneNumber": phoneNumber,
            "isActive": isActive,
          },
          "assignedRoleNames": roleName,
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

  //Create user
  Future<dynamic> createUser(String userName, String surname, String name, String email, String phoneNumber, bool isActive, List<dynamic> roleName, String password) async {
    try {
      // List<String> roleNames = new List<String>();
      // roleName.forEach((element) {roleNames.add(element["roleName"]);});
      final res = await _dioClient.post(
        Endpoints.createOrUpdateUser,
        data: {
          "user": {
            "userName": userName,
            "name": name,
            "surname": surname,
            "emailAddress": email,
            "phoneNumber": phoneNumber,
            "isActive": isActive,
            "password": password,
          },
          "assignedRoleNames": roleName,
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

  //userChangePassword
  Future<dynamic> changePassword(String password, String newPassword) async {
    try {
      final res = await _dioClient.post(
        Endpoints.changePassword,
        data: {
          "currentPassword": password,
          "newPassword": newPassword
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization": "Bearer ${Preferences.access_token}",
            }
        ),);
      // bool resistingSuccess = res["canLogin"];
      return res;
    } catch (e) {
      throw e;
    }
  }

  // //Delete user
  Future<dynamic> deleteUser(int id) async {
    try {
      final dio = Dio();
      final res = await dio.delete(
        Endpoints.deleteUser,
        queryParameters: {
          "Id":id
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
              "Authorization" : "Bearer ${Preferences.access_token}",
            }
        ),
      );
      return res;
    } catch (e) {
      throw e;
    }
  }

  //Count all users
  Future<dynamic> countAllUsers() async {
    try {
      final res = await _dioClient.post(
        Endpoints.coutAllUser,
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

  //Count new users in month
  Future<dynamic> countNewUsersInMonth() async {
    try {
      final res = await _dioClient.post(
        Endpoints.coutNewUserInMonth,
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
