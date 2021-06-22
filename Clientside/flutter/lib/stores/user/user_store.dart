import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  bool updateUser_success = false;

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


  @action
  Future getUserByID(int userID) async {
    final future = _repository.getUserByID(userID);
    fetchUsersByIDFutures = ObservableFuture(future);

    future.then((userByID) {
      this.userByID = userByID;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }

  @observable
  CurrentUserForEditdto user;
  @observable
  CurrentUserForEditdto userCurrent;

  //User
  static ObservableFuture<CurrentUserForEditdto> emptyUserCurrentResponse =
  ObservableFuture.value(null);
  static ObservableFuture<CurrentUserForEditdto> emptyUpdateUserCurrentResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateUserCurrentFuture =
  ObservableFuture<CurrentUserForEditdto>(emptyUpdateUserCurrentResponse);
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
  static ObservableFuture<String> emptyUserCurrentPictureResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<String> fetchUserCurrentPictureFuture =
  ObservableFuture<String>(emptyUserCurrentPictureResponse);

  @computed
  bool get loadingUpdateCurrentUser => UpdateUserFuturess.status == FutureStatus.pending;
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
    future.then((user) {
      this.userCurrent = user;
      getCurrentPictureUser();
      getCurrentWalletUser();
      // this.getUserByID(user.UserID);
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
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
  Future getCurrentWalletUser() async {
    final future = _repository.getWalletUser();

    fetchUserCurrentWalletFuture = ObservableFuture(future);

    future.then((wallet) {
      this.userCurrent.wallet = wallet;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
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

    future.then((picture) {
      this.userCurrent.picture = picture;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }


  static ObservableFuture<CurrentUserForEditdto> emptyUserPostDetailResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<CurrentUserForEditdto> fetchUsersPostDetailFuture =
  ObservableFuture<CurrentUserForEditdto>(emptyUserPostDetailResponse);

  @computed
  bool get loadingUserPostDetail => fetchUsersPostDetailFuture.status == FutureStatus.pending;

  @observable
  CurrentUserForEditdto userOfCurrentPost;

  @action
  Future getUserOfCurrentDetailPost(int Id) async {
    final future = _repository.getUserOfCurrentDeatiaiPost(Id);
    fetchUsersPostDetailFuture = ObservableFuture(future);

    future.then((user) {
      this.userOfCurrentPost = user;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
      //   throw error;
      // }
      if (error.response != null && error.response.data!=null)
        //errorStore.errorMessage = error.response.data["error"]["message"];
        errorStore.errorMessage = translateErrorMessage(error.response.data["error"]["message"]);
      else
        errorStore.errorMessage = "Hãy kiểm tra lại kết nối mạng và thử lại!";
      throw error;
      //log("error ne: ");
      //log(DioErrorUtil.handleError(error));
      //errorStore.errorMessage = DioErrorUtil.handleError(error);
      //throw error;
    });
  }


  static ObservableFuture<dynamic> emptyUpdateUserResponses =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<dynamic> fetchUpdateUserFutures =
  ObservableFuture<dynamic>(emptyUpdateUserResponses);

  @computed
  bool get loadingsUpdateUser => fetchUpdateUserFutures.status == FutureStatus.pending;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<CurrentUserForEditdto> emptyUpdateUserResponsess =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<dynamic> UpdateUserFuturess = emptyUpdateUserResponsess;

  @action
  Future updateCurrentUser(String name,String surname,String phonenumber,String email,String userName,int id) async {
    updateUser_success = false;
    final future = _repository.updateCurrentUser(name, surname, phonenumber, email,userName,id);
    UpdateUserFuturess = ObservableFuture(future);

    future.then((user) {
      if (user["success"]==true){
        this.userCurrent.name = name;
        this.userCurrent.surname = surname;
        this.userCurrent.phoneNumber = phonenumber;
        this.userCurrent.emailAddress = email;
        this.userCurrent.userName = userName;
        updateUser_success = true;
      }

    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else{
      //   errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
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

    future.then((image) {
      if (image == true)
        this.userCurrent.picture = fileToken;
    }).catchError((error) {
      // if (error is DioError) {
      //   errorStore.errorMessage = DioErrorUtil.handleError(error);
      //   throw error;
      // }
      // else {
      //   errorStore.errorMessage =
      //   "Hãy kiểm tra kết nối Internet và thử lại!";
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
