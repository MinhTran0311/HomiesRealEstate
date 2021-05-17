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

  final _$getRolesAsyncAction = AsyncAction('_RoleManagementStore.getRoles');

  @override
  Future<dynamic> getRoles() {
    return _$getRolesAsyncAction.run(() => super.getRoles());
  }

  @override
  String toString() {
    return '''
fetchRolesFuture: ${fetchRolesFuture},
roleList: ${roleList},
successGetRoles: ${successGetRoles},
loading: ${loading}
    ''';
  }
}
