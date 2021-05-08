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
  final _$fetchTownsFutureAtom = Atom(name: '_TownStore.fetchTownsFuture');

  @override
  ObservableFuture<TownList> get fetchTownsFuture {
    _$fetchTownsFutureAtom.reportRead();
    return super.fetchTownsFuture;
  }
  final _$townListAtom = Atom(name: '_TownStore.townList');

  @override
  TownList get townList {
    _$townListAtom.reportRead();
    return  super.townList;
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


  final _$getTownsAsyncAction = AsyncAction('_TownStore.getTowns');

  @override
  Future<dynamic> getTowns() {
    return _$getTownsAsyncAction.run(() => super.getTowns());
  }
  ///////////////////////////////commune
  @override
  Computed<bool> _$loadingComputedCommune;

  @override
  bool get loadingCommune => (_$loadingComputedCommune ??=
      Computed<bool>(() => super.loadingCommune, name: '_TownStore.loadingCommune'))
      .value;
  final _$fetchCommunesFutureAtom = Atom(name: '_CommuneStore.fetchCommunesFuture');

  @override
  ObservableFuture<CommuneList> get fetchCommunesFuture {
    _$fetchCommunesFutureAtom.reportRead();
    return super.fetchCommunesFuture;
  }
  final _$communeListAtom = Atom(name: '_CommuneStore.communeList');

  @override
  CommuneList get communeList {
    _$communeListAtom.reportRead();
    return  super.communeList;
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


  final _$getCommunesAsyncAction = AsyncAction('_TownStore.getCommunes');

  @override
  Future<dynamic> getCommunes() {
    return _$getCommunesAsyncAction.run(() => super.getCommunes());
  }
  @override
  String toString() {
    return '''
fetchTownsFuture: ${fetchTownsFuture},
fetchCommunesFuture: ${fetchCommunesFuture},
townList: ${townList},
success: ${success},
loading: ${loading},
communeList: ${communeList},
successCommune: ${success},
loadingCommune: ${loading},
    ''';
  }
}
