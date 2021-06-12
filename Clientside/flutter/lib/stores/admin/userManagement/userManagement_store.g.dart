// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserManagementStore on _UserManagementStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_UserManagementStore.loading'))
      .value;
  Computed<bool> _$loadingAvatarComputed;

  @override
  bool get loadingAvatar =>
      (_$loadingAvatarComputed ??= Computed<bool>(() => super.loadingAvatar,
              name: '_UserManagementStore.loadingAvatar'))
          .value;
  Computed<bool> _$loadingCountAllUserComputed;

  @override
  bool get loadingCountAllUser => (_$loadingCountAllUserComputed ??=
          Computed<bool>(() => super.loadingCountAllUser,
              name: '_UserManagementStore.loadingCountAllUser'))
      .value;
  Computed<bool> _$loadingCountNewUsersInMonthComputed;

  @override
  bool get loadingCountNewUsersInMonth =>
      (_$loadingCountNewUsersInMonthComputed ??= Computed<bool>(
              () => super.loadingCountNewUsersInMonth,
              name: '_UserManagementStore.loadingCountNewUsersInMonth'))
          .value;

  final _$fetchUsersFutureAtom =
      Atom(name: '_UserManagementStore.fetchUsersFuture');

  @override
  ObservableFuture<UserList> get fetchUsersFuture {
    _$fetchUsersFutureAtom.reportRead();
    return super.fetchUsersFuture;
  }

  @override
  set fetchUsersFuture(ObservableFuture<UserList> value) {
    _$fetchUsersFutureAtom.reportWrite(value, super.fetchUsersFuture, () {
      super.fetchUsersFuture = value;
    });
  }

  final _$fetchAvatarUserFutureAtom =
      Atom(name: '_UserManagementStore.fetchAvatarUserFuture');

  @override
  ObservableFuture<dynamic> get fetchAvatarUserFuture {
    _$fetchAvatarUserFutureAtom.reportRead();
    return super.fetchAvatarUserFuture;
  }

  @override
  set fetchAvatarUserFuture(ObservableFuture<dynamic> value) {
    _$fetchAvatarUserFutureAtom.reportWrite(value, super.fetchAvatarUserFuture,
        () {
      super.fetchAvatarUserFuture = value;
    });
  }

  final _$fetchCountAllUsersFutureAtom =
      Atom(name: '_UserManagementStore.fetchCountAllUsersFuture');

  @override
  ObservableFuture<dynamic> get fetchCountAllUsersFuture {
    _$fetchCountAllUsersFutureAtom.reportRead();
    return super.fetchCountAllUsersFuture;
  }

  @override
  set fetchCountAllUsersFuture(ObservableFuture<dynamic> value) {
    _$fetchCountAllUsersFutureAtom
        .reportWrite(value, super.fetchCountAllUsersFuture, () {
      super.fetchCountAllUsersFuture = value;
    });
  }

  final _$fetchCountNewUsersInMonthFutureAtom =
      Atom(name: '_UserManagementStore.fetchCountNewUsersInMonthFuture');

  @override
  ObservableFuture<dynamic> get fetchCountNewUsersInMonthFuture {
    _$fetchCountNewUsersInMonthFutureAtom.reportRead();
    return super.fetchCountNewUsersInMonthFuture;
  }

  @override
  set fetchCountNewUsersInMonthFuture(ObservableFuture<dynamic> value) {
    _$fetchCountNewUsersInMonthFutureAtom
        .reportWrite(value, super.fetchCountNewUsersInMonthFuture, () {
      super.fetchCountNewUsersInMonthFuture = value;
    });
  }

  final _$countAllUsersAtom = Atom(name: '_UserManagementStore.countAllUsers');

  @override
  int get countAllUsers {
    _$countAllUsersAtom.reportRead();
    return super.countAllUsers;
  }

  @override
  set countAllUsers(int value) {
    _$countAllUsersAtom.reportWrite(value, super.countAllUsers, () {
      super.countAllUsers = value;
    });
  }

  final _$countNewUsersInMonthAtom =
      Atom(name: '_UserManagementStore.countNewUsersInMonth');

  @override
  int get countNewUsersInMonth {
    _$countNewUsersInMonthAtom.reportRead();
    return super.countNewUsersInMonth;
  }

  @override
  set countNewUsersInMonth(int value) {
    _$countNewUsersInMonthAtom.reportWrite(value, super.countNewUsersInMonth,
        () {
      super.countNewUsersInMonth = value;
    });
  }

  final _$userListAtom = Atom(name: '_UserManagementStore.userList');

  @override
  UserList get userList {
    _$userListAtom.reportRead();
    return super.userList;
  }

  @override
  set userList(UserList value) {
    _$userListAtom.reportWrite(value, super.userList, () {
      super.userList = value;
    });
  }

  final _$avatarUserAtom = Atom(name: '_UserManagementStore.avatarUser');

  @override
  String get avatarUser {
    _$avatarUserAtom.reportRead();
    return super.avatarUser;
  }

  @override
  set avatarUser(String value) {
    _$avatarUserAtom.reportWrite(value, super.avatarUser, () {
      super.avatarUser = value;
    });
  }

  final _$dateCurrentAtom = Atom(name: '_UserManagementStore.dateCurrent');

  @override
  DateTime get dateCurrent {
    _$dateCurrentAtom.reportRead();
    return super.dateCurrent;
  }

  @override
  set dateCurrent(DateTime value) {
    _$dateCurrentAtom.reportWrite(value, super.dateCurrent, () {
      super.dateCurrent = value;
    });
  }

  final _$skipCountAtom = Atom(name: '_UserManagementStore.skipCount');

  @override
  int get skipCount {
    _$skipCountAtom.reportRead();
    return super.skipCount;
  }

  @override
  set skipCount(int value) {
    _$skipCountAtom.reportWrite(value, super.skipCount, () {
      super.skipCount = value;
    });
  }

  final _$skipIndexAtom = Atom(name: '_UserManagementStore.skipIndex');

  @override
  int get skipIndex {
    _$skipIndexAtom.reportRead();
    return super.skipIndex;
  }

  @override
  set skipIndex(int value) {
    _$skipIndexAtom.reportWrite(value, super.skipIndex, () {
      super.skipIndex = value;
    });
  }

  final _$maxCountAtom = Atom(name: '_UserManagementStore.maxCount');

  @override
  int get maxCount {
    _$maxCountAtom.reportRead();
    return super.maxCount;
  }

  @override
  set maxCount(int value) {
    _$maxCountAtom.reportWrite(value, super.maxCount, () {
      super.maxCount = value;
    });
  }

  final _$isIntialLoadingAtom =
      Atom(name: '_UserManagementStore.isIntialLoading');

  @override
  bool get isIntialLoading {
    _$isIntialLoadingAtom.reportRead();
    return super.isIntialLoading;
  }

  @override
  set isIntialLoading(bool value) {
    _$isIntialLoadingAtom.reportWrite(value, super.isIntialLoading, () {
      super.isIntialLoading = value;
    });
  }

  final _$successGetUsersAtom =
      Atom(name: '_UserManagementStore.successGetUsers');

  @override
  bool get successGetUsers {
    _$successGetUsersAtom.reportRead();
    return super.successGetUsers;
  }

  @override
  set successGetUsers(bool value) {
    _$successGetUsersAtom.reportWrite(value, super.successGetUsers, () {
      super.successGetUsers = value;
    });
  }

  final _$fCountAllUsersAsyncAction =
      AsyncAction('_UserManagementStore.fCountAllUsers');

  @override
  Future<dynamic> fCountAllUsers() {
    return _$fCountAllUsersAsyncAction.run(() => super.fCountAllUsers());
  }

  final _$fCountNewUsersInMonthAsyncAction =
      AsyncAction('_UserManagementStore.fCountNewUsersInMonth');

  @override
  Future<dynamic> fCountNewUsersInMonth() {
    return _$fCountNewUsersInMonthAsyncAction
        .run(() => super.fCountNewUsersInMonth());
  }

  final _$_UserManagementStoreActionController =
      ActionController(name: '_UserManagementStore');

  @override
  Future<dynamic> getUsers(bool isLoadMore) {
    final _$actionInfo = _$_UserManagementStoreActionController.startAction(
        name: '_UserManagementStore.getUsers');
    try {
      return super.getUsers(isLoadMore);
    } finally {
      _$_UserManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchUsersFuture: ${fetchUsersFuture},
fetchAvatarUserFuture: ${fetchAvatarUserFuture},
fetchCountAllUsersFuture: ${fetchCountAllUsersFuture},
fetchCountNewUsersInMonthFuture: ${fetchCountNewUsersInMonthFuture},
countAllUsers: ${countAllUsers},
countNewUsersInMonth: ${countNewUsersInMonth},
userList: ${userList},
avatarUser: ${avatarUser},
dateCurrent: ${dateCurrent},
skipCount: ${skipCount},
skipIndex: ${skipIndex},
maxCount: ${maxCount},
isIntialLoading: ${isIntialLoading},
successGetUsers: ${successGetUsers},
loading: ${loading},
loadingAvatar: ${loadingAvatar},
loadingCountAllUser: ${loadingCountAllUser},
loadingCountNewUsersInMonth: ${loadingCountNewUsersInMonth}
    ''';
  }
}
