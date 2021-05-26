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
  Computed<bool> _$getRecommendPostsFutureLoadingComputed;

  @override
  bool get getRecommendPostsFutureLoading =>
      (_$getRecommendPostsFutureLoadingComputed ??= Computed<bool>(
              () => super.getRecommendPostsFutureLoading,
              name: '_PostStore.getRecommendPostsFutureLoading'))
          .value;
  Computed<bool> _$searchLoadingComputed;

  @override
  bool get searchLoading =>
      (_$searchLoadingComputed ??= Computed<bool>(() => super.searchLoading,
              name: '_PostStore.searchLoading'))
          .value;
  Computed<bool> _$loadinggetcategorysComputed;

  @override
  bool get loadinggetcategorys => (_$loadinggetcategorysComputed ??=
          Computed<bool>(() => super.loadinggetcategorys,
              name: '_PostStore.loadinggetcategorys'))
      .value;
  Computed<bool> _$hasFilterComputed;

  @override
  bool get hasFilter => (_$hasFilterComputed ??=
          Computed<bool>(() => super.hasFilter, name: '_PostStore.hasFilter'))
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
  Computed<bool> _$loadingNewpostComputed;

  @override
  bool get loadingNewpost =>
      (_$loadingNewpostComputed ??= Computed<bool>(() => super.loadingNewpost,
              name: '_PostStore.loadingNewpost'))
          .value;
  Computed<bool> _$loadingeditpostComputed;

  @override
  bool get loadingeditpost =>
      (_$loadingeditpostComputed ??= Computed<bool>(() => super.loadingeditpost,
              name: '_PostStore.loadingeditpost'))
          .value;
  Computed<bool> _$loadingPostForCurComputed;

  @override
  bool get loadingPostForCur => (_$loadingPostForCurComputed ??= Computed<bool>(
          () => super.loadingPostForCur,
          name: '_PostStore.loadingPostForCur'))
      .value;
  Computed<bool> _$DeletepostComputed;

  @override
  bool get Deletepost => (_$DeletepostComputed ??=
          Computed<bool>(() => super.Deletepost, name: '_PostStore.Deletepost'))
      .value;
  Computed<bool> _$giahanpostComputed;

  @override
  bool get giahanpost => (_$giahanpostComputed ??=
          Computed<bool>(() => super.giahanpost, name: '_PostStore.giahanpost'))
      .value;
  Computed<bool> _$getpackpricepostComputed;

  @override
  bool get getpackpricepost => (_$getpackpricepostComputed ??= Computed<bool>(
          () => super.getpackpricepost,
          name: '_PostStore.getpackpricepost'))
      .value;
  Computed<bool> _$loadingfavopostComputed;

  @override
  bool get loadingfavopost =>
      (_$loadingfavopostComputed ??= Computed<bool>(() => super.loadingfavopost,
              name: '_PostStore.loadingfavopost'))
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

  final _$fetchisGetRecommendPostsFutureAtom =
      Atom(name: '_PostStore.fetchisGetRecommendPostsFuture');

  @override
  ObservableFuture<dynamic> get fetchisGetRecommendPostsFuture {
    _$fetchisGetRecommendPostsFutureAtom.reportRead();
    return super.fetchisGetRecommendPostsFuture;
  }

  @override
  set fetchisGetRecommendPostsFuture(ObservableFuture<dynamic> value) {
    _$fetchisGetRecommendPostsFutureAtom
        .reportWrite(value, super.fetchisGetRecommendPostsFuture, () {
      super.fetchisGetRecommendPostsFuture = value;
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

  final _$rcmPostListAtom = Atom(name: '_PostStore.rcmPostList');

  @override
  PostList get rcmPostList {
    _$rcmPostListAtom.reportRead();
    return super.rcmPostList;
  }

  @override
  set rcmPostList(PostList value) {
    _$rcmPostListAtom.reportWrite(value, super.rcmPostList, () {
      super.rcmPostList = value;
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

  final _$fetchNewpostsFutureAtom =
      Atom(name: '_PostStore.fetchNewpostsFuture');

  @override
  ObservableFuture<String> get fetchNewpostsFuture {
    _$fetchNewpostsFutureAtom.reportRead();
    return super.fetchNewpostsFuture;
  }

  @override
  set fetchNewpostsFuture(ObservableFuture<String> value) {
    _$fetchNewpostsFutureAtom.reportWrite(value, super.fetchNewpostsFuture, () {
      super.fetchNewpostsFuture = value;
    });
  }

  final _$successNewpostAtom = Atom(name: '_PostStore.successNewpost');

  @override
  bool get successNewpost {
    _$successNewpostAtom.reportRead();
    return super.successNewpost;
  }

  @override
  set successNewpost(bool value) {
    _$successNewpostAtom.reportWrite(value, super.successNewpost, () {
      super.successNewpost = value;
    });
  }

  final _$fetcheditpostsFutureAtom =
      Atom(name: '_PostStore.fetcheditpostsFuture');

  @override
  ObservableFuture<String> get fetcheditpostsFuture {
    _$fetcheditpostsFutureAtom.reportRead();
    return super.fetcheditpostsFuture;
  }

  @override
  set fetcheditpostsFuture(ObservableFuture<String> value) {
    _$fetcheditpostsFutureAtom.reportWrite(value, super.fetcheditpostsFuture,
        () {
      super.fetcheditpostsFuture = value;
    });
  }

  final _$successeditpostAtom = Atom(name: '_PostStore.successeditpost');

  @override
  bool get successeditpost {
    _$successeditpostAtom.reportRead();
    return super.successeditpost;
  }

  @override
  set successeditpost(bool value) {
    _$successeditpostAtom.reportWrite(value, super.successeditpost, () {
      super.successeditpost = value;
    });
  }

  final _$isIntialLoadingpostforcurAtom =
      Atom(name: '_PostStore.isIntialLoadingpostforcur');

  @override
  bool get isIntialLoadingpostforcur {
    _$isIntialLoadingpostforcurAtom.reportRead();
    return super.isIntialLoadingpostforcur;
  }

  @override
  set isIntialLoadingpostforcur(bool value) {
    _$isIntialLoadingpostforcurAtom
        .reportWrite(value, super.isIntialLoadingpostforcur, () {
      super.isIntialLoadingpostforcur = value;
    });
  }

  final _$fetchPostForCursFutureAtom =
      Atom(name: '_PostStore.fetchPostForCursFuture');

  @override
  ObservableFuture<PostList> get fetchPostForCursFuture {
    _$fetchPostForCursFutureAtom.reportRead();
    return super.fetchPostForCursFuture;
  }

  @override
  set fetchPostForCursFuture(ObservableFuture<PostList> value) {
    _$fetchPostForCursFutureAtom
        .reportWrite(value, super.fetchPostForCursFuture, () {
      super.fetchPostForCursFuture = value;
    });
  }

  final _$postForCurListAtom = Atom(name: '_PostStore.postForCurList');

  @override
  PostList get postForCurList {
    _$postForCurListAtom.reportRead();
    return super.postForCurList;
  }

  @override
  set postForCurList(PostList value) {
    _$postForCurListAtom.reportWrite(value, super.postForCurList, () {
      super.postForCurList = value;
    });
  }

  final _$successPostForCurAtom = Atom(name: '_PostStore.successPostForCur');

  @override
  bool get successPostForCur {
    _$successPostForCurAtom.reportRead();
    return super.successPostForCur;
  }

  @override
  set successPostForCur(bool value) {
    _$successPostForCurAtom.reportWrite(value, super.successPostForCur, () {
      super.successPostForCur = value;
    });
  }

  final _$fetchdeleteFutureAtom = Atom(name: '_PostStore.fetchdeleteFuture');

  @override
  ObservableFuture<String> get fetchdeleteFuture {
    _$fetchdeleteFutureAtom.reportRead();
    return super.fetchdeleteFuture;
  }

  @override
  set fetchdeleteFuture(ObservableFuture<String> value) {
    _$fetchdeleteFutureAtom.reportWrite(value, super.fetchdeleteFuture, () {
      super.fetchdeleteFuture = value;
    });
  }

  final _$successdeleteAtom = Atom(name: '_PostStore.successdelete');

  @override
  bool get successdelete {
    _$successdeleteAtom.reportRead();
    return super.successdelete;
  }

  @override
  set successdelete(bool value) {
    _$successdeleteAtom.reportWrite(value, super.successdelete, () {
      super.successdelete = value;
    });
  }

  final _$fetchgiahanFutureAtom = Atom(name: '_PostStore.fetchgiahanFuture');

  @override
  ObservableFuture<String> get fetchgiahanFuture {
    _$fetchgiahanFutureAtom.reportRead();
    return super.fetchgiahanFuture;
  }

  @override
  set fetchgiahanFuture(ObservableFuture<String> value) {
    _$fetchgiahanFutureAtom.reportWrite(value, super.fetchgiahanFuture, () {
      super.fetchgiahanFuture = value;
    });
  }

  final _$successgiahanAtom = Atom(name: '_PostStore.successgiahan');

  @override
  bool get successgiahan {
    _$successgiahanAtom.reportRead();
    return super.successgiahan;
  }

  @override
  set successgiahan(bool value) {
    _$successgiahanAtom.reportWrite(value, super.successgiahan, () {
      super.successgiahan = value;
    });
  }

  final _$fetchgetpackpriceFutureAtom =
      Atom(name: '_PostStore.fetchgetpackpriceFuture');

  @override
  ObservableFuture<double> get fetchgetpackpriceFuture {
    _$fetchgetpackpriceFutureAtom.reportRead();
    return super.fetchgetpackpriceFuture;
  }

  @override
  set fetchgetpackpriceFuture(ObservableFuture<double> value) {
    _$fetchgetpackpriceFutureAtom
        .reportWrite(value, super.fetchgetpackpriceFuture, () {
      super.fetchgetpackpriceFuture = value;
    });
  }

  final _$successgetpackpriceAtom =
      Atom(name: '_PostStore.successgetpackprice');

  @override
  bool get successgetpackprice {
    _$successgetpackpriceAtom.reportRead();
    return super.successgetpackprice;
  }

  @override
  set successgetpackprice(bool value) {
    _$successgetpackpriceAtom.reportWrite(value, super.successgetpackprice, () {
      super.successgetpackprice = value;
    });
  }

  final _$fetchpostfavoFutureAtom =
      Atom(name: '_PostStore.fetchpostfavoFuture');

  @override
  ObservableFuture<PostList> get fetchpostfavoFuture {
    _$fetchpostfavoFutureAtom.reportRead();
    return super.fetchpostfavoFuture;
  }

  @override
  set fetchpostfavoFuture(ObservableFuture<PostList> value) {
    _$fetchpostfavoFutureAtom.reportWrite(value, super.fetchpostfavoFuture, () {
      super.fetchpostfavoFuture = value;
    });
  }

  final _$favopostAtom = Atom(name: '_PostStore.favopost');

  @override
  PostList get favopost {
    _$favopostAtom.reportRead();
    return super.favopost;
  }

  @override
  set favopost(PostList value) {
    _$favopostAtom.reportWrite(value, super.favopost, () {
      super.favopost = value;
    });
  }

  final _$successfavopostAtom = Atom(name: '_PostStore.successfavopost');

  @override
  bool get successfavopost {
    _$successfavopostAtom.reportRead();
    return super.successfavopost;
  }

  @override
  set successfavopost(bool value) {
    _$successfavopostAtom.reportWrite(value, super.successfavopost, () {
      super.successfavopost = value;
    });
  }

  @override
  ObservableFuture<dynamic> getPostForCurs(bool isLoadMore) {
    final _$future = super.getPostForCurs(isLoadMore);
    return ObservableFuture<dynamic>(_$future);
  }
  ObservableFuture<dynamic> getsobaidang() {
    final _$future = super.getsobaidang();
    return ObservableFuture<dynamic>(_$future);
  }

  @override
  ObservableFuture<dynamic> Delete(Post post) {
    final _$future = super.Delete(post);
    return ObservableFuture<dynamic>(_$future);
  }

  @override
  ObservableFuture<dynamic> giahan(Newpost post) {
    final _$future = super.giahan(post);
    return ObservableFuture<dynamic>(_$future);
  }

  @override
  ObservableFuture<double> getpackprice(int idpack) {
    final _$future = super.getpackprice(idpack);
    return ObservableFuture<double>(_$future);
  }

  @override
  ObservableFuture<dynamic> getfavopost(int iduser, bool isloadmore) {
    final _$future = super.getfavopost(iduser,isloadmore);
    return ObservableFuture<dynamic>(_$future);
  }

  final _$getPostsAsyncAction = AsyncAction('_PostStore.getPosts');

  @override
  Future<dynamic> getPosts(bool isLoadMore) {
    return _$getPostsAsyncAction.run(() => super.getPosts(isLoadMore));
  }

  final _$getRecommendPostsAsyncAction =
      AsyncAction('_PostStore.getRecommendPosts');

  @override
  Future<dynamic> getRecommendPosts(String tag, bool isSearchInHome) {
    return _$getRecommendPostsAsyncAction
        .run(() => super.getRecommendPosts(tag, isSearchInHome));
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

  final _$_PostStoreActionController = ActionController(name: '_PostStore');

  @override
  void setSearchContent(String value, {bool isTag = false}) {
    final _$actionInfo = _$_PostStoreActionController.startAction(
        name: '_PostStore.setSearchContent');
    try {
      return super.setSearchContent(value, isTag: isTag);
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
fetchisGetRecommendPostsFuture: ${fetchisGetRecommendPostsFuture},
fetchSearchFuture: ${fetchSearchFuture},
postList: ${postList},
rcmPostList: ${rcmPostList},
isIntialLoading: ${isIntialLoading},
skipCount: ${skipCount},
propertyList: ${propertyList},
fetchPostCategorysFuture: ${fetchPostCategorysFuture},
imageUrlList: ${imageUrlList},
filter_model: ${filter_model},
success: ${success},
propertiesSuccess: ${propertiesSuccess},
isBaiGhimYeuThich: ${isBaiGhimYeuThich},
postCategoryList: ${postCategoryList},
searchContent: ${searchContent},
scrollController: ${scrollController},
successgetcategorys: ${successgetcategorys},
fetchPacksFuture: ${fetchPacksFuture},
packList: ${packList},
successPack: ${successPack},
fetchThuocTinhsFuture: ${fetchThuocTinhsFuture},
thuocTinhList: ${thuocTinhList},
successThuocTinh: ${successThuocTinh},
fetchNewpostsFuture: ${fetchNewpostsFuture},
successNewpost: ${successNewpost},
fetcheditpostsFuture: ${fetcheditpostsFuture},
successeditpost: ${successeditpost},
isIntialLoadingpostforcur: ${isIntialLoadingpostforcur},
fetchPostForCursFuture: ${fetchPostForCursFuture},
postForCurList: ${postForCurList},
successPostForCur: ${successPostForCur},
fetchdeleteFuture: ${fetchdeleteFuture},
successdelete: ${successdelete},
fetchgiahanFuture: ${fetchgiahanFuture},
successgiahan: ${successgiahan},
fetchgetpackpriceFuture: ${fetchgetpackpriceFuture},
successgetpackprice: ${successgetpackprice},
fetchpostfavoFuture: ${fetchpostfavoFuture},
favopost: ${favopost},
successfavopost: ${successfavopost},
loading: ${loading},
propertiesLoading: ${propertiesLoading},
isBaiGhimYeuThichLoading: ${isBaiGhimYeuThichLoading},
getRecommendPostsFutureLoading: ${getRecommendPostsFutureLoading},
searchLoading: ${searchLoading},
loadinggetcategorys: ${loadinggetcategorys},
hasFilter: ${hasFilter},
loadingPack: ${loadingPack},
loadingThuocTinh: ${loadingThuocTinh},
loadingNewpost: ${loadingNewpost},
loadingeditpost: ${loadingeditpost},
loadingPostForCur: ${loadingPostForCur},
Deletepost: ${Deletepost},
giahanpost: ${giahanpost},
getpackpricepost: ${getpackpricepost},
loadingfavopost: ${loadingfavopost}
    ''';
  }
}
