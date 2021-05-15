import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/stores/error/error_store.dart';
import 'package:boilerplate/utils/dio/dio_error_util.dart';
import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

part 'image_store.g.dart';

class ImageStore = _ImageStore with _$ImageStore;

abstract class _ImageStore with Store {
  // repository instance
  Repository _repository;

  // store for handling errors
  final ErrorStore errorStore = ErrorStore();

  // constructor:---------------------------------------------------------------
  _ImageStore(Repository repository) : this._repository = repository;

  // store variables:-----------------------------------------------------------

  // Image observer
  static ObservableFuture<ImageList> emptyImageResponse =
  ObservableFuture.value(null);
  static ObservableFuture<String> emptyStringResponse =
  ObservableFuture.value(null);
  @observable
  ObservableFuture<ImageList> fetchImageFuture = ObservableFuture<ImageList>(emptyImageResponse);
  ObservableFuture<String> fetchImageFuturepost = ObservableFuture<String>(emptyStringResponse);


  @observable
  ImageList imageList;
  List <String> imageListpost=new List<String>();

  @observable
  bool success = false;

  @observable
  int selectedIndex = 0;

  @computed
  bool get imageLoading => fetchImageFuture.status == FutureStatus.pending;
  @computed
  bool get imageLoadingpost => fetchImageFuturepost.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future getImagesForDetail(String postId) async {
    success = false;
    final future = _repository.getImagesForDetail(postId);
    fetchImageFuture = ObservableFuture(future);
    future.then((imageList) {
      success = true;
      this.imageList = imageList;
    }).catchError((error) {
      success = false;
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
  Future postImages(List<String> path, String name) async {
    {
      imageListpost=new List<String>();
      for(var item in path)
        {
      final imageFuture = _repository.postImageToImageBB(item,"$name ${item}");
      imageFuture.then((imgId) {
        imageListpost.add(imgId);
      if(item==path.last)
        fetchImageFuturepost = ObservableFuture(imageFuture);
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
  }}
}