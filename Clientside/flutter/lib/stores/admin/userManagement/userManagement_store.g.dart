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
  ObservableFuture<getAvatarUser> get fetchAvatarUserFuture {
    _$fetchAvatarUserFutureAtom.reportRead();
    return super.fetchAvatarUserFuture;
  }

  @override
  set fetchAvatarUserFuture(ObservableFuture<getAvatarUser> value) {
    _$fetchAvatarUserFutureAtom.reportWrite(value, super.fetchAvatarUserFuture,
        () {
      super.fetchAvatarUserFuture = value;
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
  getAvatarUser get avatarUser {
    _$avatarUserAtom.reportRead();
    return super.avatarUser;
  }

  @override
  set avatarUser(getAvatarUser value) {
    _$avatarUserAtom.reportWrite(value, super.avatarUser, () {
      super.avatarUser = value;
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

  final _$getUsersAsyncAction = AsyncAction('_UserManagementStore.getUsers');

  @override
  Future<dynamic> getUsers() {
    return _$getUsersAsyncAction.run(() => super.getUsers());
  }

  final _$getAvatarUsersAsyncAction =
      AsyncAction('_UserManagementStore.getAvatarUsers');

  @override
  Future<dynamic> getAvatarUsers(int Id) {
    return _$getAvatarUsersAsyncAction.run(() => super.getAvatarUsers(Id));
  }

  @override
  String toString() {
    return '''
fetchUsersFuture: ${fetchUsersFuture},
fetchAvatarUserFuture: ${fetchAvatarUserFuture},
userList: ${userList},
avatarUser: ${avatarUser},
successGetUsers: ${successGetUsers},
loading: ${loading}
    ''';
  }
}
