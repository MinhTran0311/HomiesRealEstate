import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user.dart';
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
  CurrentUserForEditdto user;
  static ObservableFuture<CurrentUserForEditdto> emptyUserResponse =
  ObservableFuture.value(null);

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

  @computed
  bool get isLoadings => loginFuture.status == FutureStatus.pending;

  @action
  Future getCurrentUser() async {
    final future = _repository.getCurrentUser();
    fetchUsersFuture = ObservableFuture(future);

    fetchUsersFuture.then((user) {
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
    });
  }

  @action
  Future getCurrentWalletUser() async {
      final future = _repository.getWalletUser();
      fetchUsersFuture = ObservableFuture(future);

      fetchUsersFuture.then((user) {
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

  @action
  Future updateCurrentUser(String name,String surname,String phonenumber,String email,String userName) async {
    final future = _repository.updateCurrentUser(name, surname, phonenumber, email,userName);
    fetchUsersFuture = ObservableFuture(future);

    fetchUsersFuture.then((user) {
      // this.user = user;
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
  Future getUserOfCurrentDetailPost(int Id) async {
    final future = _repository.getUserOfCurrentDeatiaiPost(Id);
    fetchUsersFuture = ObservableFuture(future);

    fetchUsersFuture.then((user) {
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
    });
  }
}
