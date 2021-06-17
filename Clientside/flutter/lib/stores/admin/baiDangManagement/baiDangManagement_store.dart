import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/goiBaiDang/goiBaiDang_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'baiDangManagement_store.g.dart';

class BaiDangManagementStore = _BaiDangManagementStore with _$BaiDangManagementStore;

abstract class _BaiDangManagementStore with Store {
  Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _BaiDangManagementStore(Repository repository) : this._repository = repository;

  static ObservableFuture<dynamic> emptyCountNewBaiDangsInMonthResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountNewBaiDangsInMonthFuture =
  ObservableFuture<dynamic>(emptyCountNewBaiDangsInMonthResponse);

  @observable
  int countNewBaiDangsInMonth = 0;

  @computed
  bool get loadingCountNewBaiDangsInMonth => fetchCountNewBaiDangsInMonthFuture.status == FutureStatus.pending;

  @action
  Future fCountNewBaiDangsInMonth() async {
    final future = _repository.countNewBaiDangsInMonth();
    fetchCountNewBaiDangsInMonthFuture = ObservableFuture(future);

    future.then((newBaiDangs) {
      this.countNewBaiDangsInMonth = newBaiDangs;
      // print("totalUsers: " + totalUsers.toString());
    }
    ).catchError((error) {
      // if (error is DioError) {
      //   if (error.response.data != null)
      //     errorStore.errorMessage = error.response.data["error"]["message"];
      //   else
      //     errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else {
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }
}