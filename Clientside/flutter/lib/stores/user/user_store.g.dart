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
  Computed<bool> _$loadingsUserByIDComputed;

  @override
  bool get loadingsUserByID => (_$loadingsUserByIDComputed ??= Computed<bool>(
          () => super.loadingsUserByID,
          name: '_UserStore.loadingsUserByID'))
      .value;
  Computed<bool> _$loadingCurrentUserComputed;

  @override
  bool get loadingCurrentUser => (_$loadingCurrentUserComputed ??=
          Computed<bool>(() => super.loadingCurrentUser,
              name: '_UserStore.loadingCurrentUser'))
      .value;
  Computed<bool> _$loadingCurrentUserWalletComputed;

  @override
  bool get loadingCurrentUserWallet => (_$loadingCurrentUserWalletComputed ??=
          Computed<bool>(() => super.loadingCurrentUserWallet,
              name: '_UserStore.loadingCurrentUserWallet'))
      .value;
  Computed<bool> _$isLoadingCurrentUserComputed;

  @override
  bool get isLoadingCurrentUser => (_$isLoadingCurrentUserComputed ??=
          Computed<bool>(() => super.isLoadingCurrentUser,
              name: '_UserStore.isLoadingCurrentUser'))
      .value;
  Computed<bool> _$loadingsUpdateUserComputed;

  @override
  bool get loadingsUpdateUser => (_$loadingsUpdateUserComputed ??=
          Computed<bool>(() => super.loadingsUpdateUser,
              name: '_UserStore.loadingsUpdateUser'))
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

  final _$userByIDAtom = Atom(name: '_UserStore.userByID');

  @override
  User get userByID {
    _$userByIDAtom.reportRead();
    return super.userByID;
  }

  @override
  set userByID(User value) {
    _$userByIDAtom.reportWrite(value, super.userByID, () {
      super.userByID = value;
    });
  }

  final _$fetchUsersByIDFuturesAtom =
      Atom(name: '_UserStore.fetchUsersByIDFutures');

  @override
  ObservableFuture<User> get fetchUsersByIDFutures {
    _$fetchUsersByIDFuturesAtom.reportRead();
    return super.fetchUsersByIDFutures;
  }

  @override
  set fetchUsersByIDFutures(ObservableFuture<User> value) {
    _$fetchUsersByIDFuturesAtom.reportWrite(value, super.fetchUsersByIDFutures,
        () {
      super.fetchUsersByIDFutures = value;
    });
  }

  final _$UserByIDFuturessAtom = Atom(name: '_UserStore.UserByIDFuturess');

  @override
  ObservableFuture<User> get UserByIDFuturess {
    _$UserByIDFuturessAtom.reportRead();
    return super.UserByIDFuturess;
  }

  @override
  set UserByIDFuturess(ObservableFuture<User> value) {
    _$UserByIDFuturessAtom.reportWrite(value, super.UserByIDFuturess, () {
      super.UserByIDFuturess = value;
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

  final _$fetchUserCurrentFutureAtom =
      Atom(name: '_UserStore.fetchUserCurrentFuture');

  @override
  ObservableFuture<CurrentUserForEditdto> get fetchUserCurrentFuture {
    _$fetchUserCurrentFutureAtom.reportRead();
    return super.fetchUserCurrentFuture;
  }

  @override
  set fetchUserCurrentFuture(ObservableFuture<CurrentUserForEditdto> value) {
    _$fetchUserCurrentFutureAtom
        .reportWrite(value, super.fetchUserCurrentFuture, () {
      super.fetchUserCurrentFuture = value;
    });
  }

  final _$fetchUserCurrentWalletFutureAtom =
      Atom(name: '_UserStore.fetchUserCurrentWalletFuture');

  @override
  ObservableFuture<CurrentUserForEditdto> get fetchUserCurrentWalletFuture {
    _$fetchUserCurrentWalletFutureAtom.reportRead();
    return super.fetchUserCurrentWalletFuture;
  }

  @override
  set fetchUserCurrentWalletFuture(
      ObservableFuture<CurrentUserForEditdto> value) {
    _$fetchUserCurrentWalletFutureAtom
        .reportWrite(value, super.fetchUserCurrentWalletFuture, () {
      super.fetchUserCurrentWalletFuture = value;
    });
  }

  final _$CurrentUserFutureAtom = Atom(name: '_UserStore.CurrentUserFuture');

  @override
  ObservableFuture<CurrentUserForEditdto> get CurrentUserFuture {
    _$CurrentUserFutureAtom.reportRead();
    return super.CurrentUserFuture;
  }

  @override
  set CurrentUserFuture(ObservableFuture<CurrentUserForEditdto> value) {
    _$CurrentUserFutureAtom.reportWrite(value, super.CurrentUserFuture, () {
      super.CurrentUserFuture = value;
    });
  }

  final _$fetchUpdateUserFuturesAtom =
      Atom(name: '_UserStore.fetchUpdateUserFutures');

  @override
  ObservableFuture<CurrentUserForEditdto> get fetchUpdateUserFutures {
    _$fetchUpdateUserFuturesAtom.reportRead();
    return super.fetchUpdateUserFutures;
  }

  @override
  set fetchUpdateUserFutures(ObservableFuture<CurrentUserForEditdto> value) {
    _$fetchUpdateUserFuturesAtom
        .reportWrite(value, super.fetchUpdateUserFutures, () {
      super.fetchUpdateUserFutures = value;
    });
  }

  final _$UpdateUserFuturessAtom = Atom(name: '_UserStore.UpdateUserFuturess');

  @override
  ObservableFuture<CurrentUserForEditdto> get UpdateUserFuturess {
    _$UpdateUserFuturessAtom.reportRead();
    return super.UpdateUserFuturess;
  }

  @override
  set UpdateUserFuturess(ObservableFuture<CurrentUserForEditdto> value) {
    _$UpdateUserFuturessAtom.reportWrite(value, super.UpdateUserFuturess, () {
      super.UpdateUserFuturess = value;
    });
  }

  final _$loginAsyncAction = AsyncAction('_UserStore.login');

  @override
  Future<dynamic> login(String email, String password) {
    return _$loginAsyncAction.run(() => super.login(email, password));
  }

  final _$getUserByIDAsyncAction = AsyncAction('_UserStore.getUserByID');

  @override
  Future<dynamic> getUserByID(int userID) {
    return _$getUserByIDAsyncAction.run(() => super.getUserByID(userID));
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

  final _$getUserOfCurrentDetailPostAsyncAction =
      AsyncAction('_UserStore.getUserOfCurrentDetailPost');

  @override
  Future<dynamic> getUserOfCurrentDetailPost(int Id) {
    return _$getUserOfCurrentDetailPostAsyncAction
        .run(() => super.getUserOfCurrentDetailPost(Id));
  }

  final _$updateCurrentUserAsyncAction =
      AsyncAction('_UserStore.updateCurrentUser');

  @override
  Future<dynamic> updateCurrentUser(String name, String surname,
      String phonenumber, String email, String userName) {
    return _$updateCurrentUserAsyncAction.run(() =>
        super.updateCurrentUser(name, surname, phonenumber, email, userName));
  }

  @override
  String toString() {
    return '''
success: ${success},
loginFuture: ${loginFuture},
userByID: ${userByID},
fetchUsersByIDFutures: ${fetchUsersByIDFutures},
UserByIDFuturess: ${UserByIDFuturess},
user: ${user},
fetchUserCurrentFuture: ${fetchUserCurrentFuture},
fetchUserCurrentWalletFuture: ${fetchUserCurrentWalletFuture},
CurrentUserFuture: ${CurrentUserFuture},
fetchUpdateUserFutures: ${fetchUpdateUserFutures},
UpdateUserFuturess: ${UpdateUserFuturess},
isLoading: ${isLoading},
loadingsUserByID: ${loadingsUserByID},
loadingCurrentUser: ${loadingCurrentUser},
loadingCurrentUserWallet: ${loadingCurrentUserWallet},
isLoadingCurrentUser: ${isLoadingCurrentUser},
loadingsUpdateUser: ${loadingsUpdateUser}
    ''';
  }
}
