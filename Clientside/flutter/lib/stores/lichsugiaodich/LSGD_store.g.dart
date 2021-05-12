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

  @override
  String toString() {
    return '''
fetchLSGDFuture: ${fetchLSGDFuture},
listlsgd: ${listlsgd},
success: ${success},
loading: ${loading}
    ''';
  }
}
