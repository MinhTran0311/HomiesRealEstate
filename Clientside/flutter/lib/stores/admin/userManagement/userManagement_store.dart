import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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

  static ObservableFuture<dynamic> emptyUserResponseAvatar =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchAvatarUserFuture =
  ObservableFuture<dynamic>(emptyUserResponseAvatar);

  static ObservableFuture<dynamic> emptyCountAllUsersResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountAllUsersFuture =
  ObservableFuture<dynamic>(emptyCountAllUsersResponse);

  static ObservableFuture<dynamic> emptyCountNewUsersInMonthResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchCountNewUsersInMonthFuture =
  ObservableFuture<dynamic>(emptyCountNewUsersInMonthResponse);

  @observable
  int countAllUsers = 0;

  @observable
  int countNewUsersInMonth = 0;

  @observable
  String filter = '';

  @observable
  UserList userList;

  @observable
  String avatarUser;

  @observable
  DateTime dateCurrent = DateTime.now();

  @observable
  int skipCount = 0;

  @observable
  int skipIndex = 10;

  @observable
  int maxCount = 10;

  @observable
  bool isIntialLoading = true;

  @observable
  bool successGetUsers = false;

  @computed
  bool get loading => fetchUsersFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingAvatar => fetchAvatarUserFuture.status == FutureStatus.pending && isIntialLoading;

  @computed
  bool get loadingCountAllUser => fetchCountAllUsersFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountNewUsersInMonth => fetchCountNewUsersInMonthFuture.status == FutureStatus.pending;
  //
  // @observable
  // List<ObservableFuture> list = new List<ObservableFuture>();
  // actions:-------------------------------------------------------------------
  @action
  Future getUsers(bool isLoadMore) {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += skipIndex;
    var userListGet = _repository.getAllUsers(skipCount, maxCount, filter);
    fetchUsersFuture = ObservableFuture(userListGet);
    userListGet.then((users) {
      if (!isLoadMore){
        this.userList = users;
         int lastUserHasAvatar = lastElementHasAvatar(users);
        for (int i=0; i< this.userList.users.length; i++){
          if (this.userList.users[i].profilePictureID != null) {
            final avtUserApi = _repository.getAvatarUsers(this.userList.users[i].id);
            fetchAvatarUserFuture = ObservableFuture(avtUserApi);

            avtUserApi.then((avt) {
              this.userList.users[i].avatar = avt;
              this.userList.users[i].avatarImage = imageFromBase64String(avt);
              if(i == lastUserHasAvatar) {
                if (isIntialLoading) isIntialLoading = false;
              }
            }).catchError((error) {
              errorStore.errorMessage = DioErrorUtil.handleError(error);
            });
          }
        }
      }
      else {
        for (int i=skipCount; i< users.users.length + skipCount; i++)
          {
            this.userList.users.add(users.users[i-skipCount]);
            if (this.userList.users[i].profilePictureID != null) {
              final avtUserApi = _repository.getAvatarUsers(this.userList.users[i].id);
              fetchAvatarUserFuture = ObservableFuture(avtUserApi);
              avtUserApi.then((avt) {
                this.userList.users[i].avatar = avt;
                this.userList.users[i].avatarImage = imageFromBase64String(avt);
              }).catchError((error) {
                errorStore.errorMessage = DioErrorUtil.handleError(error);
              });
            }
          }
      }
    }).catchError((error) {
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
    // this.userList = userList;
  }

  @action
  int lastElementHasAvatar(UserList userList) {
    for (int i = userList.users.length - 1; i >= 0; i--) {
      if (userList.users[i].profilePictureID != null) {
        return i;
      }
    }
    return 0;
  }

  @action
  int ElementsHasAvatar(UserList userList) {
    int count = 0;
    for (int i = 0; i < userList.users.length; i++) {
      if (userList.users[i].profilePictureID != null) {
        count++;
      }
    }
    return count;
  }

  @action
  Future fCountAllUsers() async {
    final future = _repository.countAllUsers();
    fetchCountAllUsersFuture = ObservableFuture(future);


    future.then((totalUsers) {
      // print("123213123");
      this.countAllUsers = totalUsers;
      // print("totalUsers: " + totalUsers.toString());
      }
    ).catchError((error) {
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

  // @action
  // bool checkFeatchPicure(UserList userList){
  //   if (list.length != ElementsHasAvatar(userList))
  //     return false;
  //   for (int i=0; i<list.length; i++) {
  //     if (!(list[i].status == FutureStatus.pending))
  //       {
  //         return false;
  //       }
  //   }
  //   return true;
  // }

  @action
  Future fCountNewUsersInMonth() async {
    final future = _repository.countNewUsersInMonth();
    fetchCountNewUsersInMonthFuture = ObservableFuture(future);


    future.then((totalUsersInMonth) {
      // print("123213123");
      this.countNewUsersInMonth = totalUsersInMonth;
      // print("totalUsers: " + totalUsersInMonth.toString());
    }
    ).catchError((error) {
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
    });
  }

}