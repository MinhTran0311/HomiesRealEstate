// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LSGD_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LSGDStore on _LSGDStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_LSGDStore.loading'))
      .value;
  Computed<bool> _$AllloadingComputed;

  @override
  bool get Allloading => (_$AllloadingComputed ??=
          Computed<bool>(() => super.Allloading, name: '_LSGDStore.Allloading'))
      .value;

  final _$fetchLSGDFutureAtom = Atom(name: '_LSGDStore.fetchLSGDFuture');

  @override
  ObservableFuture<listLSGD> get fetchLSGDFuture {
    _$fetchLSGDFutureAtom.reportRead();
    return super.fetchLSGDFuture;
  }

  @override
  set fetchLSGDFuture(ObservableFuture<listLSGD> value) {
    _$fetchLSGDFutureAtom.reportWrite(value, super.fetchLSGDFuture, () {
      super.fetchLSGDFuture = value;
    });
  }

  final _$fetchAllLSGDFutureAtom = Atom(name: '_LSGDStore.fetchAllLSGDFuture');

  @override
  ObservableFuture<listLSGD> get fetchAllLSGDFuture {
    _$fetchAllLSGDFutureAtom.reportRead();
    return super.fetchAllLSGDFuture;
  }

  @override
  set fetchAllLSGDFuture(ObservableFuture<listLSGD> value) {
    _$fetchAllLSGDFutureAtom.reportWrite(value, super.fetchAllLSGDFuture, () {
      super.fetchAllLSGDFuture = value;
    });
  }

  final _$fetchNaptienFutureAtom = Atom(name: '_LSGDStore.fetchNaptienFuture');

  @override
  ObservableFuture<listLSGD> get fetchNaptienFuture {
    _$fetchNaptienFutureAtom.reportRead();
    return super.fetchNaptienFuture;
  }

  @override
  set fetchNaptienFuture(ObservableFuture<listLSGD> value) {
    _$fetchNaptienFutureAtom.reportWrite(value, super.fetchNaptienFuture, () {
      super.fetchNaptienFuture = value;
    });
  }

  final _$listlsgdAtom = Atom(name: '_LSGDStore.listlsgd');

  @override
  listLSGD get listlsgd {
    _$listlsgdAtom.reportRead();
    return super.listlsgd;
  }

  @override
  set listlsgd(listLSGD value) {
    _$listlsgdAtom.reportWrite(value, super.listlsgd, () {
      super.listlsgd = value;
    });
  }

  final _$listlsgdAllAtom = Atom(name: '_LSGDStore.listlsgdAll');

  @override
  listLSGD get listlsgdAll {
    _$listlsgdAllAtom.reportRead();
    return super.listlsgdAll;
  }

  @override
  set listlsgdAll(listLSGD value) {
    _$listlsgdAllAtom.reportWrite(value, super.listlsgdAll, () {
      super.listlsgdAll = value;
    });
  }

  final _$successAtom = Atom(name: '_LSGDStore.success');

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

  final _$getLSGDAsyncAction = AsyncAction('_LSGDStore.getLSGD');

  @override
  Future<dynamic> getLSGD() {
    return _$getLSGDAsyncAction.run(() => super.getLSGD());
  }

  final _$getAllLSGDAsyncAction = AsyncAction('_LSGDStore.getAllLSGD');

  @override
  Future<dynamic> getAllLSGD() {
    return _$getAllLSGDAsyncAction.run(() => super.getAllLSGD());
  }

  final _$NaptienAsyncAction = AsyncAction('_LSGDStore.Naptien');

  @override
  Future<dynamic> Naptien(String thoiDiem, double soTien, int userId) {
    return _$NaptienAsyncAction
        .run(() => super.Naptien(thoiDiem, soTien, userId));
  }

  @override
  String toString() {
    return '''
fetchLSGDFuture: ${fetchLSGDFuture},
fetchAllLSGDFuture: ${fetchAllLSGDFuture},
fetchNaptienFuture: ${fetchNaptienFuture},
listlsgd: ${listlsgd},
listlsgdAll: ${listlsgdAll},
success: ${success},
loading: ${loading},
Allloading: ${Allloading}
    ''';
  }
}
