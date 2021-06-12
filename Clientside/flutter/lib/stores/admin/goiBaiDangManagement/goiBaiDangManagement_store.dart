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

  static ObservableFuture<dynamic> emptyUpdateGoiBaiDangResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateGoiBaiDangFuture =
  ObservableFuture<dynamic>(emptyUpdateGoiBaiDangResponse);

  static ObservableFuture<dynamic> emptyCreateGoiBaiDangResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCreateGoiBaiDangFuture =
  ObservableFuture<dynamic>(emptyCreateGoiBaiDangResponse);

  @observable
  int goiBaiDangID;

  @observable
  String tenGoi = '';

  @observable
  double phi;

  @observable
  int thoiGianToiThieu;

  @observable
  int doUuTien;

  @observable
  String moTa;

  @observable
  String trangThai;

  @observable
  GoiBaiDangList goiBaiDangList;

  @observable
  bool updateGoiBaiDang_success = false;

  @observable
  bool createGoiBaiDang_success = false;

  @observable
  int countAllGoiBaiDangs = 0;

  @observable
  int skipCount = 0;

  @observable
  int skipIndex = 10;

  @observable
  int maxCount = 10;

  @observable
  bool isIntialLoading = true;

  @computed
  bool get loading => fetchGoiBaiDangsFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingCountAllGoiBaiDangs => fetchCountAllGoiBaiDangsFuture.status == FutureStatus.pending;

  @action
  Future getGoiBaiDangs(bool isLoadMore) async {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += skipIndex;
    final future = _repository.getAllGoiBaiDangs(skipCount, maxCount);
    fetchGoiBaiDangsFuture = ObservableFuture(future);

    future.then((goiBaiDangList) {
      if (!isLoadMore){
        this.goiBaiDangList = goiBaiDangList;
        if (isIntialLoading) isIntialLoading=false;
      }
      else {
        for (int i=0; i< goiBaiDangList.goiBaiDangs.length; i++)
          this.goiBaiDangList.goiBaiDangs.add(goiBaiDangList.goiBaiDangs[i]);
      }
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

  @action
  Future UpdateGoiBaiDang() async {
    updateGoiBaiDang_success = false;
    final future = _repository.updateGoiBaiDang(goiBaiDangID, tenGoi, phi, doUuTien, thoiGianToiThieu, moTa, trangThai);
    fetchUpdateGoiBaiDangFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateGoiBaiDang_success = true;
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
  Future CreateGoiBaiDang() async {
    createGoiBaiDang_success = false;
    final future = _repository.createGoiBaiDang(tenGoi, phi, doUuTien, thoiGianToiThieu, moTa, trangThai);
    fetchCreateGoiBaiDangFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        createGoiBaiDang_success = true;
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