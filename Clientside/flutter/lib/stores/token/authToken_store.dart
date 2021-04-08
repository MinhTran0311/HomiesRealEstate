import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:mobx/mobx.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/token/authToken.dart';

part 'authToken_store.g.dart';


class authTokenStore = _authTokenStore with _$authTokenStore;

abstract class _authTokenStore with Store{
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _authTokenStore(Repository repository) : this._repository = repository;

  //variables
  static ObservableFuture<AuthToken> emptyAuthResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<AuthToken> fetchTokenFuture = ObservableFuture<AuthToken>(emptyAuthResponse);

  @observable
  AuthToken authToken;

  @observable
  bool loggedIn = false;

  @computed
  bool get loading => fetchTokenFuture.status == FutureStatus.pending;

  @action
  Future<bool> authLogIn (String username, String password) async {
    final future = _repository.authrizing(username, password);
    fetchTokenFuture = ObservableFuture(future);
    future.then((authToken){
      this.authToken = authToken;
    }).catchError((error){
      errorStore.errorMessage = DioErrorUtil.handleError(error);
    });
    if (authToken.accessToken!=null){
      loggedIn=true;
      return true;
    }
    else {
      loggedIn=false;
      return false;
    }
  }
}
