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

  final _$getGoiBaiDangsAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.getGoiBaiDangs');

  @override
  Future<dynamic> getGoiBaiDangs() {
    return _$getGoiBaiDangsAsyncAction.run(() => super.getGoiBaiDangs());
  }

  final _$fCountAllGoiBaiDangsAsyncAction =
      AsyncAction('_GoiBaiDangManagementStore.fCountAllGoiBaiDangs');

  @override
  Future<dynamic> fCountAllGoiBaiDangs() {
    return _$fCountAllGoiBaiDangsAsyncAction
        .run(() => super.fCountAllGoiBaiDangs());
  }

  @override
  String toString() {
    return '''
fetchGoiBaiDangsFuture: ${fetchGoiBaiDangsFuture},
fetchCountAllGoiBaiDangsFuture: ${fetchCountAllGoiBaiDangsFuture},
goiBaiDangList: ${goiBaiDangList},
countAllGoiBaiDangs: ${countAllGoiBaiDangs},
loading: ${loading},
loadingCountAllGoiBaiDangs: ${loadingCountAllGoiBaiDangs}
    ''';
  }
}
