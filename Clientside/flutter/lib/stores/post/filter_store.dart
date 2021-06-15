import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/town/commune_list.dart';
import 'package:boilerplate/models/town/province_list.dart';
import 'package:boilerplate/models/town/town_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'filter_store.g.dart';

class FilterStore = _FilterStore with _$FilterStore;

abstract class _FilterStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _FilterStore(Repository repository){
    this._repository = repository;
  }

  // store variables:-----------------------------------------------------------
  // Post observer
  @observable
  filter_Model filter_model = filter_Model.instance;

  @observable
  bool success = false;

  @observable
  String giaDropDownValue="Bất kì";

  @observable
  String dienTichDropDownValue="Bất kì";

  @observable
  String loaiBaiDangDropDownValue="Bất kì";

  @observable
  var seletedRange = RangeValues(7000, 13000);

  @computed
  bool get suDungGiaFilter => giaDropDownValue != "Bất kì";

  @computed
  bool get suDungDienTichFilter => dienTichDropDownValue != "Bất kì";

  // actions:-------------------------------------------------------------------
  @action
  void setDiaChiContent(String value) {
    filter_model.diaChi = value;
  }
  @action
  void setTag(String value) {
    filter_model.tagTimKiem = value;
  }
  @action
  void setUsernameContent(String value) {
    filter_model.username = value;
  }
  @action
  void setGiaMin(String value) {
    filter_model.giaMin = value;
  }
  @action
  void setGiaMax(String value) {
    filter_model.giaMax = value;
  }
  @action
  void setDienTichMin(String value) {
    filter_model.dienTichMin = value;
  }
  @action
  void setDienTichMax(String value) {
    filter_model.dienTichMax = value;
  }
  @action
  void setTinhId(String value) {
    filter_model.tenTinh = value;
  }
  @action
  void setHuyenId(String value) {
    filter_model.tenHuyen = value;
  }
  @action
  void setXaId(String value) {
    filter_model.tenXa = value;
  }
  @action
  void setTenTinh(String value){
    filter_model.tenTinh = value;
  }
  @action
  void setTenHuyen(String value){
    filter_model.tenHuyen = value;
  }  @action
  void setTenXa(String value){
    filter_model.tenXa = value;
  }

  @action String calculateActualValue(String value, String option){
    if (option == "Bất kì")
      return "";
    double newValue = double.parse(value);
    if (option == "triệu"){
      newValue = newValue * 100;
    }
    else newValue = newValue * 100000;
    return newValue.toString().split(".")[0] + "0000";
  }

  @action
  filter_Model validateSearchContent() {
    print("val" + loaiBaiDangDropDownValue);
    if (filter_model == null || (loaiBaiDangDropDownValue == "Bất kì" &&
        filter_model.giaMin.isEmpty &&
        filter_model.giaMax.isEmpty &&
        filter_model.dienTichMin.isEmpty&&
        filter_model.dienTichMax.isEmpty&&
        filter_model.diaChi.isEmpty&&
        filter_model.username.isEmpty &&
        filter_model.tagTimKiem.isEmpty)
    ) {
      filter_model.loaiBaiDang="";
      return null;
    }
    else {
      filter_model.loaiBaiDang = loaiBaiDangDropDownValue == "Bất kì" ? "" : loaiBaiDangDropDownValue;
      filter_model.giaMin = filter_model.giaMin.isEmpty ? filter_model.giaMin : calculateActualValue(filter_model.giaMin, giaDropDownValue);
      filter_model.giaMax = filter_model.giaMax.isEmpty ? filter_model.giaMax : calculateActualValue(filter_model.giaMax, giaDropDownValue);
      return filter_model;
    }
  }

  @action
  void resetValue(){
    loaiBaiDangDropDownValue = 'Bất kì';
    giaDropDownValue = 'Bất kì';
    dienTichDropDownValue = 'Bất kì';
    //var _searchContent = filter_model.searchContent;
    //filter_model = new filter_Model(searchContent: _searchContent);
    filter_model.giaMin="";
    filter_model.giaMax="";
    filter_model.dienTichMin = "";
    filter_model.dienTichMax = "";
    filter_model.diaChi = "";
    filter_model.username = "";
    filter_model.tenTinh = "";
    filter_model.tenHuyen = "";
    filter_model.tenXa = "";
    filter_model.tagTimKiem = "";
    print(filter_model.username);
  }
  //#region Province
  @observable
  List<String> provinceListString = new List<String>();

  static ObservableFuture<ProvinceList> emptyProvinceResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<ProvinceList> fetchProvinceFuture =
  ObservableFuture<ProvinceList>(emptyProvinceResponse);

  @computed
  bool get loadingProvince => fetchProvinceFuture.status == FutureStatus.pending;

  @action
  Future getAllProvince() async {
    final future = _repository.getAllProvinces();
    fetchProvinceFuture = ObservableFuture(future);

    future.then((provinceList) {
      success = true;
      for (int i=0; i< provinceList.provinces.length; i++)
        this.provinceListString.add(provinceList.provinces[i].tenTinh);

    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Hãy kiểm tra kết nối Internet và thử lại!";
        throw error;
      }
    });
  }
  //#endregion

  //#region Town
  @observable
  List<String> townListString = [];

  static ObservableFuture<TownList> emptyTownResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<TownList> fetchTownFuture =
  ObservableFuture<TownList>(emptyTownResponse);

  @computed
  bool get loadingTown => fetchTownFuture.status == FutureStatus.pending;

  @action
  Future getTownByProvinceName(String provinceName) async {
    final future = _repository.getTowns(provinceFilter: provinceName);
    fetchTownFuture = ObservableFuture(future);

    future.then((townList) {
      success = true;
      this.townListString.clear();
      for (int i=0; i< townList.towns.length; i++)
        this.townListString.add(townList.towns[i].tenHuyen);
      print(townListString.length);
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
    });
  }
  //#endregion

  //#region Commune
  @observable
  List<String> communeListString = [];

  static ObservableFuture<CommuneList> emptyCommuneResponse = ObservableFuture.value(null);

  @observable
  ObservableFuture<CommuneList> fetchCommuneFuture =
  ObservableFuture<CommuneList>(emptyCommuneResponse);

  @computed
  bool get loadingCommune => fetchCommuneFuture.status == FutureStatus.pending;

  @action
  Future getCommuneByTownName(String TownName) async {
    final future = _repository.getCommunes(townFilter: TownName);
    fetchCommuneFuture = ObservableFuture(future);

    future.then((communeList) {
      success = true;
      this.communeListString.clear();
      for (int i=0; i< communeList.communes.length; i++)
        this.communeListString.add(communeList.communes[i].tenXa);
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
    });
  }
//#endregion

}

