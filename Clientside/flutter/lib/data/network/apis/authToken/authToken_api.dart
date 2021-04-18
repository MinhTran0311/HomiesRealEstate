import 'dart:async';
import 'dart:convert';
import '';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'package:dio/dio.dart';
import 'dart:developer';
class AuthTokenApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AuthTokenApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<AuthToken> getToken(String Username, String Password) async {
    try {
      final res = await _dioClient.post(
        "https://homies.exscanner.edu.vn/api/TokenAuth/Authenticate",
        data: {
          "userNameOrEmailAddress": Username,
          "password": Password,
        },
        options: Options(
          headers: {
            "Abp.TenantId": 1,
          }
        ),
      );
      //final Map<String, dynamic> data = json.decode(res.body);
      AuthToken a = AuthToken.fromMap(res);
      return a;
    } catch (e) {
      throw e;
    }
  }

/// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }

}
