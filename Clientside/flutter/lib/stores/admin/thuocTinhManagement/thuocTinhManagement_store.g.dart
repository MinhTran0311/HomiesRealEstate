// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thuocTinhManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThuocTinhManagementStore on _ThuocTinhManagementStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_ThuocTinhManagementStore.loading'))
      .value;
  Computed<bool> _$loadingCountAllThuocTinhsComputed;

  @override
  bool get loadingCountAllThuocTinhs => (_$loadingCountAllThuocTinhsComputed ??=
          Computed<bool>(() => super.loadingCountAllThuocTinhs,
              name: '_ThuocTinhManagementStore.loadingCountAllThuocTinhs'))
      .value;

  final _$fetchThuocTinhsFutureAtom =
      Atom(name: '_ThuocTinhManagementStore.fetchThuocTinhsFuture');

  @override
  ObservableFuture<ThuocTinhManagementList> get fetchThuocTinhsFuture {
    _$fetchThuocTinhsFutureAtom.reportRead();
    return super.fetchThuocTinhsFuture;
  }

  @override
  set fetchThuocTinhsFuture(ObservableFuture<ThuocTinhManagementList> value) {
    _$fetchThuocTinhsFutureAtom.reportWrite(value, super.fetchThuocTinhsFuture,
        () {
      super.fetchThuocTinhsFuture = value;
    });
  }

  final _$fetchCountAllThuocTinhsFutureAtom =
      Atom(name: '_ThuocTinhManagementStore.fetchCountAllThuocTinhsFuture');

  @override
  ObservableFuture<dynamic> get fetchCountAllThuocTinhsFuture {
    _$fetchCountAllThuocTinhsFutureAtom.reportRead();
    return super.fetchCountAllThuocTinhsFuture;
  }

  @override
  set fetchCountAllThuocTinhsFuture(ObservableFuture<dynamic> value) {
    _$fetchCountAllThuocTinhsFutureAtom
        .reportWrite(value, super.fetchCountAllThuocTinhsFuture, () {
      super.fetchCountAllThuocTinhsFuture = value;
    });
  }

  final _$thuocTinhListAtom =
      Atom(name: '_ThuocTinhManagementStore.thuocTinhList');

  @override
  ThuocTinhManagementList get thuocTinhList {
    _$thuocTinhListAtom.reportRead();
    return super.thuocTinhList;
  }

  @override
  set thuocTinhList(ThuocTinhManagementList value) {
    _$thuocTinhListAtom.reportWrite(value, super.thuocTinhList, () {
      super.thuocTinhList = value;
    });
  }

  final _$countAllThuocTinhsAtom =
      Atom(name: '_ThuocTinhManagementStore.countAllThuocTinhs');

  @override
  int get countAllThuocTinhs {
    _$countAllThuocTinhsAtom.reportRead();
    return super.countAllThuocTinhs;
  }

  @override
  set countAllThuocTinhs(int value) {
    _$countAllThuocTinhsAtom.reportWrite(value, super.countAllThuocTinhs, () {
      super.countAllThuocTinhs = value;
    });
  }

  final _$getThuocTinhsAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.getThuocTinhs');

  @override
  Future<dynamic> getThuocTinhs() {
    return _$getThuocTinhsAsyncAction.run(() => super.getThuocTinhs());
  }

  final _$fCountAllThuocTinhsAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.fCountAllThuocTinhs');

  @override
  Future<dynamic> fCountAllThuocTinhs() {
    return _$fCountAllThuocTinhsAsyncAction
        .run(() => super.fCountAllThuocTinhs());
  }

  @override
  String toString() {
    return '''
fetchThuocTinhsFuture: ${fetchThuocTinhsFuture},
fetchCountAllThuocTinhsFuture: ${fetchCountAllThuocTinhsFuture},
thuocTinhList: ${thuocTinhList},
countAllThuocTinhs: ${countAllThuocTinhs},
loading: ${loading},
loadingCountAllThuocTinhs: ${loadingCountAllThuocTinhs}
    ''';
  }
}
