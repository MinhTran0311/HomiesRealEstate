import 'package:boilerplate/data/repository.dart';
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

  @observable
  ObservableFuture<ImageList> fetchImageFuture =
  ObservableFuture<ImageList>(emptyImageResponse);


  @observable
  ImageList imageList;

  @observable
  bool success = false;

  @observable
  int selectedIndex = 0;

  @computed
  bool get imageLoading => fetchImageFuture.status == FutureStatus.pending;


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
  Future postImages(String path, bool isThumb) async {

    if (isThumb){
      // lấy đường dẫn đầu tiên
      //getimage
    }
    else{
      final imageFuture = _repository.postImageToImageBB(path);
    //  fetchImageFuturepost = ObservableFuture(imageFuture);

      imageFuture.then((imgId) {
        //await thêm id ảnh vào db
        print(imgId);
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
}