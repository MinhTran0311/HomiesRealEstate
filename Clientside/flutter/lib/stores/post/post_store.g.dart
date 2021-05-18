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
  Computed<bool> _$searchLoadingComputed;

  @override
  bool get searchLoading =>
      (_$searchLoadingComputed ??= Computed<bool>(() => super.searchLoading,
              name: '_PostStore.searchLoading'))
          .value;
  Computed<bool> _$hasFilterComputed;

  @override
  bool get hasFilter => (_$hasFilterComputed ??=
          Computed<bool>(() => super.hasFilter, name: '_PostStore.hasFilter'))
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

  final _$fetchSearchFutureAtom = Atom(name: '_PostStore.fetchSearchFuture');

  @override
  ObservableFuture<dynamic> get fetchSearchFuture {
    _$fetchSearchFutureAtom.reportRead();
    return super.fetchSearchFuture;
  }

  @override
  set fetchSearchFuture(ObservableFuture<dynamic> value) {
    _$fetchSearchFutureAtom.reportWrite(value, super.fetchSearchFuture, () {
      super.fetchSearchFuture = value;
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

  final _$isIntialLoadingAtom = Atom(name: '_PostStore.isIntialLoading');

  @override
  bool get isIntialLoading {
    _$isIntialLoadingAtom.reportRead();
    return super.isIntialLoading;
  }

  @override
  set isIntialLoading(bool value) {
    _$isIntialLoadingAtom.reportWrite(value, super.isIntialLoading, () {
      super.isIntialLoading = value;
    });
  }

  final _$skipCountAtom = Atom(name: '_PostStore.skipCount');

  @override
  int get skipCount {
    _$skipCountAtom.reportRead();
    return super.skipCount;
  }

  @override
  set skipCount(int value) {
    _$skipCountAtom.reportWrite(value, super.skipCount, () {
      super.skipCount = value;
    });
  }

  final _$maxCountAtom = Atom(name: '_PostStore.maxCount');

  @override
  int get maxCount {
    _$maxCountAtom.reportRead();
    return super.maxCount;
  }

  @override
  set maxCount(int value) {
    _$maxCountAtom.reportWrite(value, super.maxCount, () {
      super.maxCount = value;
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

  final _$filter_modelAtom = Atom(name: '_PostStore.filter_model');

  @override
  filter_Model get filter_model {
    _$filter_modelAtom.reportRead();
    return super.filter_model;
  }

  @override
  set filter_model(filter_Model value) {
    _$filter_modelAtom.reportWrite(value, super.filter_model, () {
      super.filter_model = value;
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

  final _$searchContentAtom = Atom(name: '_PostStore.searchContent');

  @override
  String get searchContent {
    _$searchContentAtom.reportRead();
    return super.searchContent;
  }

  @override
  set searchContent(String value) {
    _$searchContentAtom.reportWrite(value, super.searchContent, () {
      super.searchContent = value;
    });
  }

  final _$scrollControllerAtom = Atom(name: '_PostStore.scrollController');

  @override
  ScrollController get scrollController {
    _$scrollControllerAtom.reportRead();
    return super.scrollController;
  }

  @override
  set scrollController(ScrollController value) {
    _$scrollControllerAtom.reportWrite(value, super.scrollController, () {
      super.scrollController = value;
    });
  }

  final _$getPostsAsyncAction = AsyncAction('_PostStore.getPosts');

  @override
  Future<dynamic> getPosts(bool isLoadMore) {
    return _$getPostsAsyncAction.run(() => super.getPosts(isLoadMore));
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

  final _$searchPostsAsyncAction = AsyncAction('_PostStore.searchPosts');

  @override
  Future<dynamic> searchPosts() {
    return _$searchPostsAsyncAction.run(() => super.searchPosts());
  }

  final _$_PostStoreActionController = ActionController(name: '_PostStore');

  @override
  void setSearchContent(String value) {
    final _$actionInfo = _$_PostStoreActionController.startAction(
        name: '_PostStore.setSearchContent');
    try {
      return super.setSearchContent(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateSearchContent(String value) {
    final _$actionInfo = _$_PostStoreActionController.startAction(
        name: '_PostStore.validateSearchContent');
    try {
      return super.validateSearchContent(value);
    } finally {
      _$_PostStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchPropertiesFuture: ${fetchPropertiesFuture},
fetchisBaiGhimYeuThichFuture: ${fetchisBaiGhimYeuThichFuture},
fetchSearchFuture: ${fetchSearchFuture},
postList: ${postList},
isIntialLoading: ${isIntialLoading},
skipCount: ${skipCount},
maxCount: ${maxCount},
propertyList: ${propertyList},
imageUrlList: ${imageUrlList},
filter_model: ${filter_model},
success: ${success},
propertiesSuccess: ${propertiesSuccess},
isBaiGhimYeuThich: ${isBaiGhimYeuThich},
searchContent: ${searchContent},
scrollController: ${scrollController},
loading: ${loading},
propertiesLoading: ${propertiesLoading},
isBaiGhimYeuThichLoading: ${isBaiGhimYeuThichLoading},
searchLoading: ${searchLoading},
hasFilter: ${hasFilter}
    ''';
  }
}
