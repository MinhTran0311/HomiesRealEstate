import 'app_component.dart' as _i1;
import '../modules/local_module.dart' as _i2;
import '../modules/preference_module.dart' as _i3;
import '../../data/sharedpref/shared_preference_helper.dart' as _i4;
import 'package:dio/src/dio.dart' as _i5;
import '../../data/network/dio_client.dart' as _i6;
import '../../data/network/rest_client.dart' as _i7;
import '../../data/network/apis/posts/post_api.dart' as _i8;
import '../../data/network/apis/authToken/authToken_api.dart' as _i9;
import '../../data/network/apis/users/user_api.dart' as _i10;
import '../../data/network/apis/towns/town_api.dart' as _i19;
import '../../data/network/apis/roles/role_api.dart' as _i11;
import '../../data/network/apis/image/image_api.dart' as _i12;
import '../../data/local/datasources/post/post_datasource.dart' as _i13;
import '../../data/network/apis/registration/registration_api.dart' as _i14;
import '../../data/repository.dart' as _i15;
import 'dart:async' as _i16;
import '../modules/netwok_module.dart' as _i17;
import '../../main.dart' as _i18;

class AppComponent$Injector implements _i1.AppComponent {
  AppComponent$Injector._(this._localModule, this._preferenceModule);

  final _i2.LocalModule _localModule;

  final _i3.PreferenceModule _preferenceModule;

  _i4.SharedPreferenceHelper _singletonSharedPreferenceHelper;

  _i5.Dio _singletonDio;

  _i6.DioClient _singletonDioClient;

  _i7.RestClient _singletonRestClient;

  _i8.PostApi _singletonPostApi;

  _i9.AuthTokenApi _singletonAuthTokenApi;

  _i10.UserApi _singletonUserApi;

  _i11.RoleApi _singletonRoleApi;

  _i19.TownApi _singletonTownApi;

  _i12.ImageApi _singletonImageApi;

  _i13.PostDataSource _singletonPostDataSource;

  _i14.RegistrationApi _singletonRegistrationApi;

  _i15.Repository _singletonRepository;

  static _i16.Future<_i1.AppComponent> create(
      _i17.NetworkModule _,
      _i2.LocalModule localModule,
      _i3.PreferenceModule preferenceModule) async {
    final injector = AppComponent$Injector._(localModule, preferenceModule);

    return injector;
  }

  _i18.MyApp _createMyApp() => _i18.MyApp();
  _i15.Repository _createRepository() =>
      _singletonRepository ??= _localModule.provideRepository(
          _createPostApi(),
          _createAuthTokenApi(),
          _createUserApi(),
          _createRoleApi(),
          _createImageApi(),
          _createTownApi(),
          _createSharedPreferenceHelper(),
          _createPostDataSource(),
          _createRegistrationApi());
  _i8.PostApi _createPostApi() => _singletonPostApi ??=
      _localModule.providePostApi(_createDioClient(), _createRestClient());
  _i6.DioClient _createDioClient() =>
      _singletonDioClient ??= _localModule.provideDioClient(_createDio());
  _i5.Dio _createDio() => _singletonDio ??=
      _localModule.provideDio(_createSharedPreferenceHelper());
  _i4.SharedPreferenceHelper _createSharedPreferenceHelper() =>
      _singletonSharedPreferenceHelper ??=
          _preferenceModule.provideSharedPreferenceHelper();
  _i7.RestClient _createRestClient() =>
      _singletonRestClient ??= _localModule.provideRestClient();
  _i9.AuthTokenApi _createAuthTokenApi() => _singletonAuthTokenApi ??=
      _localModule.provideAuthTokenApi(_createDioClient(), _createRestClient());
  _i10.UserApi _createUserApi() => _singletonUserApi ??=
      _localModule.provideUserApi(_createDioClient(), _createRestClient());
  _i11.RoleApi _createRoleApi() => _singletonRoleApi ??=
      _localModule.provideRoleApi(_createDioClient(), _createRestClient());
  _i12.ImageApi _createImageApi() => _singletonImageApi ??=
      _localModule.provideImageApi(_createDioClient(), _createRestClient());
  _i19.TownApi _createTownApi() => _singletonTownApi ??=
      _localModule.provideTownApi(_createDioClient(), _createRestClient());
  _i13.PostDataSource _createPostDataSource() =>
      _singletonPostDataSource ??= _localModule.providePostDataSource();
  _i14.RegistrationApi _createRegistrationApi() =>
      _singletonRegistrationApi ??= _localModule.provideRegistrationApi(
          _createDioClient(), _createRestClient());
  @override
  _i18.MyApp get app => _createMyApp();
  @override
  _i15.Repository getRepository() => _createRepository();
}
