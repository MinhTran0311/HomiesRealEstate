// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reportData_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportDataStore on _ReportDataStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
      Computed<bool>(() => super.loading, name: '_ReportDataStore.loading'))
      .value;


  final _$fetchReportDataFutureAtom = Atom(name: '_ReportDataStore.fetchReportDataFuture');

  @override
  ObservableFuture<listitemReport> get fetchReportDataFuture {
    _$fetchReportDataFutureAtom.reportRead();
    return super.fetchReportDataFuture;
  }

  @override
  set fetchReportDataFuture(ObservableFuture<listitemReport> value) {
    _$fetchReportDataFutureAtom.reportWrite(value, super.fetchReportDataFuture, () {
      super.fetchReportDataFuture = value;
    });
  }

  final _$listitemReportsAtom = Atom(name: '_ReportDataStore.listitemReports');

  @override
  listitemReport get listitemReports {
    _$listitemReportsAtom.reportRead();
    return super.listitemReports;
  }

  @override
  set listitemReports(listitemReport value) {
    _$listitemReportsAtom.reportWrite(value, super.listitemReports, () {
      super.listitemReports = value;
    });
  }

  final _$successAtom = Atom(name: '_ReportDataStore.success');

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

  final _$getReportDataAsyncAction = AsyncAction('_ReportDataStore.getReportData');

  @override
  Future<dynamic> getReportData() {
    return _$getReportDataAsyncAction.run(() => super.getReportData());
  }

  @override
  String toString() {
    return '''
fetchReportDataFuture: ${fetchReportDataFuture},
listitemReports: ${listitemReports},
success: ${success},
loading: ${loading},
    ''';
  }
}
