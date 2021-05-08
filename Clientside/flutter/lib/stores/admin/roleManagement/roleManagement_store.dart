import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/role/role_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
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

  @observable
  RoleList roleList;

  @observable
  bool successGetRoles = false;

  @computed
  bool get loading => fetchRolesFuture.status == FutureStatus.pending;

  @action
  Future getRoles() async {
    final future = _repository.getAllRoles();
    fetchRolesFuture = ObservableFuture(future);

    future.then((roleList) {
      this.roleList = roleList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}