import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:validators/validators.dart';

import '../../main.dart';

part 'form_store.g.dart';

class FormStore = _FormStore with _$FormStore;

abstract class _FormStore with Store {
  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  Repository _repository = appComponent.getRepository();

  _FormStore() {
    //this._repository = repository;
    _setupValidations();
  }



  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupValidations() {
    _disposers = [
      reaction((_) => surname, validateSurname),
      reaction((_) => name, validateName),
      reaction((_) => username, validateUsername),
      reaction((_) => password, validatePassword),
      reaction((_) => confirmPassword, validateConfirmPassword),
      reaction((_) => userEmail, validateUserEmail)
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String surname='';
  @observable
  String name='';
  @observable
  String username='';
  @observable
  String password = '';
  @observable
  String confirmPassword = '';
  @observable
  String userEmail = '';

  static ObservableFuture<AuthToken> emptyAuthResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<AuthToken> fetchTokenFuture = ObservableFuture<AuthToken>(emptyAuthResponse);

  @observable
  AuthToken authToken;

  @observable
  bool loggedIn = false;


  @observable
  bool success = false;

  @observable
  bool regist_success = false;

  @observable
  bool resetPassword_success = false;


  static ObservableFuture<dynamic> emptyRegistResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchRegistFuture = ObservableFuture<dynamic>(emptyRegistResponse);


  static ObservableFuture<dynamic> emptyResetCodeSent = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchResetCodeFuture = ObservableFuture<dynamic>(emptyResetCodeSent);

  //#region computed
  @computed
  bool get loading => fetchTokenFuture.status == FutureStatus.pending;
  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin && username.isNotEmpty && password.isNotEmpty;
  @computed
  bool get canSubmitResetPassword => !formErrorStore.hasErrorsInReset && userEmail.isNotEmpty;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      surname.isNotEmpty && name.isNotEmpty && username.isNotEmpty;

  @computed
  bool get sendingCode => fetchResetCodeFuture.status == FutureStatus.pending;
  @computed
  bool get regist_loading => fetchRegistFuture.status == FutureStatus.pending;
  //endregion

  //#region set value
  // actions:-------------------------------------------------------------------
  @action
  void setUserId(String value) {
    username = value;
  }
  @action
  void setSurname(String value) {
    surname = value;
  }
  @action
  void setName(String value) {
    name = value;
  }
  @action
  void setUserEmail(String value) {
    userEmail = value;
  }

  @action
  void setPassword(String value) {
    password = value;
  }

  @action
  void setConfirmPassword(String value) {
    confirmPassword = value;
  }
  //endregion

  //#region element validation
  @action
  void validateSurname(String value) {
    if (value.isEmpty) {
      formErrorStore.username = "Chưa điền họ";
    }
    else {
      formErrorStore.username = null;
    }
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.name = "Chưa điền tên";
    }
    else {
      formErrorStore.name = null;
    }
  }

  @action
  void validateUsername(String value) {
    if (value.isEmpty) {
      formErrorStore.username = "Chưa điền tên đăng nhập";
    }
    else {
      formErrorStore.username = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Chưa điền mật khẩu";
    } else if (value.length < 6) {
      formErrorStore.password = "Mật khẩu phải có ít nhất 6 kí tự";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty) {
      formErrorStore.confirmPassword = "Chưa điền mật khẩu xác nhận";
    } else if (value != password) {
      formErrorStore.confirmPassword = "Mật khẩu chưa đúng";
    } else {
      formErrorStore.confirmPassword = null;
    }
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Chưa điền tên đăng nhập";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Hãy nhập địa chỉ email hợp lệ';
    }
    else {
      formErrorStore.userEmail = null;
    }
  }

//#endregion

  @action
  Future register() async {
    regist_success = false;
    final futrue = _repository.registing(surname, name, username, password, userEmail);
    fetchRegistFuture = ObservableFuture(futrue);

    futrue.then((registRes) {
      print("123" + registRes["result"]["canLogin"].toString());

      if (registRes["result"]["canLogin"]) {
        regist_success = true;
      }
      else{
        regist_success = false;
      }
    }).catchError((error){
      regist_success = false;
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
    });
  }

  @action
  Future UpdateUser() async {
    final futrue = _repository.registing(surname, name, username, password, userEmail);
    fetchRegistFuture = ObservableFuture(futrue);

    futrue.then((registRes) {
      print("123" + registRes["result"]["canLogin"].toString());

      if (registRes["result"]["canLogin"]) {
        regist_success = true;
      }
      else{
        regist_success = false;
      }
    }).catchError((error){
      regist_success = false;
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
    });
  }

  @action
  Future<dynamic> authLogIn (String username, String password) async {
    final future = _repository.authorizing(username, password);
    fetchTokenFuture = ObservableFuture(future);

    future.then((newauthToken){
      this.authToken = newauthToken;
      if (authToken.accessToken!=null){
        loggedIn = true;
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
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }


  @action
  Future<dynamic> resetPassword () async {
    resetPassword_success=false;
    final future = _repository.resetPassword(this.userEmail);
    fetchResetCodeFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        resetPassword_success=true;
      }
      else resetPassword_success=false;
    }).catchError((error){
      if (error is DioError) {
        resetPassword_success=false;
        if (error.response.data!=null) {

          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }

  // @action
  // Future login() async {
  //   loading = true;
  //
  //   Future.delayed(Duration(milliseconds: 2000)).then((future) {
  //     loading = false;
  //     success = true;
  //   }).catchError((e) {
  //     loading = false;
  //     success = false;
  //     errorStore.errorMessage = e.toString().contains("ERROR_USER_NOT_FOUND")
  //         ? "Tên đăng nhập và mật khẩu không đúng"
  //         : "Đã có lỗi xảy ra, hãy kiểm tra lại kết nối mạng và thử lại";
  //     print(e);
  //   });
  // }
  //
  // @action
  // Future forgotPassword() async {
  //   loading = true;
  // }
  //
  // @action
  // Future logout() async {
  //   loading = true;
  // }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }

  void validateAll() {
    validateSurname(surname);
    validateName(name);
    validateUsername(username);
    validatePassword(password);
    validateUserEmail(userEmail);
  }
}

class FormErrorStore = _FormErrorStore with _$FormErrorStore;

abstract class _FormErrorStore with Store {
  @observable
  String surname;
  @observable
  String name;
  @observable
  String username;
  @observable
  String password;
  @observable
  String confirmPassword;
  @observable
  String userEmail;

  @computed
  bool get hasErrorsInLogin => username != null || password != null;
  @computed
  bool get hasErrorsInReset => userEmail != null;

  @computed
  bool get hasErrorsInRegister =>
      surname != null || name != null ||username != null ||password != null || confirmPassword != null || userEmail != null;

  @computed
  bool get hasErrorInForgotPassword => username != null;
}
