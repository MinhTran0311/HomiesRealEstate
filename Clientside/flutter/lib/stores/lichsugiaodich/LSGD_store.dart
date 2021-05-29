import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'LSGD_store.g.dart';

class LSGDStore = _LSGDStore with _$LSGDStore;

abstract class _LSGDStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _LSGDStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<listLSGD> emptyLSGDResponse =
  ObservableFuture.value(null);
  static ObservableFuture<listLSGD> emptyAllLSGDResponse =
  ObservableFuture.value(null);
  static ObservableFuture<bool> emptyNaptienResponse =
  ObservableFuture.value(null);
  static ObservableFuture<bool> emptyKiemDuyetGiaoDichResponse =
  ObservableFuture.value(null);
  static ObservableFuture<listLSGD> emptyKiemDuyetNapTienResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<listLSGD> fetchLSGDFuture =
  ObservableFuture<listLSGD>(emptyLSGDResponse);
  @observable
  ObservableFuture<listLSGD> fetchAllLSGDFuture =
  ObservableFuture<listLSGD>(emptyAllLSGDResponse);
  @observable
  ObservableFuture<bool> fetchNaptienFuture =
  ObservableFuture<bool>(emptyNaptienResponse);
  @observable
  ObservableFuture<bool> fetchKiemDuyetGiaoDichFuture =
  ObservableFuture<bool>(emptyKiemDuyetGiaoDichResponse);
  @observable
  ObservableFuture<listLSGD> fetchKiemDuyetNapTienFuture =
  ObservableFuture<listLSGD>(emptyKiemDuyetNapTienResponse);
  @observable
  int skipCount = 0;
  @observable
  filter_Model filter_model = new filter_Model();
  @observable
  listLSGD listlsgd;
  @observable
  listLSGD listlsgdAll;

  @observable
  bool success = false;

  @observable
  bool isIntialLoading = true;
  @computed
  bool get loading => fetchLSGDFuture.status == FutureStatus.pending && isIntialLoading;
  @computed
  bool get Allloading => fetchAllLSGDFuture.status == FutureStatus.pending;
  @computed
  bool get loadingNapTien => fetchNaptienFuture.status == FutureStatus.pending;
  @computed
  bool get loadingKiemDuyetGiaoDich => fetchKiemDuyetGiaoDichFuture.status == FutureStatus.pending;
  @computed
  bool get loadingKiemDuyetNapTien => fetchKiemDuyetNapTienFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getLSGD(bool isLoadMore) async {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += Preferences.skipIndex;
    final future = _repository.getLSGD(skipCount, Preferences.maxCount, filter_model);
    fetchLSGDFuture = ObservableFuture(future);

    future.then((listLSGD) {
      success = true;
      if (!isLoadMore){
        this.listlsgd = listLSGD;
        if (isIntialLoading) isIntialLoading=false;
      }
      else {
        for (int i=0; i< listLSGD.listLSGDs.length; i++)
          this.listlsgd.listLSGDs.add(listLSGD.listLSGDs[i]);
      }
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }

  // actions:-------------------------------------------------------------------
  @action
  Future getAllLSGD() async {
    final future = _repository.getAllLSGD();
    fetchAllLSGDFuture = ObservableFuture(future);

    future.then((listlsgdAll) {
      this.listlsgdAll = listlsgdAll;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }

  // actions:-------------------------------------------------------------------
  @action
  Future Naptien(String thoiDiem,double soTien,int userId) async {
    final future = _repository.NapTien(soTien, thoiDiem, userId);
    fetchNaptienFuture = ObservableFuture(future);

    future.then((listLSGD) {
      // this.listlsgd = listLSGD;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }

  // actions:-------------------------------------------------------------------
  // @action
  // Future KiemDuyetNaptien(int userId, String idLSGD,int kiemDuyetVienID) async {
  //   final future = _repository.KiemDuyetNapTien(userId, idLSGD, kiemDuyetVienID);
  //   fetchKiemDuyetNapTienFuture = ObservableFuture(future);
  //
  //   future.then((listLSGD) {
  //     // this.listlsgd = listLSGD;
  //   }).catchError((error) {
  //     if (error is DioError) {
  //       errorStore.errorMessage = DioErrorUtil.handleError(error);
  //       throw error;
  //     }
  //     else{
  //       errorStore.errorMessage="Please check your internet connection and try again!";
  //       throw error;
  //     }
  //     //errorStore.errorMessage = DioErrorUtil.handleError(error);
  //     //throw error;
  //   });
  // }
  // actions:-------------------------------------------------------------------
  @action
  Future KiemDuyetGiaoDich(String idLSGD) async {
    final future = _repository.KiemDuyetGiaoDich(idLSGD);
    fetchKiemDuyetGiaoDichFuture = ObservableFuture(future);

    future.then((listLSGD) {
      // this.listlsgd = listLSGD;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }
}