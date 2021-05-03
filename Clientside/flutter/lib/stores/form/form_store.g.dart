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
  Computed<bool> _$canRegisterComputed;

  @override
  bool get canRegister =>
      (_$canRegisterComputed ??= Computed<bool>(() => super.canRegister,
              name: '_FormStore.canRegister'))
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

  final _$registerAsyncAction = AsyncAction('_FormStore.register');

  @override
  Future<dynamic> register() {
    return _$registerAsyncAction.run(() => super.register());
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
  String toString() {
    return '''
surname: ${surname},
name: ${name},
username: ${username},
password: ${password},
confirmPassword: ${confirmPassword},
userEmail: ${userEmail},
fetchTokenFuture: ${fetchTokenFuture},
authToken: ${authToken},
loggedIn: ${loggedIn},
success: ${success},
regist_success: ${regist_success},
fetchRegistFuture: ${fetchRegistFuture},
fetchResetCodeFuture: ${fetchResetCodeFuture},
loading: ${loading},
canLogin: ${canLogin},
canSubmitResetPassword: ${canSubmitResetPassword},
canRegister: ${canRegister},
sendingCode: ${sendingCode},
regist_loading: ${regist_loading}
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

  @override
  String toString() {
    return '''
surname: ${surname},
name: ${name},
username: ${username},
password: ${password},
confirmPassword: ${confirmPassword},
userEmail: ${userEmail},
hasErrorsInLogin: ${hasErrorsInLogin},
hasErrorsInReset: ${hasErrorsInReset},
hasErrorsInRegister: ${hasErrorsInRegister},
hasErrorInForgotPassword: ${hasErrorInForgotPassword}
    ''';
  }
}
