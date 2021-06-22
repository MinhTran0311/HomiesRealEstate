import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/thuocTinh/thuocTinh.dart';
import 'package:boilerplate/models/thuocTinh/thuocTinh_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'thuocTinhManagement_store.g.dart';

class ThuocTinhManagementStore = _ThuocTinhManagementStore with _$ThuocTinhManagementStore;

abstract class _ThuocTinhManagementStore with Store {
  Repository _repository;
  final FormErrorStore formErrorStore = FormErrorStore();

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

  static ObservableFuture<dynamic> emptyUpdateThuocTinhResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateThuocTinhFuture =
  ObservableFuture<dynamic>(emptyUpdateThuocTinhResponse);

  static ObservableFuture<dynamic> emptyUpdateActiveThuocTinhResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateActiveThuocTinhFuture =
  ObservableFuture<dynamic>(emptyUpdateActiveThuocTinhResponse);

  static ObservableFuture<dynamic> emptyCreateThuocTinhResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCreateThuocTinhFuture =
  ObservableFuture<dynamic>(emptyCreateThuocTinhResponse);


  // store variables:-----------------------------------------------------------
  @observable
  String name='';

  @observable
  int idThuocTinh;

  @observable
  String active = '';

  @observable
  String KieuDuLieuShow = 'Chuỗi';

  @observable
  String KieuDuLieu = 'String';

  @observable
  ThuocTinhManagementList thuocTinhList;

  @observable
  int countAllThuocTinhs = 0;

  @observable
  String filter = '';

  @observable
  bool updateThuocTinh_success = false;

  @observable
  bool createThuocTinh_success = false;

  @observable
  bool updateActiveThuocTinh_success = false;

  @observable
  bool isIntialLoading = true;

  @observable
  int skipCount = 0;

  @observable
  int skipIndex = 10;

  @observable
  int maxCount = 10;


  @computed
  bool get canSubmit =>
    name.isNotEmpty &&
    name != null;

  @computed
  bool get loading => fetchThuocTinhsFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingCountAllThuocTinhs => fetchCountAllThuocTinhsFuture.status == FutureStatus.pending;

  @computed
  bool get loadingUpdateThuocTinh => fetchUpdateThuocTinhFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCreateThuocTinh => fetchCreateThuocTinhFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  void setThuocTinhId(int value) {
    idThuocTinh = value;
  }

  @action
  void setNameThuocTinh(String value) {
    name = value;
  }

  @action
  void setStringFilter(String value) {
    this.filter = value;
  }

  @action
  void setTrangThaiThuocTinh(bool value) {
    if (value) active = "On";
    else active = "Off";
  }

  @action
  void getKieuDuLieu(String value) {
    switch(value) {
      case "int": {
        KieuDuLieuShow = "Số nguyên";
        break;
      }
      case "double": {
        KieuDuLieuShow = "Số thực";
        break;
      }
      default: {
        KieuDuLieuShow = "Chuỗi";
        break;
      }
    }
  }

  @action
  void setKieuDuLieu(String value) {
    switch(value) {
      case "Số nguyên": {
        KieuDuLieu = "int";
        break;
      }
      case "Số thực": {
        KieuDuLieu = "double";
        break;
      }
      default: {
        KieuDuLieu = "String";
        break;
      }
    }
  }

  @action
  Future getThuocTinhs(bool isLoadMore) async {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += skipIndex;
    final future = _repository.getAllThuocTinhs(skipCount, maxCount, filter);
    fetchThuocTinhsFuture = ObservableFuture(future);

    future.then((thuocTinhList) {
      if (!isLoadMore){
        this.thuocTinhList = thuocTinhList;
        if (isIntialLoading) isIntialLoading=false;
      }
      else {
        for (int i=0; i< thuocTinhList.thuocTinhs.length; i++)
          this.thuocTinhList.thuocTinhs.add(thuocTinhList.thuocTinhs[i]);
      }
    }).catchError((error) {
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
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
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
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future UpdateThuocTinh() async {
    updateThuocTinh_success = false;
    final future = _repository.updateThuocTinh(idThuocTinh, name, KieuDuLieu, active);
    fetchUpdateThuocTinhFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        updateThuocTinh_success = true;
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
  Future CreateThuocTinh() async {
    createThuocTinh_success = false;
    final future = _repository.createThuocTinh(name, KieuDuLieu, active);
    fetchCreateThuocTinhFuture = ObservableFuture(future);

    future.then((res){
      if (res["success"]){
        createThuocTinh_success = true;
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
  Future IsActiveThuocTinh(ThuocTinhManagement thuocTinh) async {
    updateActiveThuocTinh_success = false;
    final future = _repository.updateThuocTinh(thuocTinh.id, thuocTinh.tenThuocTinh, thuocTinh.kieuDuLieu, thuocTinh.trangThai);
    fetchUpdateActiveThuocTinhFuture = ObservableFuture(future);

    future.then((res) {
      if (res["success"]) {
        updateActiveThuocTinh_success = true;
      }
    }).catchError((error) {
      if (error is DioError) {
        if (error.response.data != null) {

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