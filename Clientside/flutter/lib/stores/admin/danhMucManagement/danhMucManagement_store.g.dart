// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'danhMucManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DanhMucManagementStore on _DanhMucManagementStore, Store {
  Computed<bool> _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_DanhMucManagementStore.canSubmit'))
          .value;
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
  Computed<bool> _$loadingUpdateActiveDanhMucComputed;

  @override
  bool get loadingUpdateActiveDanhMuc =>
      (_$loadingUpdateActiveDanhMucComputed ??= Computed<bool>(
              () => super.loadingUpdateActiveDanhMuc,
              name: '_DanhMucManagementStore.loadingUpdateActiveDanhMuc'))
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

  final _$fetchUpdateActiveDanhMucFutureAtom =
      Atom(name: '_DanhMucManagementStore.fetchUpdateActiveDanhMucFuture');

  @override
  ObservableFuture<dynamic> get fetchUpdateActiveDanhMucFuture {
    _$fetchUpdateActiveDanhMucFutureAtom.reportRead();
    return super.fetchUpdateActiveDanhMucFuture;
  }

  @override
  set fetchUpdateActiveDanhMucFuture(ObservableFuture<dynamic> value) {
    _$fetchUpdateActiveDanhMucFutureAtom
        .reportWrite(value, super.fetchUpdateActiveDanhMucFuture, () {
      super.fetchUpdateActiveDanhMucFuture = value;
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

  final _$danhMucListAllAtom =
      Atom(name: '_DanhMucManagementStore.danhMucListAll');

  @override
  DanhMucList get danhMucListAll {
    _$danhMucListAllAtom.reportRead();
    return super.danhMucListAll;
  }

  @override
  set danhMucListAll(DanhMucList value) {
    _$danhMucListAllAtom.reportWrite(value, super.danhMucListAll, () {
      super.danhMucListAll = value;
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

  final _$filterAtom = Atom(name: '_DanhMucManagementStore.filter');

  @override
  String get filter {
    _$filterAtom.reportRead();
    return super.filter;
  }

  @override
  set filter(String value) {
    _$filterAtom.reportWrite(value, super.filter, () {
      super.filter = value;
    });
  }

  final _$skipCountAtom = Atom(name: '_DanhMucManagementStore.skipCount');

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

  final _$skipIndexAtom = Atom(name: '_DanhMucManagementStore.skipIndex');

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

  final _$maxCountAtom = Atom(name: '_DanhMucManagementStore.maxCount');

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

  final _$updateActiveDanhMuc_successAtom =
      Atom(name: '_DanhMucManagementStore.updateActiveDanhMuc_success');

  @override
  bool get updateActiveDanhMuc_success {
    _$updateActiveDanhMuc_successAtom.reportRead();
    return super.updateActiveDanhMuc_success;
  }

  @override
  set updateActiveDanhMuc_success(bool value) {
    _$updateActiveDanhMuc_successAtom
        .reportWrite(value, super.updateActiveDanhMuc_success, () {
      super.updateActiveDanhMuc_success = value;
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

  final _$isIntialLoadingAtom =
      Atom(name: '_DanhMucManagementStore.isIntialLoading');

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

  final _$nameDanhMucListAtom =
      Atom(name: '_DanhMucManagementStore.nameDanhMucList');

  @override
  List<String> get nameDanhMucList {
    _$nameDanhMucListAtom.reportRead();
    return super.nameDanhMucList;
  }

  @override
  set nameDanhMucList(List<String> value) {
    _$nameDanhMucListAtom.reportWrite(value, super.nameDanhMucList, () {
      super.nameDanhMucList = value;
    });
  }

  final _$getAllDanhMucsAsyncAction =
      AsyncAction('_DanhMucManagementStore.getAllDanhMucs');

  @override
  Future<dynamic> getAllDanhMucs() {
    return _$getAllDanhMucsAsyncAction.run(() => super.getAllDanhMucs());
  }

  final _$getDanhMucsAsyncAction =
      AsyncAction('_DanhMucManagementStore.getDanhMucs');

  @override
  Future<dynamic> getDanhMucs(bool isLoadMore) {
    return _$getDanhMucsAsyncAction.run(() => super.getDanhMucs(isLoadMore));
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

  final _$IsActiveDanhMucAsyncAction =
      AsyncAction('_DanhMucManagementStore.IsActiveDanhMuc');

  @override
  Future<dynamic> IsActiveDanhMuc(DanhMuc danhMuc) {
    return _$IsActiveDanhMucAsyncAction
        .run(() => super.IsActiveDanhMuc(danhMuc));
  }

  final _$_DanhMucManagementStoreActionController =
      ActionController(name: '_DanhMucManagementStore');

  @override
  void setDanhMucId(int value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setDanhMucId');
    try {
      return super.setDanhMucId(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameDanhMuc(String value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setNameDanhMuc');
    try {
      return super.setNameDanhMuc(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTrangThaiDanhMuc(bool value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setTrangThaiDanhMuc');
    try {
      return super.setTrangThaiDanhMuc(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTagDanhMuc(String value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setTagDanhMuc');
    try {
      return super.setTagDanhMuc(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDanhMucCha(int value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setDanhMucCha');
    try {
      return super.setDanhMucCha(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setStringFilter(String value) {
    final _$actionInfo = _$_DanhMucManagementStoreActionController.startAction(
        name: '_DanhMucManagementStore.setStringFilter');
    try {
      return super.setStringFilter(value);
    } finally {
      _$_DanhMucManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchDanhMucsFuture: ${fetchDanhMucsFuture},
fetchCountAllDanhMucsFuture: ${fetchCountAllDanhMucsFuture},
fetchUpdateDanhMucFuture: ${fetchUpdateDanhMucFuture},
fetchCreateDanhMucFuture: ${fetchCreateDanhMucFuture},
fetchUpdateActiveDanhMucFuture: ${fetchUpdateActiveDanhMucFuture},
danhMucId: ${danhMucId},
tenDanhMuc: ${tenDanhMuc},
tag: ${tag},
danhMucCha: ${danhMucCha},
trangThai: ${trangThai},
danhMucList: ${danhMucList},
danhMucListAll: ${danhMucListAll},
countAllDanhMucs: ${countAllDanhMucs},
filter: ${filter},
skipCount: ${skipCount},
skipIndex: ${skipIndex},
maxCount: ${maxCount},
updateDanhMuc_success: ${updateDanhMuc_success},
updateActiveDanhMuc_success: ${updateActiveDanhMuc_success},
createDanhMuc_success: ${createDanhMuc_success},
isIntialLoading: ${isIntialLoading},
nameDanhMucList: ${nameDanhMucList},
canSubmit: ${canSubmit},
loading: ${loading},
loadingCountAllDanhMucs: ${loadingCountAllDanhMucs},
loadingUpdateDanhMuc: ${loadingUpdateDanhMuc},
loadingUpdateActiveDanhMuc: ${loadingUpdateActiveDanhMuc},
loadingCreateDanhMuc: ${loadingCreateDanhMuc}
    ''';
  }
}
