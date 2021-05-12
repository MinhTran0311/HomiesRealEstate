import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
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
  _FilterStore(Repository repository);

  // store variables:-----------------------------------------------------------
  // Post observer
  static ObservableFuture<PostList> emptyPostResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<PostList> fetchPostsFuture =
  ObservableFuture<PostList>(emptyPostResponse);

  @observable
  filter_Model filter_model= new filter_Model();

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


  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;







  // actions:-------------------------------------------------------------------
  @action
  void setDiaChiContent(String value) {
    filter_model.diaChi = value;
  }
  @action
  void setGiaMin(String value) {
    filter_model.giaMin = value;
  }
  @action
  void setGiaMax(String value) {
    print(value);
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
  void setTinhId(int value) {
    filter_model.tinhId = value;
  }
  @action
  void setHuyenId(int value) {
    filter_model.huyenId = value;
  }
  @action
  void setXaId(int value) {
    filter_model.xaId = value;
  }

  // @action
  // void setMinGiaSlider(double value, bool isEmptyMax){
  //   if (filter_model.giaMax!=null && !isEmptyMax)
  //     seletedRange = RangeValues(value, filter_model.giaMax);
  //   else if (isEmptyMax)
  //     seletedRange = RangeValues(value, 20000);
  //
  //
  // }
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
  void validateSearchContent() {
    filter_Model finalFilter = new filter_Model();
    finalFilter.loaiBaiDang = loaiBaiDangDropDownValue == "Bất kì" ? "" : loaiBaiDangDropDownValue;
    finalFilter.giaMin = filter_model.giaMin.isEmpty? filter_model.giaMin : calculateActualValue(filter_model.giaMin, giaDropDownValue);
    finalFilter.giaMax = filter_model.giaMax.isEmpty? filter_model.giaMax : calculateActualValue(filter_model.giaMax, giaDropDownValue);
    finalFilter.dienTichMin = filter_model.dienTichMin;
    finalFilter.dienTichMax = filter_model.dienTichMax;
    finalFilter.diaChi = filter_model.diaChi;

    print(finalFilter);
    return;
  }
}

