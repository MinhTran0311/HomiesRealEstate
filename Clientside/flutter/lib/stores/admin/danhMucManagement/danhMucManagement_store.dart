import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/danhMuc/danhMuc.dart';
import 'package:boilerplate/models/danhMuc/danhMuc_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
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

  static ObservableFuture<DanhMucList> emptyAllDanhMucResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<DanhMucList> fetchAllDanhMucsFuture =
  ObservableFuture<DanhMucList>(emptyAllDanhMucResponse);

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


  static ObservableFuture<dynamic> emptyUpdateActiveDanhMucResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateActiveDanhMucFuture =
  ObservableFuture<dynamic>(emptyUpdateActiveDanhMucResponse);

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
  DanhMucList danhMucListAll;

  @observable
  int countAllDanhMucs = 0;

  @observable
  String filter = '';

  @observable
  int skipCount = 0;

  @observable
  int skipIndex = 10;

  @observable
  int maxCount = 10;

  @observable
  bool updateDanhMuc_success = false;

  @observable
  bool updateActiveDanhMuc_success = false;

  @observable
  bool createDanhMuc_success = false;

  @observable
  bool isIntialLoading = true;

  @computed
  bool get canSubmit =>
      tenDanhMuc.isNotEmpty &&
      tenDanhMuc != null &&
      tag.isNotEmpty &&
      tag != null;

  @computed
  bool get loading => fetchDanhMucsFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingAll => fetchAllDanhMucsFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingCountAllDanhMucs => fetchCountAllDanhMucsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingUpdateDanhMuc => fetchUpdateDanhMucFuture.status == FutureStatus.pending;

  @computed
  bool get loadingUpdateActiveDanhMuc => fetchUpdateActiveDanhMucFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCreateDanhMuc => fetchCreateDanhMucFuture.status == FutureStatus.pending;

  @action
  void setDanhMucId(int value) {
    danhMucId = value;
  }

  @action
  void setNameDanhMuc(String value) {
    tenDanhMuc = value;
  }

  @action
  void setTrangThaiDanhMuc(bool value) {
    if (value) trangThai = "On";
    else trangThai = "Off";
  }

  @action
  void setTagDanhMuc(String value) {
    tag = value;
  }

  @action
  void setDanhMucCha(int value) {
    if (value != null)
    danhMucCha = value;
    else danhMucCha = null;
  }

  @action
  Future getAllDanhMucs() async {
    final future = _repository.getAllDanhMucs(0, Preferences.maxDanhMucCount, filter);
    fetchAllDanhMucsFuture = ObservableFuture(future);

    future.then((danhMucList) {
      this.danhMucListAll = danhMucList;
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
    });
  }

  @action
  Future getDanhMucs(bool isLoadMore) async {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += skipIndex;
    final future = _repository.getAllDanhMucs(skipCount, maxCount, filter);
    fetchDanhMucsFuture = ObservableFuture(future);

    future.then((danhMucList) {
      if (!isLoadMore){
        this.danhMucList = danhMucList;
        if (isIntialLoading) isIntialLoading=false;
      }
      else {
        for (int i=0; i< danhMucList.danhMucs.length; i++)
          this.danhMucList.danhMucs.add(danhMucList.danhMucs[i]);
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
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
      if (error.response != null && error.response.data!=null)
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future UpdateDanhMuc() async {
    updateDanhMuc_success = false;
    if (danhMucCha == 0) danhMucCha = null;
    final future = _repository.updateDanhMuc(danhMucId, tenDanhMuc, tag, danhMucCha, trangThai);
    fetchUpdateDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateDanhMuc_success = true;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future CreateDanhMuc() async {
    createDanhMuc_success = false;
    if (danhMucCha == 0) danhMucCha = null;
    final future = _repository.createDanhMuc(tenDanhMuc, tag, danhMucCha, trangThai);
    fetchCreateDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        createDanhMuc_success = true;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future IsActiveDanhMuc(DanhMuc danhMuc) async {
    updateActiveDanhMuc_success = false;
    final future = _repository.updateDanhMuc(danhMuc.id, danhMuc.tenDanhMuc, danhMuc.tag, danhMuc.danhMucCha, danhMuc.trangThai);
    fetchUpdateActiveDanhMucFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateActiveDanhMuc_success = true;
      }
    }).catchError((error){
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  void setStringFilter(String value) {
    this.filter = value;
  }

  @action
  DanhMuc findDanhMucCha(int value) {
    try {
      for (int i = 0; i < danhMucListAll.danhMucs.length; i++) {
        if (danhMucListAll.danhMucs[i].id == value)
          return danhMucListAll.danhMucs[i];
      }
    } catch(e){
      throw(e);
    }
  }
}