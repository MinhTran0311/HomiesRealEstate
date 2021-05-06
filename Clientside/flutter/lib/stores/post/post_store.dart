import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/repository.dart';
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

  // constructor:---------------------------------------------------------------
  _PostStore(Repository repository) : this._repository = repository;

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


  @observable
  PostList postList;

  @observable
  PropertyList propertyList;

  @observable
  List<String> imageUrlList;

  @observable
  bool success = false;

  @observable
  bool propertiesSuccess = false;

  @computed
  bool get loading => fetchPostsFuture.status == FutureStatus.pending;

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
}
