import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
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
      reaction((_) => userEmail, validateUserEmail),
      reaction((_) => phoneNumber, validatePhoneNumber),
      reaction((_) => newPassword,validateNewPassword),
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
  @observable
  int idUser = 0;
  @observable
  bool isActive = true;
  @observable
  String phoneNumber = '';
  @observable
  List<dynamic> roleName = new List<dynamic>();
  @observable
  List<String> displayRoleName = new List<String>();
  @observable
  String newPassword = '';
  @observable
  bool active = true;

  static ObservableFuture<AuthToken> emptyAuthResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<AuthToken> fetchTokenFuture = ObservableFuture<AuthToken>(emptyAuthResponse);

  static ObservableFuture<dynamic> emptyRegistResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchRegistFuture = ObservableFuture<dynamic>(emptyRegistResponse);


  static ObservableFuture<dynamic> emptyResetCodeSent = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchResetCodeFuture = ObservableFuture<dynamic>(emptyResetCodeSent);

  static ObservableFuture<dynamic> emptyChangePasswordResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchChangePasswordFuture = ObservableFuture<dynamic>(emptyChangePasswordResponse);

  static ObservableFuture<dynamic> emptyUpdateUserResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateUserFuture = ObservableFuture<dynamic>(emptyUpdateUserResponse);

  static ObservableFuture<dynamic> emptyIsActiveUserResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchIsActiveUserFuture = ObservableFuture<dynamic>(emptyIsActiveUserResponse);

  static ObservableFuture<dynamic> emptyCreateUserResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCreateUserFuture = ObservableFuture<dynamic>(emptyCreateUserResponse);

  @observable
  AuthToken authToken;

  @observable
  bool loggedIn = false;

  @observable
  bool success = false;

  @observable
  bool regist_success = false;

  @observable
  bool updateUser_success = false;

  @observable
  bool isActive_success = false;

  @observable
  bool resetPassword_success = false;

  @observable
  bool changePassword_succes = false;

  @observable
  bool createUser_success = false;

  //#region computed
  @computed
  bool get loading => fetchTokenFuture.status == FutureStatus.pending;

  @computed
  bool get canLogin =>
      !formErrorStore.hasErrorsInLogin && username.isNotEmpty && password.isNotEmpty;

  @computed
  bool get canSubmitResetPassword => !formErrorStore.hasErrorsInReset && userEmail.isNotEmpty;

  @computed
  bool get canChangePassword =>
      !formErrorStore.hasErrorInChangePassword && password.isNotEmpty && newPassword.isNotEmpty && confirmPassword.isNotEmpty && newPassword.compareTo(confirmPassword)==0;

  @computed
  bool get canRegister =>
      !formErrorStore.hasErrorsInRegister &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      surname.isNotEmpty && name.isNotEmpty && username.isNotEmpty && username.length<=20;


  @computed
  bool get canUpdate =>
      !formErrorStore.hasErrorsInUpdate &&
      userEmail.isNotEmpty &&
      // password.isNotEmpty &&
      // confirmPassword.isNotEmpty &&
      surname.isNotEmpty &&
      name.isNotEmpty &&
      phoneNumber.isNotEmpty;
          // && username.isNotEmpty;

  @computed
  bool get canCreate =>
      !formErrorStore.hasErrorsInCreate &&
      userEmail.isNotEmpty &&
      password.isNotEmpty &&
      confirmPassword.isNotEmpty &&
      surname.isNotEmpty &&
      name.isNotEmpty &&
      username.isNotEmpty &&
      phoneNumber.isNotEmpty &&
      password.compareTo(confirmPassword) == 0;

  @computed
  bool get sendingCode => fetchResetCodeFuture.status == FutureStatus.pending;
  @computed
  bool get regist_loading => fetchRegistFuture.status == FutureStatus.pending;
  @computed
  bool get changePasswordLoading => fetchChangePasswordFuture.status == FutureStatus.pending;

  @computed
  bool get updateUserLoading => fetchUpdateUserFuture.status == FutureStatus.pending;

  @computed
  bool get isActiveLoading => fetchIsActiveUserFuture.status == FutureStatus.pending;
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

  @action
  void setIdUser(int value) {
    idUser = value;
  }

  @action
  void setIsActive(bool value) {
    isActive = value;
  }

  @action
  void setPhoneNumber(String value) {
    phoneNumber = value;
  }

  @action
  void setNewPassword(String value) {
    newPassword = value;
  }

  @action
  void setRolesList(List<dynamic> value) {
    roleName = value;
  }

  //endregion

  //#region element validation
  @action
  void validateSurname(String value) {
    if (value.isEmpty) {
      formErrorStore.surname = "Chưa nhập họ";
    }
    else {
      formErrorStore.surname = null;
    }
  }

  @action
  void validateName(String value) {
    if (value.isEmpty) {
      formErrorStore.name = "Chưa nhập tên";
    }
    else {
      formErrorStore.name = null;
    }
  }

  @action
  void validateUsername(String value) {
    if (value.isEmpty) {
      formErrorStore.username = "Chưa nhập tên đăng nhập";
    }
    else if(value.length>20){
      formErrorStore.username = "Tối đa 20 kí tự";
    }
    else {
      formErrorStore.username = null;
    }
  }

  @action
  void validatePassword(String value) {
    if (value.isEmpty) {
      formErrorStore.password = "Chưa nhập mật khẩu";
    } else if (value.length < 6) {
      formErrorStore.password = "Mật khẩu phải có ít nhất 6 kí tự";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validateConfirmPassword(String value) {
    if (value.isEmpty)
      formErrorStore.confirmPassword = "Chưa nhập mật khẩu xác nhận";
    else if (newPassword.isEmpty && value.compareTo(password)!=0)
      formErrorStore.confirmPassword = "Mật khẩu xác nhận chưa đúng";
    else if (newPassword.isNotEmpty && value.compareTo(newPassword)!=0)
          formErrorStore.confirmPassword = "Mật khẩu xác nhận chưa đúng";
    else
      formErrorStore.confirmPassword = null;
  }

  @action
  void validateUserEmail(String value) {
    if (value.isEmpty) {
      formErrorStore.userEmail = "Chưa nhập địa chỉ email";
    } else if (!isEmail(value)) {
      formErrorStore.userEmail = 'Hãy nhập địa chỉ email hợp lệ';
    }
    else {
      formErrorStore.userEmail = null;
    }
  }
  @action
  void validateNewPassword(String value){
    if (value.isEmpty){
      formErrorStore.newPassword = "Chưa nhập mật khẩu mới";
    } else if(value.compareTo(password)==0){
      formErrorStore.newPassword = "Mật khẩu mới không được trùng với mật khẩu hiện tại";
    }
    else if (value.length < 6) {
      formErrorStore.password = "Mật khẩu phải có ít nhất 6 kí tự";
    } else {
      formErrorStore.password = null;
    }
  }

  @action
  void validatePhoneNumber(String value) {
    if (value.isEmpty) {
      formErrorStore.phoneNumber = "Chưa nhập số điện thoại";
    } else if (double.tryParse(value) == null) {
      formErrorStore.phoneNumber = 'Hãy nhập số điện thoại hợp lệ';
    }
    else {
      formErrorStore.phoneNumber = null;
    }
  }

//#endregion

  @action
  Future register() async {
    regist_success = false;
    final futrue = _repository.registing(surname, name, username, password, userEmail);
    fetchRegistFuture = ObservableFuture(futrue);

    futrue.then((registRes) {
      if (registRes["result"]["canLogin"]) {
        regist_success = true;
      }
      else{
        regist_success = false;
      }
    }).catchError((error){
      regist_success = false;
      if (error.response != null && error.response.data!=null)
        {//errorStore.errorMessage = error.response.data["error"]["message"];
        print(error.response.data["error"]["message"].toString().split(' \'')[1]);
        if (error.response.data["error"]["message"].toString().split(' \'')[0] == "User name")
          errorStore.errorMessage = translateErrorMessage("User name");
        else if (error.response.data["error"]["message"].toString().split(' \'')[0] == "Email")
          errorStore.errorMessage = translateErrorMessage("Email");
        else
          errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
        }
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
    });
  }

  @action
  Future UpdateUser() async {
    updateUser_success = false;
    final future = _repository.updateUser(idUser, username, surname, name, userEmail, phoneNumber, isActive, displayRoleName);
    fetchUpdateUserFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateUser_success = true;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null) {
          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra lại kết nối mạng và thử lại!";
        throw error;
      }
    });
  }

  @action
  Future IsActiveUser(User user) async {
    isActive_success = false;
    List<String> roleNames = new List<String>();
    await user.permissionsList.forEach((element) {roleNames.add(element["roleName"]);});
    final future = _repository.updateUser(user.id, user.userName, user.surName, user.name, user.email, user.phoneNumber, !user.isActive, roleNames);
    fetchIsActiveUserFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        isActive_success = true;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null) {
          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra lại kết nối mạng và thử lại!";
        throw error;
      }
    });
  }

  @action
  Future CreateUser() async {
    createUser_success = false;
    final future = _repository.createUser(username, surname, name, userEmail, phoneNumber, isActive, displayRoleName, password);
    fetchCreateUserFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        createUser_success = true;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    }
    );
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
        getCurrentUserRole();

      }
      else {
        loggedIn = false;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    }
    );
  }

  @action
  Future<dynamic> resetPassword () async {
    resetPassword_success=false;
    final future = _repository.resetPassword(this.userEmail);
    fetchResetCodeFuture = ObservableFuture(future);

    future.then((res){
      if (res["result"]["canLogin"]){
        resetPassword_success=true;
      }
      else resetPassword_success=false;
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future<dynamic> changePassword () async {
    changePassword_succes=false;
    final future = _repository.changePassword(this.password, this.newPassword);
    fetchChangePasswordFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        changePassword_succes = true;
      }
      else {
        changePassword_succes = false;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  //Get current user role when log in
  static ObservableFuture<dynamic> emptyGetCurrentUserRoleResponses =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchGetCurrentUserRoleFutures =
  ObservableFuture<dynamic>(emptyGetCurrentUserRoleResponses);

  @computed
  bool get loadingsGetCurrentUserRole => fetchGetCurrentUserRoleFutures.status == FutureStatus.pending;

  @observable
  bool getCurrentUserRoleSuccess = false;

  @action
  Future getCurrentUserRole() async {
    final future = _repository.getCurrentUserRole();
    fetchGetCurrentUserRoleFutures = ObservableFuture(future);
    future.then((res) {

      if (res["success"]!= true)
      {
        getCurrentUserRoleSuccess = false;
        return null;
      }
      else{
        Preferences.userRole = res["result"]["role"][0]["roleName"];
        Preferences.userRoleRank = rolePermission();
        List<String> permission = new List<String>();
        if ((res["result"]["grantedPermissionNames"] as List)?.length > 0)
        {
          for (int i=0; i<(res["result"]["grantedPermissionNames"] as List)?.length; i++)
          {
            permission.add(res["result"]["grantedPermissionNames"][i]);
          }
          Preferences.grantedPermissions = permission;
        }
        getCurrentUserRoleSuccess = true;
        return res["result"]["role"][0]["roleName"];
      }

    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else {
      //   errorStore.errorMessage =
      //   "Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }
  @action
  int rolePermission()
  {
    print("role" + Preferences.userRole);

    switch(Preferences.userRole)
    {
      case "Admin":
        return 3;
      case "Moderator":
        return 2;
      case "User":
        return 1;
      default:
        return 0;
    }
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
    validatePhoneNumber(phoneNumber);
    validateNewPassword(newPassword);
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
  @observable
  String phoneNumber;
  @observable
  String newPassword;


  @computed
  bool get hasErrorsInLogin => username != null || password != null;
  @computed
  bool get hasErrorsInReset => userEmail != null;

  @computed
  bool get hasErrorsInRegister =>
      surname != null || name != null ||username != null ||password != null || confirmPassword != null || userEmail != null;
  @computed
  bool get hasErrorInChangePassword =>
      password != null || newPassword!= null || confirmPassword!= null;
  @computed
  bool get hasErrorsInUpdate =>
      surname != null || name != null ||username != null || userEmail != null || phoneNumber != null;
  @computed
  bool get hasErrorsInCreate =>
      surname != null || name != null ||username != null ||password != null || confirmPassword != null || userEmail != null || phoneNumber != null;
  @computed
  bool get hasErrorInForgotPassword => username != null;
}
