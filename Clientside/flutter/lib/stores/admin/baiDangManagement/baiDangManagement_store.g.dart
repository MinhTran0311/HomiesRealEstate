// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baiDangManagement_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BaiDangManagementStore on _BaiDangManagementStore, Store {
  Computed<bool> _$loadingCountNewBaiDangsInMonthComputed;

  @override
  bool get loadingCountNewBaiDangsInMonth =>
      (_$loadingCountNewBaiDangsInMonthComputed ??= Computed<bool>(
              () => super.loadingCountNewBaiDangsInMonth,
              name: '_BaiDangManagementStore.loadingCountNewBaiDangsInMonth'))
          .value;

  final _$fetchCountNewBaiDangsInMonthFutureAtom =
      Atom(name: '_BaiDangManagementStore.fetchCountNewBaiDangsInMonthFuture');

  @override
  ObservableFuture<dynamic> get fetchCountNewBaiDangsInMonthFuture {
    _$fetchCountNewBaiDangsInMonthFutureAtom.reportRead();
    return super.fetchCountNewBaiDangsInMonthFuture;
  }

  @override
  set fetchCountNewBaiDangsInMonthFuture(ObservableFuture<dynamic> value) {
    _$fetchCountNewBaiDangsInMonthFutureAtom
        .reportWrite(value, super.fetchCountNewBaiDangsInMonthFuture, () {
      super.fetchCountNewBaiDangsInMonthFuture = value;
    });
  }

  final _$countNewBaiDangsInMonthAtom =
      Atom(name: '_BaiDangManagementStore.countNewBaiDangsInMonth');

  @override
  int get countNewBaiDangsInMonth {
    _$countNewBaiDangsInMonthAtom.reportRead();
    return super.countNewBaiDangsInMonth;
  }

  @override
  set countNewBaiDangsInMonth(int value) {
    _$countNewBaiDangsInMonthAtom
        .reportWrite(value, super.countNewBaiDangsInMonth, () {
      super.countNewBaiDangsInMonth = value;
    });
  }

  final _$fCountNewBaiDangsInMonthAsyncAction =
      AsyncAction('_BaiDangManagementStore.fCountNewBaiDangsInMonth');

  @override
  Future<dynamic> fCountNewBaiDangsInMonth() {
    return _$fCountNewBaiDangsInMonthAsyncAction
        .run(() => super.fCountNewBaiDangsInMonth());
  }

  @override
  String toString() {
    return '''
fetchCountNewBaiDangsInMonthFuture: ${fetchCountNewBaiDangsInMonthFuture},
countNewBaiDangsInMonth: ${countNewBaiDangsInMonth},
loadingCountNewBaiDangsInMonth: ${loadingCountNewBaiDangsInMonth}
    ''';
  }
}
