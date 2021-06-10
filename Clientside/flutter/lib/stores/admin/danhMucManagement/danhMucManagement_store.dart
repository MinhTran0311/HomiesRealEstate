import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/danhMuc/danhMuc.dart';
import 'package:boilerplate/models/danhMuc/danhMuc_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'danhMucManagement_store.g.dart';

class DanhMucManagementStore = _DanhMucManagementStore with _$DanhMucManagementStore;

abstract class _DanhMucManagementStore with Store {
  Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _DanhMucManagementStore(Repository repository) : this._repository = repository;

  static ObservableFuture<DanhMucList> emptyDanhMucResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<DanhMucList> fetchDanhMucsFuture =
  ObservableFuture<DanhMucList>(emptyDanhMucResponse);

  static ObservableFuture<dynamic> emptyCountAllDanhMucsResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountAllDanhMucsFuture =
  ObservableFuture<dynamic>(emptyCountAllDanhMucsResponse);

  static ObservableFuture<dynamic> emptyUpdateDanhMucResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateDanhMucFuture =
  ObservableFuture<dynamic>(emptyUpdateDanhMucResponse);

  static ObservableFuture<dynamic> emptyCreateDanhMucResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCreateDanhMucFuture =
  ObservableFuture<dynamic>(emptyCreateDanhMucResponse);

  @observable
  int danhMucId;

  @observable
  String tenDanhMuc = '';

  @observable
  String tag = '';

  @observable
  int danhMucCha;

  @observable
  String trangThai = '';

  @observable
  DanhMucList danhMucList;

  @observable
  int countAllDanhMucs = 0;

  @observable
  bool updateDanhMuc_success = false;

  @observable
  bool createDanhMuc_success = false;

  @computed
  bool get loading => fetchDanhMucsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountAllDanhMucs => fetchCountAllDanhMucsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingUpdateDanhMuc => fetchUpdateDanhMucFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCreateDanhMuc => fetchCreateDanhMucFuture.status == FutureStatus.pending;

  @action
  Future getDanhMucs() async {
    final future = _repository.getAllDanhMucs();
    fetchDanhMucsFuture = ObservableFuture(future);

    future.then((danhMucList) {
      this.danhMucList = danhMucList;
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        throw error;
      }
    });
  }

  @action
  Future fCountAllDanhMucs() async {
    final future = _repository.countAllDanhMucs();
    fetchCountAllDanhMucsFuture = ObservableFuture(future);

    future.then((totalDanhMucs) {
      this.countAllDanhMucs = totalDanhMucs;
      // print("totalUsers: " + totalUsers.toString());
    }
    ).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        throw error;
      }
    });
  }

  @action
  Future UpdateDanhMuc() async {
    updateDanhMuc_success = false;
    final future = _repository.updateDanhMuc(danhMucId, tenDanhMuc, tag, danhMucCha, trangThai);
    fetchUpdateDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateDanhMuc_success = true;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null) {

          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra lại kết nối mạng và thử lại!";
        throw error;
      }
    });
  }

  @action
  Future CreateDanhMuc() async {
    createDanhMuc_success = false;
    final future = _repository.createDanhMuc(tenDanhMuc, tag, danhMucCha, trangThai);
    fetchCreateDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        createDanhMuc_success = true;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null) {

          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra lại kết nối mạng và thử lại!";
        throw error;
      }
    });
  }

  @action
  Future IsActiveDanhMuc(DanhMuc danhMuc) async {
    updateDanhMuc_success = false;
    final future = _repository.updateDanhMuc(danhMuc.id, danhMuc.tenDanhMuc, danhMuc.tag, danhMuc.danhMucCha, danhMuc.trangThai);
    fetchUpdateDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateDanhMuc_success = true;
      }
    }).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null) {

          errorStore.errorMessage = error.response.data["error"]["message"];
        }
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra lại kết nối mạng và thử lại!";
        throw error;
      }
    });
  }

}