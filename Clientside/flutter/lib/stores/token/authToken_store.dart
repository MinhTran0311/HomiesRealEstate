import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'dart:developer';
import 'package:boilerplate/constants/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authToken_store.g.dart';

class AuthTokenStore = _AuthTokenStore with _$AuthTokenStore;

abstract class _AuthTokenStore with Store{
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _AuthTokenStore(Repository repository) : this._repository = repository;

  //variables
  static ObservableFuture<AuthToken> emptyAuthResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<AuthToken> fetchTokenFuture = ObservableFuture<AuthToken>(emptyAuthResponse);

  @observable
  AuthToken authToken;

  @observable
  bool loggedIn = false;

  @computed
  bool get loading => fetchTokenFuture.status == FutureStatus.pending;

  @action
  Future<dynamic> authLogIn (String username, String password) async {
    final future = _repository.authorizing(username, password);
    fetchTokenFuture = ObservableFuture(future);

    future.then((newauthToken){
      this.authToken = newauthToken;
      if (authToken.accessToken!=null){
        loggedIn=true;
        SharedPreferences.getInstance().then((preference) {
          preference.setString(Preferences.access_token, this.authToken.accessToken);});
        Preferences.access_token = this.authToken.accessToken;
      }
      else {
        loggedIn = false;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
       throw error;
      }
      else{
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }
}
