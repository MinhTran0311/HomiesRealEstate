import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/town/commune_list.dart';
import 'package:boilerplate/models/town/town_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'town_store.g.dart';

class TownStore = _TownStore with _$TownStore;

abstract class _TownStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _TownStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<TownList> emptyTownResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<TownList> fetchTownsFuture =
  ObservableFuture<TownList>(emptyTownResponse);

  @observable
  TownList townList;

  @observable
  bool success = false;

  @computed
  bool get loading => fetchTownsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getTowns() async {
    final future = _repository.getTowns();
    fetchTownsFuture = ObservableFuture(future);

    future.then((townList) {
      success = true;
      this.townList = townList;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra kết nối Internet và thử lại!";
        throw error;
      }
    });
  }
////////////commune
  // store variables:-----------------------------------------------------------
  static ObservableFuture<CommuneList> emptyCommuneResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<CommuneList> fetchCommunesFuture =
  ObservableFuture<CommuneList>(emptyCommuneResponse);

  @observable
  CommuneList communeList;

  @observable
  bool successCommune = false;

  @computed
  bool get loadingCommune => fetchCommunesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getCommunes() async {
    final future = _repository.getCommunes();
    fetchCommunesFuture = ObservableFuture(future);

    future.then((communeList) {
      success = true;
      this.communeList = communeList;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Hãy kiểm tra kết nối Internet và thử lại!";
        throw error;
      }
    });
  }
}