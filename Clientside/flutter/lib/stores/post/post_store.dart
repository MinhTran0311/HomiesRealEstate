import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
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

    static ObservableFuture<dynamic> emptySearchResponse =
    ObservableFuture.value(null);

    @observable
    ObservableFuture<dynamic> fetchSearchFuture =
    ObservableFuture<dynamic>(emptyIsBaiDangYeuThichResponse);

    @observable
    PostList postList;

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


    @computed
    bool get loading => fetchPostsFuture.status == FutureStatus.pending;

    @computed
    bool get propertiesLoading => fetchPropertiesFuture.status == FutureStatus.pending;

    @computed
    bool get isBaiGhimYeuThichLoading => fetchisBaiGhimYeuThichFuture.status == FutureStatus.pending;

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
    Future getPosts() async {
      final future = _repository.getPosts();
      fetchPostsFuture = ObservableFuture(future);

      future.then((postList) {
        success = true;
        this.postList = postList;
        this.postList.posts.add(postList.posts[0]);
        this.postList.posts.add(postList.posts[0]);
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
    Future isBaiGhimYeuThichOrNot(String postId) async {
      isBaiGhimYeuThich = false;
      final futrue = _repository.isBaiGhimYeuThichOrNot(postId);
      fetchisBaiGhimYeuThichFuture = ObservableFuture(futrue);

      futrue.then((result) {
        if (result["result"]["exist"]) {
          isBaiGhimYeuThich = true;
          print("heyyy");
          print(result["result"]["exist"].toString());
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
  void validateSearchContent(String value) {
      return;
  }
}

