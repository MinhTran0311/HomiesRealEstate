// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserStore on _UserStore, Store {
  Computed<bool> _$isLoadingComputed;

  @override
  bool get isLoading => (_$isLoadingComputed ??=
          Computed<bool>(() => super.isLoading, name: '_UserStore.isLoading'))
      .value;

  final _$successAtom = Atom(name: '_UserStore.success');

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

  final _$loginFutureAtom = Atom(name: '_UserStore.loginFuture');

  @override
  ObservableFuture<bool> get loginFuture {
    _$loginFutureAtom.reportRead();
    return super.loginFuture;
  }

  @override
  set loginFuture(ObservableFuture<bool> value) {
    _$loginFutureAtom.reportWrite(value, super.loginFuture, () {
      super.loginFuture = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$getUserAsyncAction = AsyncAction('_UserStore.getCurrentUser');
  @override
  Future<dynamic> getCurrentUser() {
    return _$getUserAsyncAction.run(() => super.getCurrentUser());
  }
  final _$getUserWalletAsyncAction = AsyncAction('_UserStore.getCurrentWalletUser');
  @override
  Future<dynamic> getCurrentWalletUser() {
    return _$getUserWalletAsyncAction.run(() => super.getCurrentWalletUser());
  }
  final _$updateUserAsyncAction = AsyncAction('_UserStore.updateCurrentUser');
  @override
  Future<dynamic> updateCurrentUser(String name,String surname,String phonenumber,String email,String userName) {
    return _$getUserAsyncAction.run(() => super.updateCurrentUser(name,surname,phonenumber,email,userName));
  }
  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
isLoading: ${isLoading}
    ''';
  }
}
