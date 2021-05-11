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
  Computed<bool> _$loadinggetcategorysComputed;

  @override
  bool get loadinggetcategorys => (_$loadinggetcategorysComputed ??=
          Computed<bool>(() => super.loadinggetcategorys,
              name: '_PostStore.loadinggetcategorys'))
      .value;
  Computed<bool> _$propertiesLoadingComputed;

  @override
  bool get propertiesLoading => (_$propertiesLoadingComputed ??= Computed<bool>(
          () => super.propertiesLoading,
          name: '_PostStore.propertiesLoading'))
      .value;
  Computed<bool> _$loadingPackComputed;

  @override
  bool get loadingPack =>
      (_$loadingPackComputed ??= Computed<bool>(() => super.loadingPack,
              name: '_PostStore.loadingPack'))
          .value;
  Computed<bool> _$loadingThuocTinhComputed;

  @override
  bool get loadingThuocTinh => (_$loadingThuocTinhComputed ??= Computed<bool>(
          () => super.loadingThuocTinh,
          name: '_PostStore.loadingThuocTinh'))
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

  final _$fetchPostCategorysFutureAtom =
      Atom(name: '_PostStore.fetchPostCategorysFuture');

  @override
  ObservableFuture<PostCategoryList> get fetchPostCategorysFuture {
    _$fetchPostCategorysFutureAtom.reportRead();
    return super.fetchPostCategorysFuture;
  }

  @override
  set fetchPostCategorysFuture(ObservableFuture<PostCategoryList> value) {
    _$fetchPostCategorysFutureAtom
        .reportWrite(value, super.fetchPostCategorysFuture, () {
      super.fetchPostCategorysFuture = value;
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

  final _$postCategoryListAtom = Atom(name: '_PostStore.postCategoryList');

  @override
  PostCategoryList get postCategoryList {
    _$postCategoryListAtom.reportRead();
    return super.postCategoryList;
  }

  @override
  set postCategoryList(PostCategoryList value) {
    _$postCategoryListAtom.reportWrite(value, super.postCategoryList, () {
      super.postCategoryList = value;
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

  final _$successgetcategorysAtom =
      Atom(name: '_PostStore.successgetcategorys');

  @override
  bool get successgetcategorys {
    _$successgetcategorysAtom.reportRead();
    return super.successgetcategorys;
  }

  @override
  set successgetcategorys(bool value) {
    _$successgetcategorysAtom.reportWrite(value, super.successgetcategorys, () {
      super.successgetcategorys = value;
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

  final _$fetchPacksFutureAtom = Atom(name: '_PostStore.fetchPacksFuture');

  @override
  ObservableFuture<PackList> get fetchPacksFuture {
    _$fetchPacksFutureAtom.reportRead();
    return super.fetchPacksFuture;
  }

  @override
  set fetchPacksFuture(ObservableFuture<PackList> value) {
    _$fetchPacksFutureAtom.reportWrite(value, super.fetchPacksFuture, () {
      super.fetchPacksFuture = value;
    });
  }

  final _$packListAtom = Atom(name: '_PostStore.packList');

  @override
  PackList get packList {
    _$packListAtom.reportRead();
    return super.packList;
  }

  @override
  set packList(PackList value) {
    _$packListAtom.reportWrite(value, super.packList, () {
      super.packList = value;
    });
  }

  final _$successPackAtom = Atom(name: '_PostStore.successPack');

  @override
  bool get successPack {
    _$successPackAtom.reportRead();
    return super.successPack;
  }

  @override
  set successPack(bool value) {
    _$successPackAtom.reportWrite(value, super.successPack, () {
      super.successPack = value;
    });
  }

  final _$fetchThuocTinhsFutureAtom =
      Atom(name: '_PostStore.fetchThuocTinhsFuture');

  @override
  ObservableFuture<ThuocTinhList> get fetchThuocTinhsFuture {
    _$fetchThuocTinhsFutureAtom.reportRead();
    return super.fetchThuocTinhsFuture;
  }

  @override
  set fetchThuocTinhsFuture(ObservableFuture<ThuocTinhList> value) {
    _$fetchThuocTinhsFutureAtom.reportWrite(value, super.fetchThuocTinhsFuture,
        () {
      super.fetchThuocTinhsFuture = value;
    });
  }

  final _$thuocTinhListAtom = Atom(name: '_PostStore.thuocTinhList');

  @override
  ThuocTinhList get thuocTinhList {
    _$thuocTinhListAtom.reportRead();
    return super.thuocTinhList;
  }

  @override
  set thuocTinhList(ThuocTinhList value) {
    _$thuocTinhListAtom.reportWrite(value, super.thuocTinhList, () {
      super.thuocTinhList = value;
    });
  }

  final _$successThuocTinhAtom = Atom(name: '_PostStore.successThuocTinh');

  @override
  bool get successThuocTinh {
    _$successThuocTinhAtom.reportRead();
    return super.successThuocTinh;
  }

  @override
  set successThuocTinh(bool value) {
    _$successThuocTinhAtom.reportWrite(value, super.successThuocTinh, () {
      super.successThuocTinh = value;
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

  final _$getPostcategorysAsyncAction =
      AsyncAction('_PostStore.getPostcategorys');

  @override
  Future<dynamic> getPostcategorys() {
    return _$getPostcategorysAsyncAction.run(() => super.getPostcategorys());
  }

  final _$getPacksAsyncAction = AsyncAction('_PostStore.getPacks');

  @override
  Future<dynamic> getPacks() {
    return _$getPacksAsyncAction.run(() => super.getPacks());
  }

  final _$getThuocTinhsAsyncAction = AsyncAction('_PostStore.getThuocTinhs');

  @override
  Future<dynamic> getThuocTinhs() {
    return _$getThuocTinhsAsyncAction.run(() => super.getThuocTinhs());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchPostCategorysFuture: ${fetchPostCategorysFuture},
fetchPropertiesFuture: ${fetchPropertiesFuture},
postList: ${postList},
postCategoryList: ${postCategoryList},
propertyList: ${propertyList},
imageUrlList: ${imageUrlList},
success: ${success},
successgetcategorys: ${successgetcategorys},
propertiesSuccess: ${propertiesSuccess},
fetchPacksFuture: ${fetchPacksFuture},
packList: ${packList},
successPack: ${successPack},
fetchThuocTinhsFuture: ${fetchThuocTinhsFuture},
thuocTinhList: ${thuocTinhList},
successThuocTinh: ${successThuocTinh},
loading: ${loading},
loadinggetcategorys: ${loadinggetcategorys},
propertiesLoading: ${propertiesLoading},
loadingPack: ${loadingPack},
loadingThuocTinh: ${loadingThuocTinh}
    ''';
  }
}
