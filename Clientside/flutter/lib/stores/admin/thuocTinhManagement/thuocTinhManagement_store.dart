import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/thuocTinh/thuocTinh_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'thuocTinhManagement_store.g.dart';

class ThuocTinhManagementStore = _ThuocTinhManagementStore with _$ThuocTinhManagementStore;

abstract class _ThuocTinhManagementStore with Store {
  Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _ThuocTinhManagementStore(Repository repository) : this._repository = repository;

  static ObservableFuture<ThuocTinhManagementList> emptyThuocTinhResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<ThuocTinhManagementList> fetchThuocTinhsFuture =
  ObservableFuture<ThuocTinhManagementList>(emptyThuocTinhResponse);

  static ObservableFuture<dynamic> emptyCountAllThuocTinhsResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountAllThuocTinhsFuture =
  ObservableFuture<dynamic>(emptyCountAllThuocTinhsResponse);

  @observable
  ThuocTinhManagementList thuocTinhList;

  @observable
  int countAllThuocTinhs = 0;

  @computed
  bool get loading => fetchThuocTinhsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountAllThuocTinhs => fetchCountAllThuocTinhsFuture.status == FutureStatus.pending;

  @action
  Future getThuocTinhs() async {
    final future = _repository.getAllThuocTinhs();
    fetchThuocTinhsFuture = ObservableFuture(future);

    future.then((thuocTinhList) {
      this.thuocTinhList = thuocTinhList;
    }).catchError((error) {
      if (error is DioError) {
        if (error.response.data != null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        throw error;
      }
    });
  }

  @action
  Future fCountAllThuocTinhs() async {
    final future = _repository.countAllThuocTinhs();
    fetchCountAllThuocTinhsFuture = ObservableFuture(future);

    future.then((totalThuocTinhs) {
      this.countAllThuocTinhs = totalThuocTinhs;
      // print("totalUsers: " + totalUsers.toString());
    }
    ).catchError((error) {
      if (error is DioError) {
        if (error.response.data != null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        throw error;
      }
    });
  }
}