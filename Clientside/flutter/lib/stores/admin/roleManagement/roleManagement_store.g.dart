// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roleManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoleManagementStore on _RoleManagementStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_RoleManagementStore.loading'))
      .value;
  Computed<bool> _$loadingCountAllRolesComputed;

  @override
  bool get loadingCountAllRoles => (_$loadingCountAllRolesComputed ??=
          Computed<bool>(() => super.loadingCountAllRoles,
              name: '_RoleManagementStore.loadingCountAllRoles'))
      .value;

  final _$fetchRolesFutureAtom =
      Atom(name: '_RoleManagementStore.fetchRolesFuture');

  @override
  ObservableFuture<RoleList> get fetchRolesFuture {
    _$fetchRolesFutureAtom.reportRead();
    return super.fetchRolesFuture;
  }

  @override
  set fetchRolesFuture(ObservableFuture<RoleList> value) {
    _$fetchRolesFutureAtom.reportWrite(value, super.fetchRolesFuture, () {
      super.fetchRolesFuture = value;
    });
  }

  final _$fetchCountAllRolesFutureAtom =
      Atom(name: '_RoleManagementStore.fetchCountAllRolesFuture');

  @override
  ObservableFuture<dynamic> get fetchCountAllRolesFuture {
    _$fetchCountAllRolesFutureAtom.reportRead();
    return super.fetchCountAllRolesFuture;
  }

  @override
  set fetchCountAllRolesFuture(ObservableFuture<dynamic> value) {
    _$fetchCountAllRolesFutureAtom
        .reportWrite(value, super.fetchCountAllRolesFuture, () {
      super.fetchCountAllRolesFuture = value;
    });
  }

  final _$roleListAtom = Atom(name: '_RoleManagementStore.roleList');

  @override
  RoleList get roleList {
    _$roleListAtom.reportRead();
    return super.roleList;
  }

  @override
  set roleList(RoleList value) {
    _$roleListAtom.reportWrite(value, super.roleList, () {
      super.roleList = value;
    });
  }

  final _$successGetRolesAtom =
      Atom(name: '_RoleManagementStore.successGetRoles');

  @override
  bool get successGetRoles {
    _$successGetRolesAtom.reportRead();
    return super.successGetRoles;
  }

  @override
  set successGetRoles(bool value) {
    _$successGetRolesAtom.reportWrite(value, super.successGetRoles, () {
      super.successGetRoles = value;
    });
  }

  final _$countAllRolesAtom = Atom(name: '_RoleManagementStore.countAllRoles');

  @override
  int get countAllRoles {
    _$countAllRolesAtom.reportRead();
    return super.countAllRoles;
  }

  @override
  set countAllRoles(int value) {
    _$countAllRolesAtom.reportWrite(value, super.countAllRoles, () {
      super.countAllRoles = value;
    });
  }

  final _$getRolesAsyncAction = AsyncAction('_RoleManagementStore.getRoles');

  @override
  Future<dynamic> getRoles() {
    return _$getRolesAsyncAction.run(() => super.getRoles());
  }

  final _$fCountAllRolesAsyncAction =
      AsyncAction('_RoleManagementStore.fCountAllRoles');

  @override
  Future<dynamic> fCountAllRoles() {
    return _$fCountAllRolesAsyncAction.run(() => super.fCountAllRoles());
  }

  @override
  String toString() {
    return '''
fetchRolesFuture: ${fetchRolesFuture},
fetchCountAllRolesFuture: ${fetchCountAllRolesFuture},
roleList: ${roleList},
successGetRoles: ${successGetRoles},
countAllRoles: ${countAllRoles},
loading: ${loading},
loadingCountAllRoles: ${loadingCountAllRoles}
    ''';
  }
}
