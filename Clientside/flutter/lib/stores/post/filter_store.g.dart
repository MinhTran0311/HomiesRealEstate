// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filter_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$FilterStore on _FilterStore, Store {
  Computed<bool> _$suDungGiaFilterComputed;

  @override
  bool get suDungGiaFilter =>
      (_$suDungGiaFilterComputed ??= Computed<bool>(() => super.suDungGiaFilter,
              name: '_FilterStore.suDungGiaFilter'))
          .value;
  Computed<bool> _$suDungDienTichFilterComputed;

  @override
  bool get suDungDienTichFilter => (_$suDungDienTichFilterComputed ??=
          Computed<bool>(() => super.suDungDienTichFilter,
              name: '_FilterStore.suDungDienTichFilter'))
      .value;
  Computed<bool> _$loadingProvinceComputed;

  @override
  bool get loadingProvince =>
      (_$loadingProvinceComputed ??= Computed<bool>(() => super.loadingProvince,
              name: '_FilterStore.loadingProvince'))
          .value;
  Computed<bool> _$loadingTownComputed;

  @override
  bool get loadingTown =>
      (_$loadingTownComputed ??= Computed<bool>(() => super.loadingTown,
              name: '_FilterStore.loadingTown'))
          .value;
  Computed<bool> _$loadingCommuneComputed;

  @override
  bool get loadingCommune =>
      (_$loadingCommuneComputed ??= Computed<bool>(() => super.loadingCommune,
              name: '_FilterStore.loadingCommune'))
          .value;

  final _$filter_modelAtom = Atom(name: '_FilterStore.filter_model');

  @override
  filter_Model get filter_model {
    _$filter_modelAtom.reportRead();
    return super.filter_model;
  }

  @override
  set filter_model(filter_Model value) {
    _$filter_modelAtom.reportWrite(value, super.filter_model, () {
      super.filter_model = value;
    });
  }

  final _$successAtom = Atom(name: '_FilterStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$giaDropDownValueAtom = Atom(name: '_FilterStore.giaDropDownValue');

  @override
  String get giaDropDownValue {
    _$giaDropDownValueAtom.reportRead();
    return super.giaDropDownValue;
  }

  @override
  set giaDropDownValue(String value) {
    _$giaDropDownValueAtom.reportWrite(value, super.giaDropDownValue, () {
      super.giaDropDownValue = value;
    });
  }

  final _$dienTichDropDownValueAtom =
      Atom(name: '_FilterStore.dienTichDropDownValue');

  @override
  String get dienTichDropDownValue {
    _$dienTichDropDownValueAtom.reportRead();
    return super.dienTichDropDownValue;
  }

  @override
  set dienTichDropDownValue(String value) {
    _$dienTichDropDownValueAtom.reportWrite(value, super.dienTichDropDownValue,
        () {
      super.dienTichDropDownValue = value;
    });
  }

  final _$loaiBaiDangDropDownValueAtom =
      Atom(name: '_FilterStore.loaiBaiDangDropDownValue');

  @override
  String get loaiBaiDangDropDownValue {
    _$loaiBaiDangDropDownValueAtom.reportRead();
    return super.loaiBaiDangDropDownValue;
  }

  @override
  set loaiBaiDangDropDownValue(String value) {
    _$loaiBaiDangDropDownValueAtom
        .reportWrite(value, super.loaiBaiDangDropDownValue, () {
      super.loaiBaiDangDropDownValue = value;
    });
  }

  final _$seletedRangeAtom = Atom(name: '_FilterStore.seletedRange');

  @override
  RangeValues get seletedRange {
    _$seletedRangeAtom.reportRead();
    return super.seletedRange;
  }

  @override
  set seletedRange(RangeValues value) {
    _$seletedRangeAtom.reportWrite(value, super.seletedRange, () {
      super.seletedRange = value;
    });
  }

  final _$provinceListStringAtom =
      Atom(name: '_FilterStore.provinceListString');

  @override
  List<String> get provinceListString {
    _$provinceListStringAtom.reportRead();
    return super.provinceListString;
  }

  @override
  set provinceListString(List<String> value) {
    _$provinceListStringAtom.reportWrite(value, super.provinceListString, () {
      super.provinceListString = value;
    });
  }

  final _$fetchProvinceFutureAtom =
      Atom(name: '_FilterStore.fetchProvinceFuture');

  @override
  ObservableFuture<ProvinceList> get fetchProvinceFuture {
    _$fetchProvinceFutureAtom.reportRead();
    return super.fetchProvinceFuture;
  }

  @override
  set fetchProvinceFuture(ObservableFuture<ProvinceList> value) {
    _$fetchProvinceFutureAtom.reportWrite(value, super.fetchProvinceFuture, () {
      super.fetchProvinceFuture = value;
    });
  }

  final _$townListStringAtom = Atom(name: '_FilterStore.townListString');

  @override
  List<String> get townListString {
    _$townListStringAtom.reportRead();
    return super.townListString;
  }

  @override
  set townListString(List<String> value) {
    _$townListStringAtom.reportWrite(value, super.townListString, () {
      super.townListString = value;
    });
  }

  final _$fetchTownFutureAtom = Atom(name: '_FilterStore.fetchTownFuture');

  @override
  ObservableFuture<TownList> get fetchTownFuture {
    _$fetchTownFutureAtom.reportRead();
    return super.fetchTownFuture;
  }

  @override
  set fetchTownFuture(ObservableFuture<TownList> value) {
    _$fetchTownFutureAtom.reportWrite(value, super.fetchTownFuture, () {
      super.fetchTownFuture = value;
    });
  }

  final _$communeListStringAtom = Atom(name: '_FilterStore.communeListString');

  @override
  List<String> get communeListString {
    _$communeListStringAtom.reportRead();
    return super.communeListString;
  }

  @override
  set communeListString(List<String> value) {
    _$communeListStringAtom.reportWrite(value, super.communeListString, () {
      super.communeListString = value;
    });
  }

  final _$fetchCommuneFutureAtom =
      Atom(name: '_FilterStore.fetchCommuneFuture');

  @override
  ObservableFuture<CommuneList> get fetchCommuneFuture {
    _$fetchCommuneFutureAtom.reportRead();
    return super.fetchCommuneFuture;
  }

  @override
  set fetchCommuneFuture(ObservableFuture<CommuneList> value) {
    _$fetchCommuneFutureAtom.reportWrite(value, super.fetchCommuneFuture, () {
      super.fetchCommuneFuture = value;
    });
  }

  final _$getAllProvinceAsyncAction =
      AsyncAction('_FilterStore.getAllProvince');

  @override
  Future<dynamic> getAllProvince() {
    return _$getAllProvinceAsyncAction.run(() => super.getAllProvince());
  }

  final _$getTownByProvinceNameAsyncAction =
      AsyncAction('_FilterStore.getTownByProvinceName');

  @override
  Future<dynamic> getTownByProvinceName(String provinceName) {
    return _$getTownByProvinceNameAsyncAction
        .run(() => super.getTownByProvinceName(provinceName));
  }

  final _$getCommuneByTownNameAsyncAction =
      AsyncAction('_FilterStore.getCommuneByTownName');

  @override
  Future<dynamic> getCommuneByTownName(String TownName) {
    return _$getCommuneByTownNameAsyncAction
        .run(() => super.getCommuneByTownName(TownName));
  }

  final _$_FilterStoreActionController = ActionController(name: '_FilterStore');

  @override
  void setDiaChiContent(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setDiaChiContent');
    try {
      return super.setDiaChiContent(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTag(String value) {
    final _$actionInfo =
        _$_FilterStoreActionController.startAction(name: '_FilterStore.setTag');
    try {
      return super.setTag(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsernameContent(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setUsernameContent');
    try {
      return super.setUsernameContent(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGiaMin(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setGiaMin');
    try {
      return super.setGiaMin(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGiaMax(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setGiaMax');
    try {
      return super.setGiaMax(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDienTichMin(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setDienTichMin');
    try {
      return super.setDienTichMin(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setDienTichMax(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setDienTichMax');
    try {
      return super.setDienTichMax(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTinhId(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setTinhId');
    try {
      return super.setTinhId(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHuyenId(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setHuyenId');
    try {
      return super.setHuyenId(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setXaId(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setXaId');
    try {
      return super.setXaId(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTenTinh(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setTenTinh');
    try {
      return super.setTenTinh(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTenHuyen(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setTenHuyen');
    try {
      return super.setTenHuyen(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTenXa(String value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setTenXa');
    try {
      return super.setTenXa(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String calculateActualValue(String value, String option) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.calculateActualValue');
    try {
      return super.calculateActualValue(value, option);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  filter_Model validateSearchContent() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.validateSearchContent');
    try {
      return super.validateSearchContent();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetValue() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.resetValue');
    try {
      return super.resetValue();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
filter_model: ${filter_model},
success: ${success},
giaDropDownValue: ${giaDropDownValue},
dienTichDropDownValue: ${dienTichDropDownValue},
loaiBaiDangDropDownValue: ${loaiBaiDangDropDownValue},
seletedRange: ${seletedRange},
provinceListString: ${provinceListString},
fetchProvinceFuture: ${fetchProvinceFuture},
townListString: ${townListString},
fetchTownFuture: ${fetchTownFuture},
communeListString: ${communeListString},
fetchCommuneFuture: ${fetchCommuneFuture},
suDungGiaFilter: ${suDungGiaFilter},
suDungDienTichFilter: ${suDungDienTichFilter},
loadingProvince: ${loadingProvince},
loadingTown: ${loadingTown},
loadingCommune: ${loadingCommune}
    ''';
  }
}
