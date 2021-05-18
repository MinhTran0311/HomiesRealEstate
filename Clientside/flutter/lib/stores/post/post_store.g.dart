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

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchPropertiesFuture: ${fetchPropertiesFuture},
postList: ${postList},
isIntialLoading: ${isIntialLoading},
skipCount: ${skipCount},
maxCount: ${maxCount},
propertyList: ${propertyList},
imageUrlList: ${imageUrlList},
success: ${success},
propertiesSuccess: ${propertiesSuccess},
loading: ${loading},
propertiesLoading: ${propertiesLoading}
    ''';
  }
}
