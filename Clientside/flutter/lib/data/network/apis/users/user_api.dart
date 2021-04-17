import 'dart:async';

import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/models/user/user_list.dart';

class UserApi {
  final DioClient _dioClient;
  
  final RestClient _restClient;
  
  UserApi(this._dioClient, this._restClient);
  
  Future<UserList> getAllUsers() async {
    try {
      final res = await _dioClient.get(Endpoints.getAllUsers);
      return UserList.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}