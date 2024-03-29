// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FormStore on _FormStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_FormStore.loading'))
      .value;
  Computed<bool> _$canLoginComputed;

  @override
  bool get canLogin => (_$canLoginComputed ??=
          Computed<bool>(() => super.canLogin, name: '_FormStore.canLogin'))
      .value;
  Computed<bool> _$canSubmitResetPasswordComputed;

  @override
  bool get canSubmitResetPassword => (_$canSubmitResetPasswordComputed ??=
          Computed<bool>(() => super.canSubmitResetPassword,
              name: '_FormStore.canSubmitResetPassword'))
      .value;
  Computed<bool> _$canChangePasswordComputed;

  @override
  bool get canChangePassword => (_$canChangePasswordComputed ??= Computed<bool>(
          () => super.canChangePassword,
          name: '_FormStore.canChangePassword'))
      .value;
  Computed<bool> _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
          .value;
  Computed<bool> _$canUpdateComputed;

  @override
  bool get canUpdate => (_$canUpdateComputed ??=
          Computed<bool>(() => super.canUpdate, name: '_FormStore.canUpdate'))
      .value;
  Computed<bool> _$canCreateComputed;

  @override
  bool get canCreate => (_$canCreateComputed ??=
          Computed<bool>(() => super.canCreate, name: '_FormStore.canCreate'))
      .value;
  Computed<bool> _$sendingCodeComputed;

  @override
  bool get sendingCode =>
      (_$sendingCodeComputed ??= Computed<bool>(() => super.sendingCode,
              name: '_FormStore.sendingCode'))
          .value;
  Computed<bool> _$regist_loadingComputed;

  @override
  bool get regist_loading =>
      (_$regist_loadingComputed ??= Computed<bool>(() => super.regist_loading,
              name: '_FormStore.regist_loading'))
          .value;
  Computed<bool> _$changePasswordLoadingComputed;

  @override
  bool get changePasswordLoading => (_$changePasswordLoadingComputed ??=
          Computed<bool>(() => super.changePasswordLoading,
              name: '_FormStore.changePasswordLoading'))
      .value;
  Computed<bool> _$updateUserLoadingComputed;

  @override
  bool get updateUserLoading => (_$updateUserLoadingComputed ??= Computed<bool>(
          () => super.updateUserLoading,
          name: '_FormStore.updateUserLoading'))
      .value;
  Computed<bool> _$isActiveLoadingComputed;

  @override
  bool get isActiveLoading =>
      (_$isActiveLoadingComputed ??= Computed<bool>(() => super.isActiveLoading,
              name: '_FormStore.isActiveLoading'))
          .value;
  Computed<bool> _$loadingsGetCurrentUserRoleComputed;

  @override
  bool get loadingsGetCurrentUserRole =>
      (_$loadingsGetCurrentUserRoleComputed ??= Computed<bool>(
              () => super.loadingsGetCurrentUserRole,
              name: '_FormStore.loadingsGetCurrentUserRole'))
          .value;

  final _$surnameAtom = Atom(name: '_FormStore.surname');

  @override
  String get surname {
    _$surnameAtom.reportRead();
    return super.surname;
  }

  @override
  set surname(String value) {
    _$surnameAtom.reportWrite(value, super.surname, () {
      super.surname = value;
    });
  }

  final _$nameAtom = Atom(name: '_FormStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$usernameAtom = Atom(name: '_FormStore.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$userEmailAtom = Atom(name: '_FormStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$idUserAtom = Atom(name: '_FormStore.idUser');

  @override
  int get idUser {
    _$idUserAtom.reportRead();
    return super.idUser;
  }

  @override
  set idUser(int value) {
    _$idUserAtom.reportWrite(value, super.idUser, () {
      super.idUser = value;
    });
  }

  final _$isActiveAtom = Atom(name: '_FormStore.isActive');

  @override
  bool get isActive {
    _$isActiveAtom.reportRead();
    return super.isActive;
  }

  @override
  set isActive(bool value) {
    _$isActiveAtom.reportWrite(value, super.isActive, () {
      super.isActive = value;
    });
  }

  final _$phoneNumberAtom = Atom(name: '_FormStore.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$roleNameAtom = Atom(name: '_FormStore.roleName');

  @override
  List<dynamic> get roleName {
    _$roleNameAtom.reportRead();
    return super.roleName;
  }

  @override
  set roleName(List<dynamic> value) {
    _$roleNameAtom.reportWrite(value, super.roleName, () {
      super.roleName = value;
    });
  }

  final _$displayRoleNameAtom = Atom(name: '_FormStore.displayRoleName');

  @override
  List<String> get displayRoleName {
    _$displayRoleNameAtom.reportRead();
    return super.displayRoleName;
  }

  @override
  set displayRoleName(List<String> value) {
    _$displayRoleNameAtom.reportWrite(value, super.displayRoleName, () {
      super.displayRoleName = value;
    });
  }

  final _$newPasswordAtom = Atom(name: '_FormStore.newPassword');

  @override
  String get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  final _$activeAtom = Atom(name: '_FormStore.active');

  @override
  bool get active {
    _$activeAtom.reportRead();
    return super.active;
  }

  @override
  set active(bool value) {
    _$activeAtom.reportWrite(value, super.active, () {
      super.active = value;
    });
  }

  final _$fetchTokenFutureAtom = Atom(name: '_FormStore.fetchTokenFuture');

  @override
  ObservableFuture<AuthToken> get fetchTokenFuture {
    _$fetchTokenFutureAtom.reportRead();
    return super.fetchTokenFuture;
  }

  @override
  set fetchTokenFuture(ObservableFuture<AuthToken> value) {
    _$fetchTokenFutureAtom.reportWrite(value, super.fetchTokenFuture, () {
      super.fetchTokenFuture = value;
    });
  }

  final _$fetchRegistFutureAtom = Atom(name: '_FormStore.fetchRegistFuture');

  @override
  ObservableFuture<dynamic> get fetchRegistFuture {
    _$fetchRegistFutureAtom.reportRead();
    return super.fetchRegistFuture;
  }

  @override
  set fetchRegistFuture(ObservableFuture<dynamic> value) {
    _$fetchRegistFutureAtom.reportWrite(value, super.fetchRegistFuture, () {
      super.fetchRegistFuture = value;
    });
  }

  final _$fetchResetCodeFutureAtom =
      Atom(name: '_FormStore.fetchResetCodeFuture');

  @override
  ObservableFuture<dynamic> get fetchResetCodeFuture {
    _$fetchResetCodeFutureAtom.reportRead();
    return super.fetchResetCodeFuture;
  }

  @override
  set fetchResetCodeFuture(ObservableFuture<dynamic> value) {
    _$fetchResetCodeFutureAtom.reportWrite(value, super.fetchResetCodeFuture,
        () {
      super.fetchResetCodeFuture = value;
    });
  }

  final _$fetchChangePasswordFutureAtom =
      Atom(name: '_FormStore.fetchChangePasswordFuture');

  @override
  ObservableFuture<dynamic> get fetchChangePasswordFuture {
    _$fetchChangePasswordFutureAtom.reportRead();
    return super.fetchChangePasswordFuture;
  }

  @override
  set fetchChangePasswordFuture(ObservableFuture<dynamic> value) {
    _$fetchChangePasswordFutureAtom
        .reportWrite(value, super.fetchChangePasswordFuture, () {
      super.fetchChangePasswordFuture = value;
    });
  }

  final _$fetchUpdateUserFutureAtom =
      Atom(name: '_FormStore.fetchUpdateUserFuture');

  @override
  ObservableFuture<dynamic> get fetchUpdateUserFuture {
    _$fetchUpdateUserFutureAtom.reportRead();
    return super.fetchUpdateUserFuture;
  }

  @override
  set fetchUpdateUserFuture(ObservableFuture<dynamic> value) {
    _$fetchUpdateUserFutureAtom.reportWrite(value, super.fetchUpdateUserFuture,
        () {
      super.fetchUpdateUserFuture = value;
    });
  }

  final _$fetchIsActiveUserFutureAtom =
      Atom(name: '_FormStore.fetchIsActiveUserFuture');

  @override
  ObservableFuture<dynamic> get fetchIsActiveUserFuture {
    _$fetchIsActiveUserFutureAtom.reportRead();
    return super.fetchIsActiveUserFuture;
  }

  @override
  set fetchIsActiveUserFuture(ObservableFuture<dynamic> value) {
    _$fetchIsActiveUserFutureAtom
        .reportWrite(value, super.fetchIsActiveUserFuture, () {
      super.fetchIsActiveUserFuture = value;
    });
  }

  final _$fetchCreateUserFutureAtom =
      Atom(name: '_FormStore.fetchCreateUserFuture');

  @override
  ObservableFuture<dynamic> get fetchCreateUserFuture {
    _$fetchCreateUserFutureAtom.reportRead();
    return super.fetchCreateUserFuture;
  }

  @override
  set fetchCreateUserFuture(ObservableFuture<dynamic> value) {
    _$fetchCreateUserFutureAtom.reportWrite(value, super.fetchCreateUserFuture,
        () {
      super.fetchCreateUserFuture = value;
    });
  }

  final _$authTokenAtom = Atom(name: '_FormStore.authToken');

  @override
  AuthToken get authToken {
    _$authTokenAtom.reportRead();
    return super.authToken;
  }

  @override
  set authToken(AuthToken value) {
    _$authTokenAtom.reportWrite(value, super.authToken, () {
      super.authToken = value;
    });
  }

  final _$loggedInAtom = Atom(name: '_FormStore.loggedIn');

  @override
  bool get loggedIn {
    _$loggedInAtom.reportRead();
    return super.loggedIn;
  }

  @override
  set loggedIn(bool value) {
    _$loggedInAtom.reportWrite(value, super.loggedIn, () {
      super.loggedIn = value;
    });
  }

  final _$successAtom = Atom(name: '_FormStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$regist_successAtom = Atom(name: '_FormStore.regist_success');

  @override
  bool get regist_success {
    _$regist_successAtom.reportRead();
    return super.regist_success;
  }

  @override
  set regist_success(bool value) {
    _$regist_successAtom.reportWrite(value, super.regist_success, () {
      super.regist_success = value;
    });
  }

  final _$updateUser_successAtom = Atom(name: '_FormStore.updateUser_success');

  @override
  bool get updateUser_success {
    _$updateUser_successAtom.reportRead();
    return super.updateUser_success;
  }

  @override
  set updateUser_success(bool value) {
    _$updateUser_successAtom.reportWrite(value, super.updateUser_success, () {
      super.updateUser_success = value;
    });
  }

  final _$isActive_successAtom = Atom(name: '_FormStore.isActive_success');

  @override
  bool get isActive_success {
    _$isActive_successAtom.reportRead();
    return super.isActive_success;
  }

  @override
  set isActive_success(bool value) {
    _$isActive_successAtom.reportWrite(value, super.isActive_success, () {
      super.isActive_success = value;
    });
  }

  final _$resetPassword_successAtom =
      Atom(name: '_FormStore.resetPassword_success');

  @override
  bool get resetPassword_success {
    _$resetPassword_successAtom.reportRead();
    return super.resetPassword_success;
  }

  @override
  set resetPassword_success(bool value) {
    _$resetPassword_successAtom.reportWrite(value, super.resetPassword_success,
        () {
      super.resetPassword_success = value;
    });
  }

  final _$changePassword_succesAtom =
      Atom(name: '_FormStore.changePassword_succes');

  @override
  bool get changePassword_succes {
    _$changePassword_succesAtom.reportRead();
    return super.changePassword_succes;
  }

  @override
  set changePassword_succes(bool value) {
    _$changePassword_succesAtom.reportWrite(value, super.changePassword_succes,
        () {
      super.changePassword_succes = value;
    });
  }

  final _$createUser_successAtom = Atom(name: '_FormStore.createUser_success');

  @override
  bool get createUser_success {
    _$createUser_successAtom.reportRead();
    return super.createUser_success;
  }

  @override
  set createUser_success(bool value) {
    _$createUser_successAtom.reportWrite(value, super.createUser_success, () {
      super.createUser_success = value;
    });
  }

  final _$fetchGetCurrentUserRoleFuturesAtom =
      Atom(name: '_FormStore.fetchGetCurrentUserRoleFutures');

  @override
  ObservableFuture<dynamic> get fetchGetCurrentUserRoleFutures {
    _$fetchGetCurrentUserRoleFuturesAtom.reportRead();
    return super.fetchGetCurrentUserRoleFutures;
  }

  @override
  set fetchGetCurrentUserRoleFutures(ObservableFuture<dynamic> value) {
    _$fetchGetCurrentUserRoleFuturesAtom
        .reportWrite(value, super.fetchGetCurrentUserRoleFutures, () {
      super.fetchGetCurrentUserRoleFutures = value;
    });
  }

  final _$getCurrentUserRoleSuccessAtom =
      Atom(name: '_FormStore.getCurrentUserRoleSuccess');

  @override
  bool get getCurrentUserRoleSuccess {
    _$getCurrentUserRoleSuccessAtom.reportRead();
    return super.getCurrentUserRoleSuccess;
  }

  @override
  set getCurrentUserRoleSuccess(bool value) {
    _$getCurrentUserRoleSuccessAtom
        .reportWrite(value, super.getCurrentUserRoleSuccess, () {
      super.getCurrentUserRoleSuccess = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_FormStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$UpdateUserAsyncAction = AsyncAction('_FormStore.UpdateUser');

  @override
  Future<dynamic> UpdateUser() {
    return _$UpdateUserAsyncAction.run(() => super.UpdateUser());
  }

  final _$IsActiveUserAsyncAction = AsyncAction('_FormStore.IsActiveUser');

  @override
  Future<dynamic> IsActiveUser(User user) {
    return _$IsActiveUserAsyncAction.run(() => super.IsActiveUser(user));
  }

  final _$CreateUserAsyncAction = AsyncAction('_FormStore.CreateUser');

  @override
  Future<dynamic> CreateUser() {
    return _$CreateUserAsyncAction.run(() => super.CreateUser());
  }

  final _$authLogInAsyncAction = AsyncAction('_FormStore.authLogIn');

  @override
  Future<dynamic> authLogIn(String username, String password) {
    return _$authLogInAsyncAction
        .run(() => super.authLogIn(username, password));
  }

  final _$resetPasswordAsyncAction = AsyncAction('_FormStore.resetPassword');

  @override
  Future<dynamic> resetPassword() {
    return _$resetPasswordAsyncAction.run(() => super.resetPassword());
  }

  final _$changePasswordAsyncAction = AsyncAction('_FormStore.changePassword');

  @override
  Future<dynamic> changePassword() {
    return _$changePasswordAsyncAction.run(() => super.changePassword());
  }

  final _$getCurrentUserRoleAsyncAction =
      AsyncAction('_FormStore.getCurrentUserRole');

  @override
  Future<dynamic> getCurrentUserRole() {
    return _$getCurrentUserRoleAsyncAction
        .run(() => super.getCurrentUserRole());
  }

  final _$_FormStoreActionController = ActionController(name: '_FormStore');

  @override
  void setUserId(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setUserId');
    try {
      return super.setUserId(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setSurname(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setSurname');
    try {
      return super.setSurname(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setName(String value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setName');
    try {
      return super.setName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setUserEmail');
    try {
      return super.setUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setConfirmPassword');
    try {
      return super.setConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIdUser(int value) {
    final _$actionInfo =
        _$_FormStoreActionController.startAction(name: '_FormStore.setIdUser');
    try {
      return super.setIdUser(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setIsActive(bool value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setIsActive');
    try {
      return super.setIsActive(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPhoneNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setPhoneNumber');
    try {
      return super.setPhoneNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNewPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setNewPassword');
    try {
      return super.setNewPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setRolesList(List<dynamic> value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.setRolesList');
    try {
      return super.setRolesList(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateSurname(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateSurname');
    try {
      return super.validateSurname(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateName(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateName');
    try {
      return super.validateName(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUsername(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUsername');
    try {
      return super.validateUsername(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePassword');
    try {
      return super.validatePassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateConfirmPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateConfirmPassword');
    try {
      return super.validateConfirmPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateUserEmail(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateUserEmail');
    try {
      return super.validateUserEmail(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateNewPassword(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validateNewPassword');
    try {
      return super.validateNewPassword(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validatePhoneNumber(String value) {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.validatePhoneNumber');
    try {
      return super.validatePhoneNumber(value);
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  int rolePermission() {
    final _$actionInfo = _$_FormStoreActionController.startAction(
        name: '_FormStore.rolePermission');
    try {
      return super.rolePermission();
    } finally {
      _$_FormStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
surname: ${surname},
name: ${name},
username: ${username},
password: ${password},
confirmPassword: ${confirmPassword},
userEmail: ${userEmail},
idUser: ${idUser},
isActive: ${isActive},
phoneNumber: ${phoneNumber},
roleName: ${roleName},
displayRoleName: ${displayRoleName},
newPassword: ${newPassword},
active: ${active},
fetchTokenFuture: ${fetchTokenFuture},
fetchRegistFuture: ${fetchRegistFuture},
fetchResetCodeFuture: ${fetchResetCodeFuture},
fetchChangePasswordFuture: ${fetchChangePasswordFuture},
fetchUpdateUserFuture: ${fetchUpdateUserFuture},
fetchIsActiveUserFuture: ${fetchIsActiveUserFuture},
fetchCreateUserFuture: ${fetchCreateUserFuture},
authToken: ${authToken},
loggedIn: ${loggedIn},
success: ${success},
regist_success: ${regist_success},
updateUser_success: ${updateUser_success},
isActive_success: ${isActive_success},
resetPassword_success: ${resetPassword_success},
changePassword_succes: ${changePassword_succes},
createUser_success: ${createUser_success},
fetchGetCurrentUserRoleFutures: ${fetchGetCurrentUserRoleFutures},
getCurrentUserRoleSuccess: ${getCurrentUserRoleSuccess},
loading: ${loading},
canLogin: ${canLogin},
canSubmitResetPassword: ${canSubmitResetPassword},
canChangePassword: ${canChangePassword},
canRegister: ${canRegister},
canUpdate: ${canUpdate},
canCreate: ${canCreate},
sendingCode: ${sendingCode},
regist_loading: ${regist_loading},
changePasswordLoading: ${changePasswordLoading},
updateUserLoading: ${updateUserLoading},
isActiveLoading: ${isActiveLoading},
loadingsGetCurrentUserRole: ${loadingsGetCurrentUserRole}
    ''';
  }
}

mixin _$FormErrorStore on _FormErrorStore, Store {
  Computed<bool> _$hasErrorsInLoginComputed;

  @override
  bool get hasErrorsInLogin => (_$hasErrorsInLoginComputed ??= Computed<bool>(
          () => super.hasErrorsInLogin,
          name: '_FormErrorStore.hasErrorsInLogin'))
      .value;
  Computed<bool> _$hasErrorsInResetComputed;

  @override
  bool get hasErrorsInReset => (_$hasErrorsInResetComputed ??= Computed<bool>(
          () => super.hasErrorsInReset,
          name: '_FormErrorStore.hasErrorsInReset'))
      .value;
  Computed<bool> _$hasErrorsInRegisterComputed;

  @override
  bool get hasErrorsInRegister => (_$hasErrorsInRegisterComputed ??=
          Computed<bool>(() => super.hasErrorsInRegister,
              name: '_FormErrorStore.hasErrorsInRegister'))
      .value;
  Computed<bool> _$hasErrorInChangePasswordComputed;

  @override
  bool get hasErrorInChangePassword => (_$hasErrorInChangePasswordComputed ??=
          Computed<bool>(() => super.hasErrorInChangePassword,
              name: '_FormErrorStore.hasErrorInChangePassword'))
      .value;
  Computed<bool> _$hasErrorsInUpdateComputed;

  @override
  bool get hasErrorsInUpdate => (_$hasErrorsInUpdateComputed ??= Computed<bool>(
          () => super.hasErrorsInUpdate,
          name: '_FormErrorStore.hasErrorsInUpdate'))
      .value;
  Computed<bool> _$hasErrorsInCreateComputed;

  @override
  bool get hasErrorsInCreate => (_$hasErrorsInCreateComputed ??= Computed<bool>(
          () => super.hasErrorsInCreate,
          name: '_FormErrorStore.hasErrorsInCreate'))
      .value;
  Computed<bool> _$hasErrorInForgotPasswordComputed;

  @override
  bool get hasErrorInForgotPassword => (_$hasErrorInForgotPasswordComputed ??=
          Computed<bool>(() => super.hasErrorInForgotPassword,
              name: '_FormErrorStore.hasErrorInForgotPassword'))
      .value;

  final _$surnameAtom = Atom(name: '_FormErrorStore.surname');

  @override
  String get surname {
    _$surnameAtom.reportRead();
    return super.surname;
  }

  @override
  set surname(String value) {
    _$surnameAtom.reportWrite(value, super.surname, () {
      super.surname = value;
    });
  }

  final _$nameAtom = Atom(name: '_FormErrorStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$usernameAtom = Atom(name: '_FormErrorStore.username');

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  final _$passwordAtom = Atom(name: '_FormErrorStore.password');

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  final _$confirmPasswordAtom = Atom(name: '_FormErrorStore.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  final _$userEmailAtom = Atom(name: '_FormErrorStore.userEmail');

  @override
  String get userEmail {
    _$userEmailAtom.reportRead();
    return super.userEmail;
  }

  @override
  set userEmail(String value) {
    _$userEmailAtom.reportWrite(value, super.userEmail, () {
      super.userEmail = value;
    });
  }

  final _$phoneNumberAtom = Atom(name: '_FormErrorStore.phoneNumber');

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  final _$newPasswordAtom = Atom(name: '_FormErrorStore.newPassword');

  @override
  String get newPassword {
    _$newPasswordAtom.reportRead();
    return super.newPassword;
  }

  @override
  set newPassword(String value) {
    _$newPasswordAtom.reportWrite(value, super.newPassword, () {
      super.newPassword = value;
    });
  }

  @override
  String toString() {
    return '''
surname: ${surname},
name: ${name},
username: ${username},
password: ${password},
confirmPassword: ${confirmPassword},
userEmail: ${userEmail},
phoneNumber: ${phoneNumber},
newPassword: ${newPassword},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInReset: ${hasErrorsInReset},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInChangePassword: ${hasErrorInChangePassword},
hasErrorsInUpdate: ${hasErrorsInUpdate},
hasErrorsInCreate: ${hasErrorsInCreate},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}
