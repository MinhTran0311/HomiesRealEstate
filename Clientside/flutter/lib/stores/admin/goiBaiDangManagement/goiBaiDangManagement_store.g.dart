// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goiBaiDangManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$GoiBaiDangManagementStore on _GoiBaiDangManagementStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??= Computed<bool>(() => super.loading,
          name: '_GoiBaiDangManagementStore.loading'))
      .value;
  Computed<bool> _$loadingCountAllGoiBaiDangsComputed;

  @override
  bool get loadingCountAllGoiBaiDangs =>
      (_$loadingCountAllGoiBaiDangsComputed ??= Computed<bool>(
              () => super.loadingCountAllGoiBaiDangs,
              name: '_GoiBaiDangManagementStore.loadingCountAllGoiBaiDangs'))
          .value;

  final _$fetchGoiBaiDangsFutureAtom =
      Atom(name: '_GoiBaiDangManagementStore.fetchGoiBaiDangsFuture');

  @override
  ObservableFuture<GoiBaiDangList> get fetchGoiBaiDangsFuture {
    _$fetchGoiBaiDangsFutureAtom.reportRead();
    return super.fetchGoiBaiDangsFuture;
  }

  @override
  set fetchGoiBaiDangsFuture(ObservableFuture<GoiBaiDangList> value) {
    _$fetchGoiBaiDangsFutureAtom
        .reportWrite(value, super.fetchGoiBaiDangsFuture, () {
      super.fetchGoiBaiDangsFuture = value;
    });
  }

  final _$fetchCountAllGoiBaiDangsFutureAtom =
      Atom(name: '_GoiBaiDangManagementStore.fetchCountAllGoiBaiDangsFuture');

  @override
  ObservableFuture<dynamic> get fetchCountAllGoiBaiDangsFuture {
    _$fetchCountAllGoiBaiDangsFutureAtom.reportRead();
    return super.fetchCountAllGoiBaiDangsFuture;
  }

  @override
  set fetchCountAllGoiBaiDangsFuture(ObservableFuture<dynamic> value) {
    _$fetchCountAllGoiBaiDangsFutureAtom
        .reportWrite(value, super.fetchCountAllGoiBaiDangsFuture, () {
      super.fetchCountAllGoiBaiDangsFuture = value;
    });
  }

  final _$fetchUpdateGoiBaiDangFutureAtom =
      Atom(name: '_GoiBaiDangManagementStore.fetchUpdateGoiBaiDangFuture');

  @override
  ObservableFuture<dynamic> get fetchUpdateGoiBaiDangFuture {
    _$fetchUpdateGoiBaiDangFutureAtom.reportRead();
    return super.fetchUpdateGoiBaiDangFuture;
  }

  @override
  set fetchUpdateGoiBaiDangFuture(ObservableFuture<dynamic> value) {
    _$fetchUpdateGoiBaiDangFutureAtom
        .reportWrite(value, super.fetchUpdateGoiBaiDangFuture, () {
      super.fetchUpdateGoiBaiDangFuture = value;
    });
  }

  final _$fetchCreateGoiBaiDangFutureAtom =
      Atom(name: '_GoiBaiDangManagementStore.fetchCreateGoiBaiDangFuture');

  @override
  ObservableFuture<dynamic> get fetchCreateGoiBaiDangFuture {
    _$fetchCreateGoiBaiDangFutureAtom.reportRead();
    return super.fetchCreateGoiBaiDangFuture;
  }

  @override
  set fetchCreateGoiBaiDangFuture(ObservableFuture<dynamic> value) {
    _$fetchCreateGoiBaiDangFutureAtom
        .reportWrite(value, super.fetchCreateGoiBaiDangFuture, () {
      super.fetchCreateGoiBaiDangFuture = value;
    });
  }

  final _$goiBaiDangIDAtom =
      Atom(name: '_GoiBaiDangManagementStore.goiBaiDangID');

  @override
  int get goiBaiDangID {
    _$goiBaiDangIDAtom.reportRead();
    return super.goiBaiDangID;
  }

  @override
  set goiBaiDangID(int value) {
    _$goiBaiDangIDAtom.reportWrite(value, super.goiBaiDangID, () {
      super.goiBaiDangID = value;
    });
  }

  final _$tenGoiAtom = Atom(name: '_GoiBaiDangManagementStore.tenGoi');

  @override
  String get tenGoi {
    _$tenGoiAtom.reportRead();
    return super.tenGoi;
  }

  @override
  set tenGoi(String value) {
    _$tenGoiAtom.reportWrite(value, super.tenGoi, () {
      super.tenGoi = value;
    });
  }

  final _$phiAtom = Atom(name: '_GoiBaiDangManagementStore.phi');

  @override
  double get phi {
    _$phiAtom.reportRead();
    return super.phi;
  }

  @override
  set phi(double value) {
    _$phiAtom.reportWrite(value, super.phi, () {
      super.phi = value;
    });
  }

  final _$thoiGianToiThieuAtom =
      Atom(name: '_GoiBaiDangManagementStore.thoiGianToiThieu');

  @override
  int get thoiGianToiThieu {
    _$thoiGianToiThieuAtom.reportRead();
    return super.thoiGianToiThieu;
  }

  @override
  set thoiGianToiThieu(int value) {
    _$thoiGianToiThieuAtom.reportWrite(value, super.thoiGianToiThieu, () {
      super.thoiGianToiThieu = value;
    });
  }

  final _$doUuTienAtom = Atom(name: '_GoiBaiDangManagementStore.doUuTien');

  @override
  int get doUuTien {
    _$doUuTienAtom.reportRead();
    return super.doUuTien;
  }

  @override
  set doUuTien(int value) {
    _$doUuTienAtom.reportWrite(value, super.doUuTien, () {
      super.doUuTien = value;
    });
  }

  final _$moTaAtom = Atom(name: '_GoiBaiDangManagementStore.moTa');

  @override
  String get moTa {
    _$moTaAtom.reportRead();
    return super.moTa;
  }

  @override
  set moTa(String value) {
    _$moTaAtom.reportWrite(value, super.moTa, () {
      super.moTa = value;
    });
  }

  final _$trangThaiAtom = Atom(name: '_GoiBaiDangManagementStore.trangThai');

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

  final _$goiBaiDangListAtom =
      Atom(name: '_GoiBaiDangManagementStore.goiBaiDangList');

  @override
  GoiBaiDangList get goiBaiDangList {
    _$goiBaiDangListAtom.reportRead();
    return super.goiBaiDangList;
  }

  @override
  set goiBaiDangList(GoiBaiDangList value) {
    _$goiBaiDangListAtom.reportWrite(value, super.goiBaiDangList, () {
      super.goiBaiDangList = value;
    });
  }

  final _$updateGoiBaiDang_successAtom =
      Atom(name: '_GoiBaiDangManagementStore.updateGoiBaiDang_success');

  @override
  bool get updateGoiBaiDang_success {
    _$updateGoiBaiDang_successAtom.reportRead();
    return super.updateGoiBaiDang_success;
  }

  @override
  set updateGoiBaiDang_success(bool value) {
    _$updateGoiBaiDang_successAtom
        .reportWrite(value, super.updateGoiBaiDang_success, () {
      super.updateGoiBaiDang_success = value;
    });
  }

  final _$createGoiBaiDang_successAtom =
      Atom(name: '_GoiBaiDangManagementStore.createGoiBaiDang_success');

  @override
  bool get createGoiBaiDang_success {
    _$createGoiBaiDang_successAtom.reportRead();
    return super.createGoiBaiDang_success;
  }

  @override
  set createGoiBaiDang_success(bool value) {
    _$createGoiBaiDang_successAtom
        .reportWrite(value, super.createGoiBaiDang_success, () {
      super.createGoiBaiDang_success = value;
    });
  }

  final _$countAllGoiBaiDangsAtom =
      Atom(name: '_GoiBaiDangManagementStore.countAllGoiBaiDangs');

  @override
  int get countAllGoiBaiDangs {
    _$countAllGoiBaiDangsAtom.reportRead();
    return super.countAllGoiBaiDangs;
  }

  @override
  set countAllGoiBaiDangs(int value) {
    _$countAllGoiBaiDangsAtom.reportWrite(value, super.countAllGoiBaiDangs, () {
      super.countAllGoiBaiDangs = value;
    });
  }

  final _$skipCountAtom = Atom(name: '_GoiBaiDangManagementStore.skipCount');

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

  final _$skipIndexAtom = Atom(name: '_GoiBaiDangManagementStore.skipIndex');

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

  final _$maxCountAtom = Atom(name: '_GoiBaiDangManagementStore.maxCount');

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
      Atom(name: '_GoiBaiDangManagementStore.isIntialLoading');

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

  final _$getGoiBaiDangsAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.getGoiBaiDangs');

  @override
  Future<dynamic> getGoiBaiDangs(bool isLoadMore) {
    return _$getGoiBaiDangsAsyncAction
        .run(() => super.getGoiBaiDangs(isLoadMore));
  }

  final _$fCountAllGoiBaiDangsAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.fCountAllGoiBaiDangs');

  @override
  Future<dynamic> fCountAllGoiBaiDangs() {
    return _$fCountAllGoiBaiDangsAsyncAction
        .run(() => super.fCountAllGoiBaiDangs());
  }

  final _$UpdateGoiBaiDangAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.UpdateGoiBaiDang');

  @override
  Future<dynamic> UpdateGoiBaiDang() {
    return _$UpdateGoiBaiDangAsyncAction.run(() => super.UpdateGoiBaiDang());
  }

  final _$CreateGoiBaiDangAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.CreateGoiBaiDang');

  @override
  Future<dynamic> CreateGoiBaiDang() {
    return _$CreateGoiBaiDangAsyncAction.run(() => super.CreateGoiBaiDang());
  }

  @override
  String toString() {
    return '''
fetchGoiBaiDangsFuture: ${fetchGoiBaiDangsFuture},
fetchCountAllGoiBaiDangsFuture: ${fetchCountAllGoiBaiDangsFuture},
fetchUpdateGoiBaiDangFuture: ${fetchUpdateGoiBaiDangFuture},
fetchCreateGoiBaiDangFuture: ${fetchCreateGoiBaiDangFuture},
goiBaiDangID: ${goiBaiDangID},
tenGoi: ${tenGoi},
phi: ${phi},
thoiGianToiThieu: ${thoiGianToiThieu},
doUuTien: ${doUuTien},
moTa: ${moTa},
trangThai: ${trangThai},
goiBaiDangList: ${goiBaiDangList},
updateGoiBaiDang_success: ${updateGoiBaiDang_success},
createGoiBaiDang_success: ${createGoiBaiDang_success},
countAllGoiBaiDangs: ${countAllGoiBaiDangs},
skipCount: ${skipCount},
skipIndex: ${skipIndex},
maxCount: ${maxCount},
isIntialLoading: ${isIntialLoading},
loading: ${loading},
loadingCountAllGoiBaiDangs: ${loadingCountAllGoiBaiDangs}
    ''';
  }
}
