// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'town_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TownStore on _TownStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_TownStore.loading'))
      .value;
  Computed<bool> _$loadingCommuneComputed;

  @override
  bool get loadingCommune =>
      (_$loadingCommuneComputed ??= Computed<bool>(() => super.loadingCommune,
              name: '_TownStore.loadingCommune'))
          .value;

  final _$fetchTownsFutureAtom = Atom(name: '_TownStore.fetchTownsFuture');

  @override
  ObservableFuture<TownList> get fetchTownsFuture {
    _$fetchTownsFutureAtom.reportRead();
    return super.fetchTownsFuture;
  }

  @override
  set fetchTownsFuture(ObservableFuture<TownList> value) {
    _$fetchTownsFutureAtom.reportWrite(value, super.fetchTownsFuture, () {
      super.fetchTownsFuture = value;
    });
  }

  final _$townListAtom = Atom(name: '_TownStore.townList');

  @override
  TownList get townList {
    _$townListAtom.reportRead();
    return super.townList;
  }

  @override
  set townList(TownList value) {
    _$townListAtom.reportWrite(value, super.townList, () {
      super.townList = value;
    });
  }

  final _$successAtom = Atom(name: '_TownStore.success');

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

  final _$fetchCommunesFutureAtom =
      Atom(name: '_TownStore.fetchCommunesFuture');

  @override
  ObservableFuture<CommuneList> get fetchCommunesFuture {
    _$fetchCommunesFutureAtom.reportRead();
    return super.fetchCommunesFuture;
  }

  @override
  set fetchCommunesFuture(ObservableFuture<CommuneList> value) {
    _$fetchCommunesFutureAtom.reportWrite(value, super.fetchCommunesFuture, () {
      super.fetchCommunesFuture = value;
    });
  }

  final _$communeListAtom = Atom(name: '_TownStore.communeList');

  @override
  CommuneList get communeList {
    _$communeListAtom.reportRead();
    return super.communeList;
  }

  @override
  set communeList(CommuneList value) {
    _$communeListAtom.reportWrite(value, super.communeList, () {
      super.communeList = value;
    });
  }

  final _$successCommuneAtom = Atom(name: '_TownStore.successCommune');

  @override
  bool get successCommune {
    _$successCommuneAtom.reportRead();
    return super.successCommune;
  }

  @override
  set successCommune(bool value) {
    _$successCommuneAtom.reportWrite(value, super.successCommune, () {
      super.successCommune = value;
    });
  }

  final _$getTownsAsyncAction = AsyncAction('_TownStore.getTowns');

  @override
  Future<dynamic> getTowns() {
    return _$getTownsAsyncAction.run(() => super.getTowns());
  }

  final _$getCommunesAsyncAction = AsyncAction('_TownStore.getCommunes');

  @override
  Future<dynamic> getCommunes() {
    return _$getCommunesAsyncAction.run(() => super.getCommunes());
  }

  @override
  String toString() {
    return '''
fetchTownsFuture: ${fetchTownsFuture},
townList: ${townList},
success: ${success},
fetchCommunesFuture: ${fetchCommunesFuture},
communeList: ${communeList},
successCommune: ${successCommune},
loading: ${loading},
loadingCommune: ${loadingCommune}
    ''';
  }
}
