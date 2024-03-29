import 'package:boilerplate/data/network/apis/authToken/authToken_api.dart';
import 'package:boilerplate/data/network/apis/danhMucs/danhMuc_api.dart';
import 'package:boilerplate/data/network/apis/goiBaiDangs/goiBaiDang_api.dart';
import 'package:boilerplate/data/network/apis/image/image_api.dart';
import 'package:boilerplate/data/network/apis/lichsugiaodich/lichsugiaodich_api.dart';
import 'package:boilerplate/data/network/apis/posts/post_api.dart';
import 'package:boilerplate/data/network/apis/thuocTinhs/thuocTinh_api.dart';
import 'package:boilerplate/data/network/apis/towns/town_api.dart';
import 'package:boilerplate/data/network/apis/users/user_api.dart';
import 'package:boilerplate/data/network/apis/roles/role_api.dart';
import 'package:boilerplate/data/network/apis/registration/registration_api.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/modules/preference_module.dart';
import 'package:dio/dio.dart';
import 'package:inject/inject.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
class NetworkModule extends PreferenceModule {
  // ignore: non_constant_identifier_names
  final String TAG = "NetworkModule";

  // DI Providers:--------------------------------------------------------------
  /// A singleton dio provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  Dio provideDio(SharedPreferenceHelper sharedPrefHelper) {
    final dio = Dio();

    dio
      ..options.baseUrl = Endpoints.baseUrl
      ..options.connectTimeout = Endpoints.connectionTimeout
      ..options.receiveTimeout = Endpoints.receiveTimeout
      ..options.headers = {'Content-Type': 'application/json; charset=utf-8'}
      ..interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
        requestHeader: true,
      ))
      ..interceptors.add(
        InterceptorsWrapper(
          onRequest: (Options options) async {
            // getting shared pref instance
            var prefs = await SharedPreferences.getInstance();

            // getting token
            var token = prefs.getString(Preferences.auth_token);

            if (token != null) {
              options.headers.putIfAbsent('Authorization', () => token);
            } else {
              print('Auth token is null');
            }
          },
        ),
      );

    return dio;
  }

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  DioClient provideDioClient(Dio dio) => DioClient(dio);

  /// A singleton dio_client provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  RestClient provideRestClient() => RestClient();

  // Api Providers:-------------------------------------------------------------
  // Define all your api providers here
  /// A singleton post_api provider.
  ///
  /// Calling it multiple times will return the same instance.
  @provide
  @singleton
  PostApi providePostApi(DioClient dioClient, RestClient restClient) =>
      PostApi(dioClient, restClient);
  @provide
  @singleton
  AuthTokenApi provideAuthTokenApi(DioClient dioClient, RestClient restClient)=>
      AuthTokenApi(dioClient, restClient);

  @provide
  @singleton
  UserApi provideUserApi(DioClient dioClient, RestClient restClient)=>
      UserApi(dioClient, restClient);
  @provide
  @singleton
  TownApi provideTownApi(DioClient dioClient, RestClient restClient)=>
      TownApi(dioClient, restClient);
  @provide
  @singleton
  RegistrationApi provideRegistrationApi(DioClient dioClient, RestClient restClient)=>
      RegistrationApi(dioClient, restClient);
  @provide
  @singleton
  RoleApi provideRoleApi(DioClient dioClient, RestClient restClient)=>
      RoleApi(dioClient, restClient);

  @provide
  @singleton
  ImageApi provideImageApi(DioClient dioClient, RestClient restClient)=>
      ImageApi(dioClient, restClient);
  @provide
  @singleton
  DanhMucApi provideDanhMucApi(DioClient dioClient, RestClient restClient)=>
      DanhMucApi(dioClient, restClient);
  @provide
  @singleton
  ThuocTinhApi provideThuocTinhApi(DioClient dioClient, RestClient restClient)=>
      ThuocTinhApi(dioClient, restClient);
  @provide
  @singleton
  GoiBaiDangApi provideGoiBaiDangApi(DioClient dioClient, RestClient restClient)=>
      GoiBaiDangApi(dioClient, restClient);

  @provide
  @singleton
  lichsugiaodichApi provideLichSuGiaoDichApi(DioClient dioClient, RestClient restClient)=>
      lichsugiaodichApi(dioClient, restClient);
// Api Providers End:---------------------------------------------------------

}
