// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PostStore.loading'))
      .value;
  Computed<bool> _$propertiesLoadingComputed;

  @override
  bool get propertiesLoading => (_$propertiesLoadingComputed ??= Computed<bool>(
          () => super.propertiesLoading,
          name: '_PostStore.propertiesLoading'))
      .value;
  Computed<bool> _$isBaiGhimYeuThichLoadingComputed;

  @override
  bool get isBaiGhimYeuThichLoading => (_$isBaiGhimYeuThichLoadingComputed ??=
          Computed<bool>(() => super.isBaiGhimYeuThichLoading,
              name: '_PostStore.isBaiGhimYeuThichLoading'))
      .value;

  final _$fetchPostsFutureAtom = Atom(name: '_PostStore.fetchPostsFuture');

  @override
  ObservableFuture<PostList> get fetchPostsFuture {
    _$fetchPostsFutureAtom.reportRead();
    return super.fetchPostsFuture;
  }

  @override
  set fetchPostsFuture(ObservableFuture<PostList> value) {
    _$fetchPostsFutureAtom.reportWrite(value, super.fetchPostsFuture, () {
      super.fetchPostsFuture = value;
    });
  }

  final _$fetchPropertiesFutureAtom =
      Atom(name: '_PostStore.fetchPropertiesFuture');

  @override
  ObservableFuture<PropertyList> get fetchPropertiesFuture {
    _$fetchPropertiesFutureAtom.reportRead();
    return super.fetchPropertiesFuture;
  }

  @override
  set fetchPropertiesFuture(ObservableFuture<PropertyList> value) {
    _$fetchPropertiesFutureAtom.reportWrite(value, super.fetchPropertiesFuture,
        () {
      super.fetchPropertiesFuture = value;
    });
  }

  final _$fetchisBaiGhimYeuThichFutureAtom =
      Atom(name: '_PostStore.fetchisBaiGhimYeuThichFuture');

  @override
  ObservableFuture<dynamic> get fetchisBaiGhimYeuThichFuture {
    _$fetchisBaiGhimYeuThichFutureAtom.reportRead();
    return super.fetchisBaiGhimYeuThichFuture;
  }

  @override
  set fetchisBaiGhimYeuThichFuture(ObservableFuture<dynamic> value) {
    _$fetchisBaiGhimYeuThichFutureAtom
        .reportWrite(value, super.fetchisBaiGhimYeuThichFuture, () {
      super.fetchisBaiGhimYeuThichFuture = value;
    });
  }

  final _$postListAtom = Atom(name: '_PostStore.postList');

  @override
  PostList get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }

  @override
  set postList(PostList value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }

  final _$propertyListAtom = Atom(name: '_PostStore.propertyList');

  @override
  PropertyList get propertyList {
    _$propertyListAtom.reportRead();
    return super.propertyList;
  }

  @override
  set propertyList(PropertyList value) {
    _$propertyListAtom.reportWrite(value, super.propertyList, () {
      super.propertyList = value;
    });
  }

  final _$imageUrlListAtom = Atom(name: '_PostStore.imageUrlList');

  @override
  List<String> get imageUrlList {
    _$imageUrlListAtom.reportRead();
    return super.imageUrlList;
  }

  @override
  set imageUrlList(List<String> value) {
    _$imageUrlListAtom.reportWrite(value, super.imageUrlList, () {
      super.imageUrlList = value;
    });
  }

  final _$successAtom = Atom(name: '_PostStore.success');

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

  final _$propertiesSuccessAtom = Atom(name: '_PostStore.propertiesSuccess');

  @override
  bool get propertiesSuccess {
    _$propertiesSuccessAtom.reportRead();
    return super.propertiesSuccess;
  }

  @override
  set propertiesSuccess(bool value) {
    _$propertiesSuccessAtom.reportWrite(value, super.propertiesSuccess, () {
      super.propertiesSuccess = value;
    });
  }

  final _$isBaiGhimYeuThichAtom = Atom(name: '_PostStore.isBaiGhimYeuThich');

  @override
  bool get isBaiGhimYeuThich {
    _$isBaiGhimYeuThichAtom.reportRead();
    return super.isBaiGhimYeuThich;
  }

  @override
  set isBaiGhimYeuThich(bool value) {
    _$isBaiGhimYeuThichAtom.reportWrite(value, super.isBaiGhimYeuThich, () {
      super.isBaiGhimYeuThich = value;
    });
  }

  final _$getPostsAsyncAction = AsyncAction('_PostStore.getPosts');

  @override
  Future<dynamic> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }

  final _$getPostPropertiesAsyncAction =
      AsyncAction('_PostStore.getPostProperties');

  @override
  Future<dynamic> getPostProperties(String postId) {
    return _$getPostPropertiesAsyncAction
        .run(() => super.getPostProperties(postId));
  }

  final _$isBaiGhimYeuThichOrNotAsyncAction =
      AsyncAction('_PostStore.isBaiGhimYeuThichOrNot');

  @override
  Future<dynamic> isBaiGhimYeuThichOrNot(String postId) {
    return _$isBaiGhimYeuThichOrNotAsyncAction
        .run(() => super.isBaiGhimYeuThichOrNot(postId));
  }

  final _$createOrChangeStatusBaiGhimYeuThichAsyncAction =
      AsyncAction('_PostStore.createOrChangeStatusBaiGhimYeuThich');

  @override
  Future<dynamic> createOrChangeStatusBaiGhimYeuThich(String postId) {
    return _$createOrChangeStatusBaiGhimYeuThichAsyncAction
        .run(() => super.createOrChangeStatusBaiGhimYeuThich(postId));
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchPropertiesFuture: ${fetchPropertiesFuture},
fetchisBaiGhimYeuThichFuture: ${fetchisBaiGhimYeuThichFuture},
postList: ${postList},
propertyList: ${propertyList},
imageUrlList: ${imageUrlList},
success: ${success},
propertiesSuccess: ${propertiesSuccess},
isBaiGhimYeuThich: ${isBaiGhimYeuThich},
loading: ${loading},
propertiesLoading: ${propertiesLoading},
isBaiGhimYeuThichLoading: ${isBaiGhimYeuThichLoading}
    ''';
  }
}
