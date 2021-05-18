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
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_UserStore.loading'))
      .value;
  Computed<bool> _$isLoadingsComputed;

  @override
  bool get isLoadings => (_$isLoadingsComputed ??=
          Computed<bool>(() => super.isLoadings, name: '_UserStore.isLoadings'))
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

  final _$userAtom = Atom(name: '_UserStore.user');

  @override
  CurrentUserForEditdto get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(CurrentUserForEditdto value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$fetchUsersFutureAtom = Atom(name: '_UserStore.fetchUsersFuture');

  @override
  ObservableFuture<CurrentUserForEditdto> get fetchUsersFuture {
    _$fetchUsersFutureAtom.reportRead();
    return super.fetchUsersFuture;
  }

  @override
  set fetchUsersFuture(ObservableFuture<CurrentUserForEditdto> value) {
    _$fetchUsersFutureAtom.reportWrite(value, super.fetchUsersFuture, () {
      super.fetchUsersFuture = value;
    });
  }

  final _$loginFuturesAtom = Atom(name: '_UserStore.loginFutures');

  @override
  ObservableFuture<CurrentUserForEditdto> get loginFutures {
    _$loginFuturesAtom.reportRead();
    return super.loginFutures;
  }

  @override
  set loginFutures(ObservableFuture<CurrentUserForEditdto> value) {
    _$loginFuturesAtom.reportWrite(value, super.loginFutures, () {
      super.loginFutures = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$getCurrentUserAsyncAction = AsyncAction('_UserStore.getCurrentUser');

  @override
  Future<dynamic> getCurrentUser() {
    return _$getCurrentUserAsyncAction.run(() => super.getCurrentUser());
  }

  final _$getCurrentWalletUserAsyncAction =
      AsyncAction('_UserStore.getCurrentWalletUser');

  @override
  Future<dynamic> getCurrentWalletUser() {
    return _$getCurrentWalletUserAsyncAction
        .run(() => super.getCurrentWalletUser());
  }

  final _$updateCurrentUserAsyncAction =
      AsyncAction('_UserStore.updateCurrentUser');

  @override
  Future<dynamic> updateCurrentUser(String name, String surname,
      String phonenumber, String email, String userName) {
    return _$updateCurrentUserAsyncAction.run(() =>
        super.updateCurrentUser(name, surname, phonenumber, email, userName));
  }

  final _$getUserOfCurrentDetailPostAsyncAction =
      AsyncAction('_UserStore.getUserOfCurrentDetailPost');

  @override
  Future<dynamic> getUserOfCurrentDetailPost(int Id) {
    return _$getUserOfCurrentDetailPostAsyncAction
        .run(() => super.getUserOfCurrentDetailPost(Id));
  }

  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
user: ${user},
fetchUsersFuture: ${fetchUsersFuture},
loginFutures: ${loginFutures},
isLoading: ${isLoading},
loading: ${loading},
isLoadings: ${isLoadings}
    ''';
  }
}
