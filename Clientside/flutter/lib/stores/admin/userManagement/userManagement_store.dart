import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';

part 'userManagement_store.g.dart';

class UserManagementStore = _UserManagementStore with _$UserManagementStore;

abstract class _UserManagementStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _UserManagementStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<UserList> emptyUserResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<UserList> fetchUsersFuture =
  ObservableFuture<UserList>(emptyUserResponse);

  static ObservableFuture<getAvatarUser> emptyUserResponseAvatar =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<getAvatarUser> fetchAvatarUserFuture =
  ObservableFuture<getAvatarUser>(emptyUserResponseAvatar);

  @observable
  UserList userList;

  @observable
  getAvatarUser avatarUser;

  @observable
  bool successGetUsers = false;

  @computed
  bool get loading => fetchUsersFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getUsers() async {
    final future = _repository.getAllUsers();
    fetchUsersFuture = ObservableFuture(future);

    future.then((userList) {
      this.userList = userList;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }

  @action
  Future getAvatarUsers(int Id) async {
    final futureAvatar = _repository.getAvatarUsers(Id);
    fetchAvatarUserFuture = ObservableFuture(futureAvatar);

    futureAvatar.then((getAvatarUser) {
      this.avatarUser = getAvatarUser;
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
  }
}