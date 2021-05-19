import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'post_store.g.dart';

class PostStore = _PostStore with _$PostStore;

abstract class _PostStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();
  List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  _PostStore(Repository repository) {
    this._repository = repository;
    _disposers = [reaction((_) => searchContent, validateSearchContent)];
  }

    // store variables:-----------------------------------------------------------
    // Post observer
    static ObservableFuture<PostList> emptyPostResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<PostList> fetchPostsFuture =
    ObservableFuture<PostList>(emptyPostResponse);

    // Image observer
    static ObservableFuture<PropertyList> emptyPropertiesResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<PropertyList> fetchPropertiesFuture =
    ObservableFuture<PropertyList>(emptyPropertiesResponse);


    static ObservableFuture<dynamic> emptyIsBaiDangYeuThichResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<dynamic> fetchisBaiGhimYeuThichFuture =
    ObservableFuture<dynamic>(emptyIsBaiDangYeuThichResponse);

    static ObservableFuture<dynamic> emptyGetRecommendPostsFutureResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<dynamic> fetchisGetRecommendPostsFuture =
    ObservableFuture<dynamic>(emptyGetRecommendPostsFutureResponse);

    static ObservableFuture<dynamic> emptySearchResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<dynamic> fetchSearchFuture =
    ObservableFuture<dynamic>(emptySearchResponse);

    @observable
    PostList postList;

    @observable
    PostList rcmPostList;

    @observable
    bool isIntialLoading = true;

    @observable
    int skipCount = 0;

    @observable
    int maxCount = 1;

    @observable
    PropertyList propertyList;

    @observable
    List<String> imageUrlList;

    @observable
    filter_Model filter_model = new filter_Model();

    @observable
    bool success = false;

    @observable
    bool propertiesSuccess = false;

    @observable
    bool isBaiGhimYeuThich = false;

    @observable
    String searchContent='';

    @observable
    ScrollController scrollController= ScrollController();

    @computed
    bool get loading => fetchPostsFuture.status == FutureStatus.pending && isIntialLoading;

    @computed
    bool get propertiesLoading => fetchPropertiesFuture.status == FutureStatus.pending;

    @computed
    bool get isBaiGhimYeuThichLoading => fetchisBaiGhimYeuThichFuture.status == FutureStatus.pending;

    @computed
    bool get getRecommendPostsFutureLoading => fetchisGetRecommendPostsFuture.status == FutureStatus.pending;

    @computed
    bool get searchLoading => fetchSearchFuture.status == FutureStatus.pending;

    @computed
    bool get hasFilter => filter_model!=null;

    // actions:-------------------------------------------------------------------
    @action
    void setSearchContent(String value) {
      searchContent = value;
    }

    @action
    Future getPosts(bool isLoadMore) async {
      if (!isLoadMore){
        skipCount = 0;
      }
      else
        skipCount+= Preferences.skipIndex;
      final future = _repository.getPosts(skipCount, Preferences.maxCount);
      fetchPostsFuture = ObservableFuture(future);

      future.then((postList) {
        success = true;
        if (!isLoadMore){
          this.postList = postList;
          if (isIntialLoading) isIntialLoading=false;
        }
        else {
          for (int i=0; i< postList.posts.length; i++)
            this.postList.posts.add(postList.posts[i]);
        }
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

  // @action
  // Future getPostsFromXY() async {
  //   final future = _repository.getPosts();
  //   fetchPostsFuture = ObservableFuture(future);
  //
  //   future.then((postList) {
  //     success = true;
  //     this.postList = postList;
  //   }).catchError((error) {
  //     if (error is DioError) {
  //       errorStore.errorMessage = DioErrorUtil.handleError(error);
  //       throw error;
  //     }
  //     else{
  //       errorStore.errorMessage="Please check your internet connection and try again!";
  //       throw error;
  //     }
  //   });
  // }

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
    Future isBaiGhimYeuThichOrNot(String postId) async {
      isBaiGhimYeuThich = false;
      final futrue = _repository.isBaiGhimYeuThichOrNot(postId);
      fetchisBaiGhimYeuThichFuture = ObservableFuture(futrue);

      futrue.then((result) {
        if (result["result"]["exist"]) {
          isBaiGhimYeuThich = true;
        }
        else{
          isBaiGhimYeuThich = false;
        }
      }).catchError((error){
        isBaiGhimYeuThich = false;
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
    Future createOrChangeStatusBaiGhimYeuThich(String postId) async {
      final futrue = _repository.createOrChangeStatusBaiGhimYeuThich(postId,!isBaiGhimYeuThich);

      futrue.then((result) {
        isBaiGhimYeuThich =!isBaiGhimYeuThich;
      }).catchError((error){
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
  Future searchPosts() async {
    filter_model.searchContent = searchContent;
    final futrue = _repository.searchPosts(filter_model);
    fetchisBaiGhimYeuThichFuture = ObservableFuture(futrue);

    futrue.then((result) {
      this.postList = result;
    }).catchError((error){
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
  Future getRecommendPosts(String tag) async {
    filter_Model fm = new filter_Model();
    fm.tagTimKiem = tag;
    final futrue = _repository.searchPosts(fm);
    fetchisGetRecommendPostsFuture = ObservableFuture(futrue);

    futrue.then((result) {
      this.rcmPostList = result;
      print("11111");
      print(this.rcmPostList.posts.length);
    }).catchError((error){
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
  void validateSearchContent(String value) {
      return;
  }
}
