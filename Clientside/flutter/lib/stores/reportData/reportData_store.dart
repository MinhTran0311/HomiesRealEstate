
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/report/ListReport.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'reportData_store.g.dart';

class ReportDataStore = _ReportDataStore with _$ReportDataStore;

abstract class _ReportDataStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _ReportDataStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<listitemReport> emptyReportDataResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<listitemReport> fetchReportDataFuture =
  ObservableFuture<listitemReport>(emptyReportDataResponse);

  @observable
  listitemReport listitemReports;

  @computed
  bool get loading => fetchReportDataFuture.status == FutureStatus.pending;

  @observable
  bool success = false;


  // actions:-------------------------------------------------------------------
  @action
  Future getReportData() async {
    final future = _repository.getReportData();
    fetchReportDataFuture = ObservableFuture(future);

    fetchReportDataFuture.then((listitemReports) {
      this.listitemReports = listitemReports;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }
}