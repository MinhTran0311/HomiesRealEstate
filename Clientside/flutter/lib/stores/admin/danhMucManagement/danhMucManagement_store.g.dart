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
  Computed<bool> _$loadingUpdateDanhMucComputed;

  @override
  bool get loadingUpdateDanhMuc => (_$loadingUpdateDanhMucComputed ??=
          Computed<bool>(() => super.loadingUpdateDanhMuc,
              name: '_DanhMucManagementStore.loadingUpdateDanhMuc'))
      .value;
  Computed<bool> _$loadingCreateDanhMucComputed;

  @override
  bool get loadingCreateDanhMuc => (_$loadingCreateDanhMucComputed ??=
          Computed<bool>(() => super.loadingCreateDanhMuc,
              name: '_DanhMucManagementStore.loadingCreateDanhMuc'))
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

  final _$fetchUpdateDanhMucFutureAtom =
      Atom(name: '_DanhMucManagementStore.fetchUpdateDanhMucFuture');

  @override
  ObservableFuture<dynamic> get fetchUpdateDanhMucFuture {
    _$fetchUpdateDanhMucFutureAtom.reportRead();
    return super.fetchUpdateDanhMucFuture;
  }

  @override
  set fetchUpdateDanhMucFuture(ObservableFuture<dynamic> value) {
    _$fetchUpdateDanhMucFutureAtom
        .reportWrite(value, super.fetchUpdateDanhMucFuture, () {
      super.fetchUpdateDanhMucFuture = value;
    });
  }

  final _$fetchCreateDanhMucFutureAtom =
      Atom(name: '_DanhMucManagementStore.fetchCreateDanhMucFuture');

  @override
  ObservableFuture<dynamic> get fetchCreateDanhMucFuture {
    _$fetchCreateDanhMucFutureAtom.reportRead();
    return super.fetchCreateDanhMucFuture;
  }

  @override
  set fetchCreateDanhMucFuture(ObservableFuture<dynamic> value) {
    _$fetchCreateDanhMucFutureAtom
        .reportWrite(value, super.fetchCreateDanhMucFuture, () {
      super.fetchCreateDanhMucFuture = value;
    });
  }

  final _$danhMucIdAtom = Atom(name: '_DanhMucManagementStore.danhMucId');

  @override
  int get danhMucId {
    _$danhMucIdAtom.reportRead();
    return super.danhMucId;
  }

  @override
  set danhMucId(int value) {
    _$danhMucIdAtom.reportWrite(value, super.danhMucId, () {
      super.danhMucId = value;
    });
  }

  final _$tenDanhMucAtom = Atom(name: '_DanhMucManagementStore.tenDanhMuc');

  @override
  String get tenDanhMuc {
    _$tenDanhMucAtom.reportRead();
    return super.tenDanhMuc;
  }

  @override
  set tenDanhMuc(String value) {
    _$tenDanhMucAtom.reportWrite(value, super.tenDanhMuc, () {
      super.tenDanhMuc = value;
    });
  }

  final _$tagAtom = Atom(name: '_DanhMucManagementStore.tag');

  @override
  String get tag {
    _$tagAtom.reportRead();
    return super.tag;
  }

  @override
  set tag(String value) {
    _$tagAtom.reportWrite(value, super.tag, () {
      super.tag = value;
    });
  }

  final _$danhMucChaAtom = Atom(name: '_DanhMucManagementStore.danhMucCha');

  @override
  int get danhMucCha {
    _$danhMucChaAtom.reportRead();
    return super.danhMucCha;
  }

  @override
  set danhMucCha(int value) {
    _$danhMucChaAtom.reportWrite(value, super.danhMucCha, () {
      super.danhMucCha = value;
    });
  }

  final _$trangThaiAtom = Atom(name: '_DanhMucManagementStore.trangThai');

  @override
  String get trangThai {
    _$trangThaiAtom.reportRead();
    return super.trangThai;
  }

  @override
  set trangThai(String value) {
    _$trangThaiAtom.reportWrite(value, super.trangThai, () {
      super.trangThai = value;
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

  final _$updateDanhMuc_successAtom =
      Atom(name: '_DanhMucManagementStore.updateDanhMuc_success');

  @override
  bool get updateDanhMuc_success {
    _$updateDanhMuc_successAtom.reportRead();
    return super.updateDanhMuc_success;
  }

  @override
  set updateDanhMuc_success(bool value) {
    _$updateDanhMuc_successAtom.reportWrite(value, super.updateDanhMuc_success,
        () {
      super.updateDanhMuc_success = value;
    });
  }

  final _$createDanhMuc_successAtom =
      Atom(name: '_DanhMucManagementStore.createDanhMuc_success');

  @override
  bool get createDanhMuc_success {
    _$createDanhMuc_successAtom.reportRead();
    return super.createDanhMuc_success;
  }

  @override
  set createDanhMuc_success(bool value) {
    _$createDanhMuc_successAtom.reportWrite(value, super.createDanhMuc_success,
        () {
      super.createDanhMuc_success = value;
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

  final _$UpdateDanhMucAsyncAction =
      AsyncAction('_DanhMucManagementStore.UpdateDanhMuc');

  @override
  Future<dynamic> UpdateDanhMuc() {
    return _$UpdateDanhMucAsyncAction.run(() => super.UpdateDanhMuc());
  }

  final _$CreateDanhMucAsyncAction =
      AsyncAction('_DanhMucManagementStore.CreateDanhMuc');

  @override
  Future<dynamic> CreateDanhMuc() {
    return _$CreateDanhMucAsyncAction.run(() => super.CreateDanhMuc());
  }

  @override
  String toString() {
    return '''
fetchDanhMucsFuture: ${fetchDanhMucsFuture},
fetchCountAllDanhMucsFuture: ${fetchCountAllDanhMucsFuture},
fetchUpdateDanhMucFuture: ${fetchUpdateDanhMucFuture},
fetchCreateDanhMucFuture: ${fetchCreateDanhMucFuture},
danhMucId: ${danhMucId},
tenDanhMuc: ${tenDanhMuc},
tag: ${tag},
danhMucCha: ${danhMucCha},
trangThai: ${trangThai},
danhMucList: ${danhMucList},
countAllDanhMucs: ${countAllDanhMucs},
updateDanhMuc_success: ${updateDanhMuc_success},
createDanhMuc_success: ${createDanhMuc_success},
loading: ${loading},
loadingCountAllDanhMucs: ${loadingCountAllDanhMucs},
loadingUpdateDanhMuc: ${loadingUpdateDanhMuc},
loadingCreateDanhMuc: ${loadingCreateDanhMuc}
    ''';
  }
}
