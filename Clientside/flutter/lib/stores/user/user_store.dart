import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import '../../data/repository.dart';
import '../form/form_store.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // repository instance
  final Repository _repository;

  // store for handling form errors
  final FormErrorStore formErrorStore = FormErrorStore();

  // store for handling error messages
  final ErrorStore errorStore = ErrorStore();

  // bool to check if current user is logged in
  bool isLoggedIn = false;

  // constructor:---------------------------------------------------------------
  _UserStore(Repository repository) : this._repository = repository {

    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    repository.isLoggedIn.then((value) {
      this.isLoggedIn = value ?? false;
    });
  }

  // disposers:-----------------------------------------------------------------
  List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<bool> emptyLoginResponse =
  ObservableFuture.value(false);

  // store variables:-----------------------------------------------------------
  @observable
  bool success = false;

  @observable
  ObservableFuture<bool> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {

    final future = _repository.login(email, password);
    loginFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value) {
        _repository.saveIsLoggedIn(true);
        this.isLoggedIn = true;
        this.success = true;
      } else {
        print('failed to login');
      }
    }).catchError((e) {
      print(e);
      this.isLoggedIn = false;
      this.success = false;
      throw e;
    });
  }

  logout() {
    this.isLoggedIn = false;
    _repository.saveIsLoggedIn(false);
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }



  @observable
  User userByID;

  static ObservableFuture<User> emptyUserByIDResponses =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<User> fetchUsersByIDFutures =
  ObservableFuture<User>(emptyUserByIDResponses);

  @computed
  bool get loadingsUserByID => fetchUsersByIDFutures.status == FutureStatus.pending;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User> emptyUserByIDResponsess =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<User> UserByIDFuturess = emptyUserByIDResponsess;


  // @action
  // Future getUserByID(int userID) async {
  //   final future = _repository.getUserByID(userID);
  //   fetchUsersByIDFutures = ObservableFuture(future);
  //
  //   fetchUsersByIDFutures.then((userByID) {
  //     this.userByID = userByID;
  //   }).catchError((error) {
  //     if (error is DioError) {
  //       errorStore.errorMessage = DioErrorUtil.handleError(error);
  //       throw error;
  //     }
  //     else{
  //       errorStore.errorMessage="Please check your internet connection and try again!";
  //       throw error;
  //     }
  //     //log("error ne: ");
  //     //log(DioErrorUtil.handleError(error));
  //     //errorStore.errorMessage = DioErrorUtil.handleError(error);
  //     //throw error;
  //   });
  // }

  @observable
  CurrentUserForEditdto user;
  CurrentUserForEditdto usercurrent;

  //User
  static ObservableFuture<CurrentUserForEditdto> emptyUserCurrentResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<CurrentUserForEditdto> fetchUserCurrentFuture =
  ObservableFuture<CurrentUserForEditdto>(emptyUserCurrentResponse);
  //Wallet
  static ObservableFuture<double> emptyUserCurrentWalletResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<double> fetchUserCurrentWalletFuture =
  ObservableFuture<double>(emptyUserCurrentWalletResponse);
  //Picture
  static ObservableFuture<String> emptyUserCurrentPictureResponse =  ObservableFuture.value(null);
  static ObservableFuture<CurrentUserForEditdto> emptyUserResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<String> fetchUserCurrentPictureFuture =
  ObservableFuture<String>(emptyUserCurrentPictureResponse);

  @computed
  bool get loadingCurrentUser => fetchUserCurrentFuture.status == FutureStatus.pending;
  @computed
  bool get loadingCurrentUserWallet => fetchUserCurrentWalletFuture.status == FutureStatus.pending;
  @computed
  bool get loadingCurrentUserPicture => fetchUserCurrentPictureFuture.status == FutureStatus.pending;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<CurrentUserForEditdto> emptyCurrentUserResponses =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<CurrentUserForEditdto> CurrentUserFuture = emptyCurrentUserResponses;

  @computed
  bool get isLoadingCurrentUser => CurrentUserFuture.status == FutureStatus.pending;
  @action
  Future getCurrentUser() async {
    final future = _repository.getCurrentUser();
    fetchUserCurrentFuture = ObservableFuture(future);
    fetchUserCurrentFuture.then((user) {
      this.user = user;
      this.usercurrent=user;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
    });
  }

  @action
  Future getCurrentWalletUser() async {
    final future = _repository.getWalletUser();

    fetchUserCurrentWalletFuture = ObservableFuture(future);

    fetchUserCurrentWalletFuture.then((wallet) {
      this.user.wallet = wallet;
      this.usercurrent.wallet;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }
  @action
  Future getCurrentPictureUser() async {
    final future = _repository.getPictureUser();

    fetchUserCurrentPictureFuture = ObservableFuture(future);

    fetchUserCurrentPictureFuture.then((picture) {
      this.user.picture = picture;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }


  @observable
  ObservableFuture<CurrentUserForEditdto> fetchUsersFuture =
  ObservableFuture<CurrentUserForEditdto>(emptyUserResponse);

  @computed
  bool get loading => fetchUsersFuture.status == FutureStatus.pending;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<CurrentUserForEditdto> emptyLoginResponses =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<CurrentUserForEditdto> loginFutures = emptyLoginResponses;

  @action
  Future getUserOfCurrentDetailPost(int Id) async {
    final future = _repository.getUserOfCurrentDeatiaiPost(Id);
    fetchUsersFuture = ObservableFuture(future);

    future.then((user) {
      this.user = user;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }


  static ObservableFuture<CurrentUserForEditdto> emptyUpdateUserResponses =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<CurrentUserForEditdto> fetchUpdateUserFutures =
  ObservableFuture<CurrentUserForEditdto>(emptyUpdateUserResponses);

  @computed
  bool get loadingsUpdateUser => fetchUpdateUserFutures.status == FutureStatus.pending;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<CurrentUserForEditdto> emptyUpdateUserResponsess =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<CurrentUserForEditdto> UpdateUserFuturess = emptyUpdateUserResponsess;

  @action
  Future updateCurrentUser(String name,String surname,String phonenumber,String email,String userName,int id) async {
    final future = _repository.updateCurrentUser(name, surname, phonenumber, email,userName,id);
    fetchUpdateUserFutures = ObservableFuture(future);

    fetchUpdateUserFutures.then((user) {
      this.user.name = name;
      this.user.surname = surname;
      this.user.phoneNumber = phonenumber;
      this.user.emailAddress = email;
      this.user.userName = userName;
      this.user.UserID=id;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
    });
  }

  static ObservableFuture<dynamic> emptyUpdatePictureUserResponses =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdatePictureUserFutures =
  ObservableFuture<dynamic>(emptyUpdatePictureUserResponses);

  @computed
  bool get loadingsUpdatePictureUser => fetchUpdatePictureUserFutures.status == FutureStatus.pending;

  @action
  Future updatePictureCurrentUser(String fileToken) async {
    final future = _repository.updatePictureCurrentUser(fileToken);
    fetchUpdatePictureUserFutures = ObservableFuture(future);

    fetchUpdatePictureUserFutures.then((image) {
      if(image==true)
        this.user.picture = fileToken;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
    });
  }
}
