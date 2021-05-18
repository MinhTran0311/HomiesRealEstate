// import 'package:boilerplate/data/repository.dart';
// import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
// import 'package:boilerplate/models/post/post_list.dart';
// import 'package:boilerplate/stores/error/error_store.dart';
// import 'package:boilerplate/utils/dio/dio_error_util.dart';
// import 'package:dio/dio.dart';
// import 'package:mobx/mobx.dart';
//
// part 'LSGD_store.g.dart';
//
// class LSGDStore = _LSGDStore with _$LSGDStore;
//
// abstract class _LSGDStore with Store {
//   // repository instance
//   Repository _repository;
//
//   // store for handling errors
//   final ErrorStore errorStore = ErrorStore();
//
//   // constructor:---------------------------------------------------------------
//   _LSGDStore(Repository repository) : this._repository = repository;
//
//   // store variables:-----------------------------------------------------------
//   static ObservableFuture<listLSGD> emptyLSGDResponse =
//   ObservableFuture.value(null);
//
//   @observable
//   ObservableFuture<listLSGD> fetchLSGDFuture =
//   ObservableFuture<listLSGD>(emptyLSGDResponse);
//
//   @observable
//   listLSGD listlsgd;
//
//   @observable
//   bool success = false;
//
//   @computed
//   bool get loading => fetchLSGDFuture.status == FutureStatus.pending;
//
//   // actions:-------------------------------------------------------------------
//   @action
//   Future getLSGD() async {
//     final future = _repository.getLSGD();
//     fetchLSGDFuture = ObservableFuture(future);
//
//     future.then((listLSGD) {
//       this.listlsgd = listLSGD;
//     }).catchError((error) {
//       if (error is DioError) {
//         errorStore.errorMessage = DioErrorUtil.handleError(error);
//         throw error;
//       }
//       else{
//         errorStore.errorMessage="Please check your internet connection and try again!";
//         throw error;
//       }
//       //errorStore.errorMessage = DioErrorUtil.handleError(error);
//       //throw error;
//     });
//   }
// }