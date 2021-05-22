import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/post/postpack/pack_list.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';

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
    PropertyList propertyList;

  // store variables:-----------------------------------------------------------

  static ObservableFuture<PostCategoryList> emptyPostCategorysResponse =
      ObservableFuture.value(null);

  @observable
  ObservableFuture<PostCategoryList> fetchPostCategorysFuture =
    ObservableFuture<PostCategoryList>(emptyPostCategorysResponse);

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
  PostCategoryList postCategoryList;
  @observable
  String searchContent='';

  @observable
  ScrollController scrollController= ScrollController();

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending && isIntialLoading;

  @observable
  bool successgetcategorys = false;
  @computed
  bool get propertiesLoading => fetchPropertiesFuture.status == FutureStatus.pending;

  @computed
  bool get isBaiGhimYeuThichLoading => fetchisBaiGhimYeuThichFuture.status == FutureStatus.pending;

  @computed
  bool get getRecommendPostsFutureLoading => fetchisGetRecommendPostsFuture.status == FutureStatus.pending;

  @computed
  bool get searchLoading => fetchSearchFuture.status == FutureStatus.pending;

  @computed
  bool get loadinggetcategorys => fetchPostCategorysFuture.status == FutureStatus.pending;

  @computed
  bool get hasFilter => filter_model!=null;

  // actions:-------------------------------------------------------------------
  @action
  void setSearchContent(String value, {bool isTag=false}) {
    searchContent = value;
    if (!hasFilter) filter_model = new filter_Model();
    filter_model.searchContent = searchContent;
    if (isTag)
      filter_model.tagTimKiem = value;
  }

  @action
  Future getPosts(bool isLoadMore) async {
    if (!isLoadMore){
      skipCount = 0;
    }
    else
      skipCount += Preferences.skipIndex;
    final future = _repository.getPosts(skipCount, Preferences.maxCount, filter_model);
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
  // Future searchPosts() async {
  //
  //   final futrue = _repository.searchPosts(filter_model);
  //   fetchisBaiGhimYeuThichFuture = ObservableFuture(futrue);
  //
  //   futrue.then((result) {
  //     this.postList = result;
  //   }).catchError((error){
  //     if (error is DioError) {
  //       if (error.response.data!=null)
  //         errorStore.errorMessage = error.response.data["error"]["message"];
  //       else
  //         errorStore.errorMessage = DioErrorUtil.handleError(error);
  //       throw error;
  //     }
  //     else{
  //       throw error;
  //     }
  //   });
  // }

  @action
  Future getRecommendPosts(String tag, bool isSearchInHome) async {

    final futrue = _repository.getPosts(0,3,new filter_Model(tagTimKiem: tag));
    fetchisGetRecommendPostsFuture = ObservableFuture(futrue);
    filter_model.tagTimKiem = tag;
    futrue.then((result) {
      if(!isSearchInHome)
        this.rcmPostList = result;
      else {
        this.postList = result;
        skipCount=3;
      }
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
  void validateSearchContent(String value) {
      return;
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
    ////////////////edit
  static ObservableFuture<String> emptyeditostResponse =
  ObservableFuture.value(null);

  @observable
  ObservableFuture<String> fetcheditpostsFuture =
  ObservableFuture<String>(emptyeditostResponse);

  @observable
  bool successeditpost = false;

  @computed
  bool get loadingeditpost => fetcheditpostsFuture.status == FutureStatus.pending;
  Future editpost(Newpost post) async {
    final editpostFuture = _repository.editpost(post);
    fetchNewpostsFuture = ObservableFuture(editpostFuture);
    editpostFuture.then((newpost) {
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
    ///////////////////////////getpostforcur
  static ObservableFuture<PostList> emptyPostforcursResponse =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<PostList> fetchPostForCursFuture = ObservableFuture<PostList>(emptyPostforcursResponse);
  @observable
  PostList postForCurList;
  @computed
  bool get loadingPostForCur => fetchPostForCursFuture.status == FutureStatus.pending;
  @observable
  bool successPostForCur = false;
  @observable
  Future getPostForCurs() async {
    final future = _repository.getPostsforcur();
    fetchPostForCursFuture = ObservableFuture(future);
    future.then((postList) {
      successPostForCur = true;
      this.postForCurList = postList;
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
  /////////////////delete
  static ObservableFuture<String> emptydeleteResponse =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<String> fetchdeleteFuture = ObservableFuture<String>(emptydeleteResponse);
  //postForCurList;
  @computed
  bool get Deletepost => fetchdeleteFuture.status == FutureStatus.pending;
  @observable
  bool successdelete = false;
  @observable
  Future Delete(Post post) async {
    final future = _repository.Delete(post);
    fetchdeleteFuture = ObservableFuture(future);
    future.then((post) {
      successdelete = true;
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
  /////////////////giahan
  static ObservableFuture<String> emptygiahanResponse =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<String> fetchgiahanFuture = ObservableFuture<String>(emptygiahanResponse);
  //@observable
  //postForCurList;
  @computed
  bool get giahanpost => fetchgiahanFuture.status == FutureStatus.pending;
  @observable
  bool successgiahan = false;
  @observable
  Future giahan(Newpost post) async {
    final future = _repository.giahan(post);
    fetchgiahanFuture = ObservableFuture(future);
    future.then((post) {
      successgiahan = true;
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
  /////////////////getpackprice
  static ObservableFuture<double> emptypackpriceResponse =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<double> fetchgetpackpriceFuture = ObservableFuture<double>(emptypackpriceResponse);
  //@observable
  //postForCurList;
  @computed
  bool get getpackpricepost => fetchgiahanFuture.status == FutureStatus.pending;
  @observable
  bool successgetpackprice = false;
  @observable
  Future<double> getpackprice(int idpack) async {
    final future = _repository.getpackprice(idpack);
    fetchgetpackpriceFuture = ObservableFuture(future);
    future.then((giagoi) {
      successdelete = true;
      return giagoi;
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
