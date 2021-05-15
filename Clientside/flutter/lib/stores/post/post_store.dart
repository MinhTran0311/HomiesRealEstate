import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/post/postpack/pack_list.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';

import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _PostStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------
  static ObservableFuture<PostList> emptyPostResponse =
      ObservableFuture.value(null);

  static ObservableFuture<PostCategoryList> emptyPostCategorysResponse =
      ObservableFuture.value(null);
  static ObservableFuture<PropertyList> emptyPropertiesResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<PostList> fetchPostsFuture =
      ObservableFuture<PostList>(emptyPostResponse);

  @observable
  ObservableFuture<PostCategoryList> fetchPostCategorysFuture =
    ObservableFuture<PostCategoryList>(emptyPostCategorysResponse);

  @observable
  ObservableFuture<PropertyList> fetchPropertiesFuture =
      ObservableFuture<PropertyList>(emptyPropertiesResponse);


  @observable
  PostList postList;
  @observable
  PostCategoryList postCategoryList;

  @observable
  PropertyList propertyList;

  @observable
  List<String> imageUrlList;

  @observable
  bool success = false;
  @observable
  bool successgetcategorys = false;
  @observable
  bool propertiesSuccess = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

  @computed
  bool get loadinggetcategorys => fetchPostCategorysFuture.status == FutureStatus.pending;

  @computed
  bool get propertiesLoading => fetchPropertiesFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPosts() async {
    final future = _repository.getPosts();
    fetchPostsFuture = ObservableFuture(future);

    future.then((postList) {
      success = true;
      this.postList = postList;
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
  Future getPostProperties(String postId) async {
    propertiesSuccess = false;
    final future = _repository.getPostProperties(postId);
    fetchPropertiesFuture = ObservableFuture(future);

    future.then((propertyList) {
      propertiesSuccess = true;
      this.propertyList = propertyList;
    }).catchError((error) {
      propertiesSuccess = false;
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
  Future getPostcategorys() async {
    successgetcategorys=false;
    final future = _repository.getPostCategorys();
    fetchPostCategorysFuture = ObservableFuture(future);

    future.then((postCategoryList) {
      successgetcategorys=true;
      this.postCategoryList = postCategoryList;
    }).catchError((error) {
      if (error is DioError) {
        successgetcategorys=false;
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else{
        errorStore.errorMessage="Please check your internet connection and try again!";
        throw error;
      }
    });
  }
  //////////////////////pack
  static ObservableFuture<PackList> emptyPackResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<PackList> fetchPacksFuture =
  ObservableFuture<PackList>(emptyPackResponse);

  @observable
  PackList packList;

  @observable
  bool successPack = false;

  @computed
  bool get loadingPack => fetchPacksFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getPacks() async {
    final future = _repository.getPacks();
    fetchPacksFuture = ObservableFuture(future);

    future.then((packList) {
      success = true;
      this.packList = packList;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Please check your internet connection and try again!";
        throw error;
      }
    });
  }
  //////////////////////ThuocTinh
  static ObservableFuture<ThuocTinhList> emptyThuocTinhResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<ThuocTinhList> fetchThuocTinhsFuture =
  ObservableFuture<ThuocTinhList>(emptyThuocTinhResponse);

  @observable
  ThuocTinhList thuocTinhList;

  @observable
  bool successThuocTinh = false;

  @computed
  bool get loadingThuocTinh => fetchThuocTinhsFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getThuocTinhs() async {
    final future = _repository.getThuocTinhs();
    fetchThuocTinhsFuture = ObservableFuture(future);

    future.then((thuocTinhList) {
      success = true;
      this.thuocTinhList = thuocTinhList;
    }).catchError((error) {
      if (error is DioError) {
        errorStore.errorMessage = DioErrorUtil.handleError(error);
        throw error;
      }
      else {
        errorStore.errorMessage =
        "Please check your internet connection and try again!";
        throw error;
      }
    });
  }
  //////////////////postPost
  static ObservableFuture<String> emptyNewpostResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<String> fetchNewpostsFuture =
  ObservableFuture<String>(emptyNewpostResponse);

  @observable
  bool successNewpost = false;

  @computed
  bool get loadingNewpost => fetchNewpostsFuture.status == FutureStatus.pending;
  Future postPost(Newpost post) async {
      final postPostFuture = _repository.postPost(post);
      fetchNewpostsFuture = ObservableFuture(postPostFuture);
      postPostFuture.then((newpost) {
        print(newpost);
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
