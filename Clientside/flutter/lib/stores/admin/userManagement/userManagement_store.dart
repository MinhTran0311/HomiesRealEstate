import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
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
  bool get loadingAvatar => fetchAvatarUserFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountAllUser => fetchCountAllUsersFuture.status == FutureStatus.pending;

  @computed
  bool get loadingCountNewUsersInMonth => fetchCountNewUsersInMonthFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getUsers(bool isLoadMore) {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += skipIndex;
    var userListGet = _repository.getAllUsers(skipCount, maxCount);
    fetchUsersFuture = ObservableFuture(userListGet);
    userListGet.then((users) {
      if (!isLoadMore){
        this.userList = users;
        if (isIntialLoading) isIntialLoading=false;
        for (int i=0; i< this.userList.users.length; i++){
          if (this.userList.users[i].profilePictureID != null) {
            if (this.userList.users[i].profilePictureID.isNotEmpty) {
              final avtUserApi = _repository.getAvatarUsers(this.userList.users[i].id);
              fetchAvatarUserFuture = ObservableFuture(avtUserApi);
              avtUserApi.then((avt) {
                this.userList.users[i].avatar = avt;
              }).catchError((error) {
                errorStore.errorMessage = DioErrorUtil.handleError(error);
              });
            }
          }
        }
      }
      else {
        for (int i=0; i< users.users.length; i++)
          {
            this.userList.users.add(users.users[i]);
            if (this.userList.users[i].profilePictureID != null) {
              if (this.userList.users[i].profilePictureID.isNotEmpty) {
                final avtUserApi = _repository.getAvatarUsers(this.userList.users[i].id);
                fetchAvatarUserFuture = ObservableFuture(avtUserApi);
                avtUserApi.then((avt) {
                  this.userList.users[i].avatar = avt;
                }).catchError((error) {
                  errorStore.errorMessage = DioErrorUtil.handleError(error);
                });
              }
            }
          }

      }
    }).catchError((error) {
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
    // this.userList = userList;



    // future.then((userList) async{
    //   this.userList = userList;
    //   if (this.userList != null) {
    //     for (int i=0; i<userList.users.length; i++){
    //       if (this.userList.users[i].profilePictureID != null) {
    //         // print("dat no: " + this.userList.users[i].profilePictureID);
    //         if (this.userList.users[i].profilePictureID.isNotEmpty) {
    //           // print("111111");
    //           // this.userList.users[i].avatar = "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";
    //           this.userList.users[i].avatar ="";
    //           var id = 1 _repository.getAvatarUsers(this.userList.users[i].id);
    //           userList.users[i].avatar = id;
    //           //getAvatarUsers(this.userList.users[i].id, i);
    //           // print("33333");
    //           //print("avt: " + this.userList.users[i].avatar);
    //         }
    //       }
    //     }
    //   }
    //   // print("LengthUserList: " + this.userList.users.length.toString());
    // }).catchError((error) {
    //   errorStore.errorMessage = DioErrorUtil.handleError(error);
    // });

    // await Future.forEach(this.userList.users, (User user) async {
    //   await getAvatarUsers(user.id,)
    // });
  }
  //
  // @action
  // Future deleteUser(int id) async{
  //   var future = await _repository.deleteUser(id);
  // }

  @action
  Future fCountAllUsers() async {
    final future = _repository.countAllUsers();
    fetchCountAllUsersFuture = ObservableFuture(future);


    future.then((totalUsers) {
      // print("123213123");
      this.countAllUsers = totalUsers;
      // print("totalUsers: " + totalUsers.toString());
      }
    ).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        throw error;
      }
    });
  }

  @action
  Future fCountNewUsersInMonth() async {
    final future = _repository.countNewUsersInMonth();
    fetchCountNewUsersInMonthFuture = ObservableFuture(future);


    future.then((totalUsersInMonth) {
      // print("123213123");
      this.countNewUsersInMonth = totalUsersInMonth;
      // print("totalUsers: " + totalUsersInMonth.toString());
    }
    ).catchError((error){
      if (error is DioError) {
        if (error.response.data!=null)
          errorStore.errorMessage = error.response.data["error"]["message"];
        else
          errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        throw error;
      }
    });
  }

}