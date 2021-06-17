// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MapsStore on _MapsStore, Store {
  Computed<bool> _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_MapsStore.loading'))
      .value;

  final _$isLocationServiceEnabledAtom =
      Atom(name: '_MapsStore.isLocationServiceEnabled');

  @override
  bool get isLocationServiceEnabled {
    _$isLocationServiceEnabledAtom.reportRead();
    return super.isLocationServiceEnabled;
  }

  @override
  set isLocationServiceEnabled(bool value) {
    _$isLocationServiceEnabledAtom
        .reportWrite(value, super.isLocationServiceEnabled, () {
      super.isLocationServiceEnabled = value;
    });
  }

  final _$positionCurrentAtom = Atom(name: '_MapsStore.positionCurrent');

  @override
  Position get positionCurrent {
    _$positionCurrentAtom.reportRead();
    return super.positionCurrent;
  }

  @override
  set positionCurrent(Position value) {
    _$positionCurrentAtom.reportWrite(value, super.positionCurrent, () {
      super.positionCurrent = value;
    });
  }

  final _$postListAllAtom = Atom(name: '_MapsStore.postListAll');

  @override
  PostList get postListAll {
    _$postListAllAtom.reportRead();
    return super.postListAll;
  }

  @override
  set postListAll(PostList value) {
    _$postListAllAtom.reportWrite(value, super.postListAll, () {
      super.postListAll = value;
    });
  }

  final _$cameraPositionCurrentAtom =
      Atom(name: '_MapsStore.cameraPositionCurrent');

  @override
  CameraPosition get cameraPositionCurrent {
    _$cameraPositionCurrentAtom.reportRead();
    return super.cameraPositionCurrent;
  }

  @override
  set cameraPositionCurrent(CameraPosition value) {
    _$cameraPositionCurrentAtom.reportWrite(value, super.cameraPositionCurrent,
        () {
      super.cameraPositionCurrent = value;
    });
  }

  final _$fetchPostsFutureAtom = Atom(name: '_MapsStore.fetchPostsFuture');

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

  final _$checkPermissionAsyncAction =
      AsyncAction('_MapsStore.checkPermission');

  @override
  Future<dynamic> checkPermission() {
    return _$checkPermissionAsyncAction.run(() => super.checkPermission());
  }

  final _$getAllPostsAsyncAction = AsyncAction('_MapsStore.getAllPosts');

  @override
  Future<dynamic> getAllPosts() {
    return _$getAllPostsAsyncAction.run(() => super.getAllPosts());
  }

  @override
  String toString() {
    return '''
isLocationServiceEnabled: ${isLocationServiceEnabled},
positionCurrent: ${positionCurrent},
postListAll: ${postListAll},
cameraPositionCurrent: ${cameraPositionCurrent},
fetchPostsFuture: ${fetchPostsFuture},
loading: ${loading}
    ''';
  }
}
