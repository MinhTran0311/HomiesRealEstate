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
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_FilterStore.loading'))
      .value;

  final _$fetchPostsFutureAtom = Atom(name: '_FilterStore.fetchPostsFuture');

  @override
  ObservableFuture<PostList> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<PostList> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

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
  void setTinhId(int value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setTinhId');
    try {
      return super.setTinhId(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setHuyenId(int value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setHuyenId');
    try {
      return super.setHuyenId(value);
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setXaId(int value) {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.setXaId');
    try {
      return super.setXaId(value);
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
  void validateSearchContent() {
    final _$actionInfo = _$_FilterStoreActionController.startAction(
        name: '_FilterStore.validateSearchContent');
    try {
      return super.validateSearchContent();
    } finally {
      _$_FilterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
filter_model: ${filter_model},
success: ${success},
giaDropDownValue: ${giaDropDownValue},
dienTichDropDownValue: ${dienTichDropDownValue},
seletedRange: ${seletedRange},
suDungGiaFilter: ${suDungGiaFilter},
suDungDienTichFilter: ${suDungDienTichFilter},
loading: ${loading}
    ''';
  }
}
