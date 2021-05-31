import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/goiBaiDang/goiBaiDang_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'goiBaiDangManagement_store.g.dart';

class GoiBaiDangManagementStore = _GoiBaiDangManagementStore with _$GoiBaiDangManagementStore;

abstract class _GoiBaiDangManagementStore with Store {
  Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _GoiBaiDangManagementStore(Repository repository) : this._repository = repository;

  static ObservableFuture<GoiBaiDangList> emptyGoiBaiDangResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<GoiBaiDangList> fetchGoiBaiDangsFuture =
  ObservableFuture<GoiBaiDangList>(emptyGoiBaiDangResponse);

  static ObservableFuture<dynamic> emptyCountAllGoiBaiDangsResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountAllGoiBaiDangsFuture =
  ObservableFuture<dynamic>(emptyCountAllGoiBaiDangsResponse);

  @observable
  GoiBaiDangList goiBaiDangList;

  @observable
  int countAllGoiBaiDangs = 0;

  @computed
  bool get loading => fetchGoiBaiDangsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountAllGoiBaiDangs => fetchCountAllGoiBaiDangsFuture.status == FutureStatus.pending;

  @action
  Future getGoiBaiDangs() async {
    final future = _repository.getAllGoiBaiDangs();
    fetchGoiBaiDangsFuture = ObservableFuture(future);

    future.then((goiBaiDangList) {
      this.goiBaiDangList = goiBaiDangList;
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
  Future fCountAllGoiBaiDangs() async {
    final future = _repository.countAllGoiBaiDangs();
    fetchCountAllGoiBaiDangsFuture = ObservableFuture(future);

    future.then((totalGoiBaiDangs) {
      this.countAllGoiBaiDangs = totalGoiBaiDangs;
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