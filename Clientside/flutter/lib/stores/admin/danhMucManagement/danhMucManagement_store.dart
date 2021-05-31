import 'package:boilerplate/data/repository.dart';
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

  @observable
  DanhMucList danhMucList;

  @observable
  int countAllDanhMucs = 0;

  @computed
  bool get loading => fetchDanhMucsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountAllDanhMucs => fetchCountAllDanhMucsFuture.status == FutureStatus.pending;

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
}