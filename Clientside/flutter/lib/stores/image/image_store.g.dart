// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ImageStore on _ImageStore, Store {
  Computed<bool> _$imageLoadingComputed;

  @override
  bool get imageLoading =>
      (_$imageLoadingComputed ??= Computed<bool>(() => super.imageLoading,
              name: '_ImageStore.imageLoading'))
          .value;

  final _$fetchImageFutureAtom = Atom(name: '_ImageStore.fetchImageFuture');

  @override
  ObservableFuture<ImageList> get fetchImageFuture {
    _$fetchImageFutureAtom.reportRead();
    return super.fetchImageFuture;
  }

  @override
  set fetchImageFuture(ObservableFuture<ImageList> value) {
    _$fetchImageFutureAtom.reportWrite(value, super.fetchImageFuture, () {
      super.fetchImageFuture = value;
    });
  }

  final _$imageListAtom = Atom(name: '_ImageStore.imageList');

  @override
  ImageList get imageList {
    _$imageListAtom.reportRead();
    return super.imageList;
  }

  @override
  set imageList(ImageList value) {
    _$imageListAtom.reportWrite(value, super.imageList, () {
      super.imageList = value;
    });
  }

  final _$successAtom = Atom(name: '_ImageStore.success');

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  final _$selectedIndexAtom = Atom(name: '_ImageStore.selectedIndex');

  @override
  int get selectedIndex {
    _$selectedIndexAtom.reportRead();
    return super.selectedIndex;
  }

  @override
  set selectedIndex(int value) {
    _$selectedIndexAtom.reportWrite(value, super.selectedIndex, () {
      super.selectedIndex = value;
    });
  }

  final _$getImagesForDetailAsyncAction =
      AsyncAction('_ImageStore.getImagesForDetail');

  @override
  Future<dynamic> getImagesForDetail(String postId) {
    return _$getImagesForDetailAsyncAction
        .run(() => super.getImagesForDetail(postId));
  }
  String toString() {
    return '''
fetchImageFuture: ${fetchImageFuture},
imageList: ${imageList},
success: ${success},
selectedIndex: ${selectedIndex},
imageLoading: ${imageLoading}

    ''';
  }
}
