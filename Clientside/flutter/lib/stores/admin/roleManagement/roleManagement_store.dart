import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/role/role_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'roleManagement_store.g.dart';

class RoleManagementStore = _RoleManagementStore with _$RoleManagementStore;

abstract class _RoleManagementStore with Store {
  Repository _repository;

  final ErrorStore errorStore = ErrorStore();

  _RoleManagementStore(Repository repository) : this._repository = repository;

  static ObservableFuture<RoleList> emptyRoleResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<RoleList> fetchRolesFuture =
  ObservableFuture<RoleList>(emptyRoleResponse);

  static ObservableFuture<dynamic> emptyCountAllRolesResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountAllRolesFuture =
  ObservableFuture<dynamic>(emptyCountAllRolesResponse);

  @observable
  RoleList roleList;

  @observable
  bool successGetRoles = false;

  @observable
  int countAllRoles = 0;

  @observable
  bool isIntialLoading = true;

  @computed
  bool get loading => fetchRolesFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingCountAllRoles => fetchCountAllRolesFuture.status == FutureStatus.pending;

  @action
  Future getRoles() async {
    final future = _repository.getAllRoles();
    fetchRolesFuture = ObservableFuture(future);

    future.then((roleList) {
      this.roleList = roleList;
      if (isIntialLoading) isIntialLoading=false;
    }).catchError((error){
      // if (error is DioError) {
      //   if (error.response.data!=null)
      //     errorStore.errorMessage = error.response.data["error"]["message"];
      //   else
      //     errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null) {
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      } else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

  @action
  Future fCountAllRoles() async {
    final future = _repository.countAllRoles();
    fetchCountAllRolesFuture = ObservableFuture(future);

    future.then((totalRoles) {
      this.countAllRoles = totalRoles;
      // print("totalUsers: " + totalUsers.toString());
    }
    ).catchError((error){
      // if (error is DioError) {
      //   if (error.response.data!=null)
      //     errorStore.errorMessage = error.response.data["error"]["message"];
      //   else
      //     errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
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
}