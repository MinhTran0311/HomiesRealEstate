// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'thuocTinhManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ThuocTinhManagementStore on _ThuocTinhManagementStore, Store {
  Computed<bool> _$canSubmitComputed;

  @override
  bool get canSubmit =>
      (_$canSubmitComputed ??= Computed<bool>(() => super.canSubmit,
              name: '_ThuocTinhManagementStore.canSubmit'))
          .value;
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
  Computed<bool> _$loadingUpdateThuocTinhComputed;

  @override
  bool get loadingUpdateThuocTinh => (_$loadingUpdateThuocTinhComputed ??=
          Computed<bool>(() => super.loadingUpdateThuocTinh,
              name: '_ThuocTinhManagementStore.loadingUpdateThuocTinh'))
      .value;
  Computed<bool> _$loadingCreateThuocTinhComputed;

  @override
  bool get loadingCreateThuocTinh => (_$loadingCreateThuocTinhComputed ??=
          Computed<bool>(() => super.loadingCreateThuocTinh,
              name: '_ThuocTinhManagementStore.loadingCreateThuocTinh'))
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

  final _$fetchUpdateThuocTinhFutureAtom =
      Atom(name: '_ThuocTinhManagementStore.fetchUpdateThuocTinhFuture');

  @override
  ObservableFuture<dynamic> get fetchUpdateThuocTinhFuture {
    _$fetchUpdateThuocTinhFutureAtom.reportRead();
    return super.fetchUpdateThuocTinhFuture;
  }

  @override
  set fetchUpdateThuocTinhFuture(ObservableFuture<dynamic> value) {
    _$fetchUpdateThuocTinhFutureAtom
        .reportWrite(value, super.fetchUpdateThuocTinhFuture, () {
      super.fetchUpdateThuocTinhFuture = value;
    });
  }

  final _$fetchCreateThuocTinhFutureAtom =
      Atom(name: '_ThuocTinhManagementStore.fetchCreateThuocTinhFuture');

  @override
  ObservableFuture<dynamic> get fetchCreateThuocTinhFuture {
    _$fetchCreateThuocTinhFutureAtom.reportRead();
    return super.fetchCreateThuocTinhFuture;
  }

  @override
  set fetchCreateThuocTinhFuture(ObservableFuture<dynamic> value) {
    _$fetchCreateThuocTinhFutureAtom
        .reportWrite(value, super.fetchCreateThuocTinhFuture, () {
      super.fetchCreateThuocTinhFuture = value;
    });
  }

  final _$nameAtom = Atom(name: '_ThuocTinhManagementStore.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$idThuocTinhAtom = Atom(name: '_ThuocTinhManagementStore.idThuocTinh');

  @override
  int get idThuocTinh {
    _$idThuocTinhAtom.reportRead();
    return super.idThuocTinh;
  }

  @override
  set idThuocTinh(int value) {
    _$idThuocTinhAtom.reportWrite(value, super.idThuocTinh, () {
      super.idThuocTinh = value;
    });
  }

  final _$activeAtom = Atom(name: '_ThuocTinhManagementStore.active');

  @override
  String get active {
    _$activeAtom.reportRead();
    return super.active;
  }

  @override
  set active(String value) {
    _$activeAtom.reportWrite(value, super.active, () {
      super.active = value;
    });
  }

  final _$KieuDuLieuShowAtom =
      Atom(name: '_ThuocTinhManagementStore.KieuDuLieuShow');

  @override
  String get KieuDuLieuShow {
    _$KieuDuLieuShowAtom.reportRead();
    return super.KieuDuLieuShow;
  }

  @override
  set KieuDuLieuShow(String value) {
    _$KieuDuLieuShowAtom.reportWrite(value, super.KieuDuLieuShow, () {
      super.KieuDuLieuShow = value;
    });
  }

  final _$KieuDuLieuAtom = Atom(name: '_ThuocTinhManagementStore.KieuDuLieu');

  @override
  String get KieuDuLieu {
    _$KieuDuLieuAtom.reportRead();
    return super.KieuDuLieu;
  }

  @override
  set KieuDuLieu(String value) {
    _$KieuDuLieuAtom.reportWrite(value, super.KieuDuLieu, () {
      super.KieuDuLieu = value;
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

  final _$updateThuocTinh_successAtom =
      Atom(name: '_ThuocTinhManagementStore.updateThuocTinh_success');

  @override
  bool get updateThuocTinh_success {
    _$updateThuocTinh_successAtom.reportRead();
    return super.updateThuocTinh_success;
  }

  @override
  set updateThuocTinh_success(bool value) {
    _$updateThuocTinh_successAtom
        .reportWrite(value, super.updateThuocTinh_success, () {
      super.updateThuocTinh_success = value;
    });
  }

  final _$createThuocTinh_successAtom =
      Atom(name: '_ThuocTinhManagementStore.createThuocTinh_success');

  @override
  bool get createThuocTinh_success {
    _$createThuocTinh_successAtom.reportRead();
    return super.createThuocTinh_success;
  }

  @override
  set createThuocTinh_success(bool value) {
    _$createThuocTinh_successAtom
        .reportWrite(value, super.createThuocTinh_success, () {
      super.createThuocTinh_success = value;
    });
  }

  final _$isIntialLoadingAtom =
      Atom(name: '_ThuocTinhManagementStore.isIntialLoading');

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

  final _$skipCountAtom = Atom(name: '_ThuocTinhManagementStore.skipCount');

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

  final _$skipIndexAtom = Atom(name: '_ThuocTinhManagementStore.skipIndex');

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

  final _$maxCountAtom = Atom(name: '_ThuocTinhManagementStore.maxCount');

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

  final _$getThuocTinhsAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.getThuocTinhs');

  @override
  Future<dynamic> getThuocTinhs(bool isLoadMore) {
    return _$getThuocTinhsAsyncAction
        .run(() => super.getThuocTinhs(isLoadMore));
  }

  final _$fCountAllThuocTinhsAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.fCountAllThuocTinhs');

  @override
  Future<dynamic> fCountAllThuocTinhs() {
    return _$fCountAllThuocTinhsAsyncAction
        .run(() => super.fCountAllThuocTinhs());
  }

  final _$UpdateThuocTinhAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.UpdateThuocTinh');

  @override
  Future<dynamic> UpdateThuocTinh() {
    return _$UpdateThuocTinhAsyncAction.run(() => super.UpdateThuocTinh());
  }

  final _$CreateThuocTinhAsyncAction =
      AsyncAction('_ThuocTinhManagementStore.CreateThuocTinh');

  @override
  Future<dynamic> CreateThuocTinh() {
    return _$CreateThuocTinhAsyncAction.run(() => super.CreateThuocTinh());
  }

  final _$_ThuocTinhManagementStoreActionController =
      ActionController(name: '_ThuocTinhManagementStore');

  @override
  void setThuocTinhId(int value) {
    final _$actionInfo = _$_ThuocTinhManagementStoreActionController
        .startAction(name: '_ThuocTinhManagementStore.setThuocTinhId');
    try {
      return super.setThuocTinhId(value);
    } finally {
      _$_ThuocTinhManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNameThuocTinh(String value) {
    final _$actionInfo = _$_ThuocTinhManagementStoreActionController
        .startAction(name: '_ThuocTinhManagementStore.setNameThuocTinh');
    try {
      return super.setNameThuocTinh(value);
    } finally {
      _$_ThuocTinhManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTrangThaiThuocTinh(bool value) {
    final _$actionInfo = _$_ThuocTinhManagementStoreActionController
        .startAction(name: '_ThuocTinhManagementStore.setTrangThaiThuocTinh');
    try {
      return super.setTrangThaiThuocTinh(value);
    } finally {
      _$_ThuocTinhManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void getKieuDuLieu(String value) {
    final _$actionInfo = _$_ThuocTinhManagementStoreActionController
        .startAction(name: '_ThuocTinhManagementStore.getKieuDuLieu');
    try {
      return super.getKieuDuLieu(value);
    } finally {
      _$_ThuocTinhManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setKieuDuLieu(String value) {
    final _$actionInfo = _$_ThuocTinhManagementStoreActionController
        .startAction(name: '_ThuocTinhManagementStore.setKieuDuLieu');
    try {
      return super.setKieuDuLieu(value);
    } finally {
      _$_ThuocTinhManagementStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchThuocTinhsFuture: ${fetchThuocTinhsFuture},
fetchCountAllThuocTinhsFuture: ${fetchCountAllThuocTinhsFuture},
fetchUpdateThuocTinhFuture: ${fetchUpdateThuocTinhFuture},
fetchCreateThuocTinhFuture: ${fetchCreateThuocTinhFuture},
name: ${name},
idThuocTinh: ${idThuocTinh},
active: ${active},
KieuDuLieuShow: ${KieuDuLieuShow},
KieuDuLieu: ${KieuDuLieu},
thuocTinhList: ${thuocTinhList},
countAllThuocTinhs: ${countAllThuocTinhs},
updateThuocTinh_success: ${updateThuocTinh_success},
createThuocTinh_success: ${createThuocTinh_success},
isIntialLoading: ${isIntialLoading},
skipCount: ${skipCount},
skipIndex: ${skipIndex},
maxCount: ${maxCount},
canSubmit: ${canSubmit},
loading: ${loading},
loadingCountAllThuocTinhs: ${loadingCountAllThuocTinhs},
loadingUpdateThuocTinh: ${loadingUpdateThuocTinh},
loadingCreateThuocTinh: ${loadingCreateThuocTinh}
    ''';
  }
}
