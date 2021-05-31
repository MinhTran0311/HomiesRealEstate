// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danhMucManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DanhMucManagementStore on _DanhMucManagementStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_DanhMucManagementStore.loading'))
      .value;
  Computed<bool> _$loadingCountAllDanhMucsComputed;

  @override
  bool get loadingCountAllDanhMucs => (_$loadingCountAllDanhMucsComputed ??=
          Computed<bool>(() => super.loadingCountAllDanhMucs,
              name: '_DanhMucManagementStore.loadingCountAllDanhMucs'))
      .value;

  final _$fetchDanhMucsFutureAtom =
      Atom(name: '_DanhMucManagementStore.fetchDanhMucsFuture');

  @override
  ObservableFuture<DanhMucList> get fetchDanhMucsFuture {
    _$fetchDanhMucsFutureAtom.reportRead();
    return super.fetchDanhMucsFuture;
  }

  @override
  set fetchDanhMucsFuture(ObservableFuture<DanhMucList> value) {
    _$fetchDanhMucsFutureAtom.reportWrite(value, super.fetchDanhMucsFuture, () {
      super.fetchDanhMucsFuture = value;
    });
  }

  final _$fetchCountAllDanhMucsFutureAtom =
      Atom(name: '_DanhMucManagementStore.fetchCountAllDanhMucsFuture');

  @override
  ObservableFuture<dynamic> get fetchCountAllDanhMucsFuture {
    _$fetchCountAllDanhMucsFutureAtom.reportRead();
    return super.fetchCountAllDanhMucsFuture;
  }

  @override
  set fetchCountAllDanhMucsFuture(ObservableFuture<dynamic> value) {
    _$fetchCountAllDanhMucsFutureAtom
        .reportWrite(value, super.fetchCountAllDanhMucsFuture, () {
      super.fetchCountAllDanhMucsFuture = value;
    });
  }

  final _$danhMucListAtom = Atom(name: '_DanhMucManagementStore.danhMucList');

  @override
  DanhMucList get danhMucList {
    _$danhMucListAtom.reportRead();
    return super.danhMucList;
  }

  @override
  set danhMucList(DanhMucList value) {
    _$danhMucListAtom.reportWrite(value, super.danhMucList, () {
      super.danhMucList = value;
    });
  }

  final _$countAllDanhMucsAtom =
      Atom(name: '_DanhMucManagementStore.countAllDanhMucs');

  @override
  int get countAllDanhMucs {
    _$countAllDanhMucsAtom.reportRead();
    return super.countAllDanhMucs;
  }

  @override
  set countAllDanhMucs(int value) {
    _$countAllDanhMucsAtom.reportWrite(value, super.countAllDanhMucs, () {
      super.countAllDanhMucs = value;
    });
  }

  final _$getDanhMucsAsyncAction =
      AsyncAction('_DanhMucManagementStore.getDanhMucs');

  @override
  Future<dynamic> getDanhMucs() {
    return _$getDanhMucsAsyncAction.run(() => super.getDanhMucs());
  }

  final _$fCountAllDanhMucsAsyncAction =
      AsyncAction('_DanhMucManagementStore.fCountAllDanhMucs');

  @override
  Future<dynamic> fCountAllDanhMucs() {
    return _$fCountAllDanhMucsAsyncAction.run(() => super.fCountAllDanhMucs());
  }

  @override
  String toString() {
    return '''
fetchDanhMucsFuture: ${fetchDanhMucsFuture},
fetchCountAllDanhMucsFuture: ${fetchCountAllDanhMucsFuture},
danhMucList: ${danhMucList},
countAllDanhMucs: ${countAllDanhMucs},
loading: ${loading},
loadingCountAllDanhMucs: ${loadingCountAllDanhMucs}
    ''';
  }
}
