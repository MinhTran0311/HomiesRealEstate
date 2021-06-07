import 'dart:async';
import 'dart:convert';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';

import 'package:dio/dio.dart';
import 'dart:developer';
class RegistrationApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  RegistrationApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<dynamic> regist(String surname, String name, String username, String password, String email, String phoneNumber) async {
    try {
      final res = await _dioClient.post(
        Endpoints.signup,
        data: {
          "name": name,
          "surname": surname,
          "userName": username,
          "emailAddress": email,
          "password": password,
          "phoneNumber": phoneNumber,
        },
        options: Options(
            headers: {
              "Abp.TenantId": 1,
            }
        ),
      );

      bool resistingSuccess = res["canLogin"];

      return res;
    } catch (e) {
      throw e;
    }
  }
}
