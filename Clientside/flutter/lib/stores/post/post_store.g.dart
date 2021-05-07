// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PostStore on _PostStore, Store {
  Computed<bool> _$loadingComputed;
  Computed<bool> _$loadingComputed2;
  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_PostStore.loading'))
      .value;
  bool get loadinggetcategorys=> (_$loadingComputed ??=
      Computed<bool>(() => super.loadinggetcategorys, name: '_PostStore.loadinggetcategorys'))
      .value;
  final _$fetchPostsFutureAtom = Atom(name: '_PostStore.fetchPostsFuture');
  final _$fetchPostCategorysFutureAtom = Atom(name: '_PostStore.fetchPostCategorysFuture');

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
  @override
  ObservableFuture<PostCategoryList> get fetchPostCategorysFuture {
    _$fetchPostCategorysFutureAtom.reportRead();
    return super.fetchPostCategorysFuture;
  }

  @override
  set fetchPostcategorysFuture(ObservableFuture<PostCategoryList> value) {
    _$fetchPostCategorysFutureAtom.reportWrite(value, super.fetchPostCategorysFuture, () {
      super.fetchPostCategorysFuture = value;
    });
  }
  final _$postcategoryListAtom = Atom(name: '_PostStore.postcategoryList');

  final _$postListAtom = Atom(name: '_PostStore.postList');

  @override
  PostList get postList {
    _$postListAtom.reportRead();
    return super.postList;
  }
  @override
  PostCategoryList get postcategoryList {
    _$postcategoryListAtom.reportRead();
    return super.postCategoryList;
  }

  @override
  set postList(PostList value) {
    _$postListAtom.reportWrite(value, super.postList, () {
      super.postList = value;
    });
  }
  set postcategoryList(PostCategoryList value) {
    _$postcategoryListAtom.reportWrite(value, super.postCategoryList, () {
      super.postCategoryList = value;
    });
  }

  final _$successAtom = Atom(name: '_PostStore.success');
  final _$successgetgategorysAtom = Atom(name: '_PostStore.successgetgategorysAtom');
  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }
  @override

  bool get successgetcategorys {
    _$successgetgategorysAtom.reportRead();
    return super.successgetcategorys;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }
  @override

  set successgetcategorys(bool value) {
    _$successgetgategorysAtom.reportWrite(value, super.successgetcategorys, () {
      super.successgetcategorys = value;
    });
  }
  final _$getPostsAsyncAction = AsyncAction('_PostStore.getPosts');
  final _$getPostcategorysAsyncAction = AsyncAction('_PostStore.getPostcategorys');

  @override
  Future<dynamic> getPosts() {
    return _$getPostsAsyncAction.run(() => super.getPosts());
  }
  @override
  Future<dynamic> getPostcategorys() {
    return _$getPostcategorysAsyncAction.run(() => super.getPostcategorys());
  }

  @override
  String toString() {
    return '''
fetchPostsFuture: ${fetchPostsFuture},
fetchPostCategorysFuture: ${fetchPostCategorysFuture},
postList: ${postList},
postCategoryList: ${postCategoryList},
success: ${success},
successcategorys:${successgetcategorys},
loading: ${loading},
loadingcategorys: ${loadinggetcategorys},
    ''';
  }
}
