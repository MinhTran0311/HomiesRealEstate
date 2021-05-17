import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/image/image_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/data/network/apis/lichsugiaodich/lichsugiaodich_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/role/role.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:boilerplate/models/role/role_list.dart';
import 'package:sembast/sembast.dart';
import 'network/apis/authToken/authToken_api.dart';
import 'dart:developer';
import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';
import 'network/apis/users/user_api.dart';
import 'network/apis/roles/role_api.dart';
import 'network/apis/registration/registration_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;
  final AuthTokenApi _authTokenApi;
  final UserApi _userApi;
  final RoleApi _roleApi;
  final ImageApi _imageApi;

  final RegistrationApi _registrationApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource, this._authTokenApi, this._registrationApi, this._userApi, this._roleApi, this._imageApi);

  // Post: ---------------------------------------------------------------------
  Future<PostList> getPosts() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _postApi.getPosts().then((postsList) {
      postsList.posts.forEach((post) {
        _postDataSource.insert(post);
      });
      return postsList;
    }).catchError((error) => throw error);
  }

  Future<PropertyList> getPostProperties(String postId) async {
    return await _postApi.getPostProperties(postId)
        .catchError((error) {
      throw error;
    });
  }

  Future<dynamic> isBaiGhimYeuThichOrNot(String postId) async {
    return await _postApi.isBaiGhimYeuThichOrNot(postId)
        .catchError((error) {
      throw error;
    });
  }
  Future<dynamic> createOrChangeStatusBaiGhimYeuThich(String postId, bool status) async{
    return await _postApi.createOrChangeStatusBaiGhimYeuThich(postId,status)
        .catchError((error) {
      throw error;
    });
  }



  // LSGD: ---------------------------------------------------------------------
  Future<listLSGD> getLSGD() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userApi.getLSGD().then((lsgdList) {
      return lsgdList;
    }).catchError((error) => throw error);
  }
  Future<listLSGD> getAllLSGD() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userApi.getAllLSGD().then((lsgdList) {
      return lsgdList;
    }).catchError((error) => throw error);
  }
  Future<bool> NapTien(double soTien,String thoiDiem,int userId) async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userApi.Naptien(soTien, thoiDiem, userId).then((lsgd) {
      return lsgd;
    }).catchError((error) => throw error);
  }
  // Future<listLSGD> KiemDuyetNapTien(int userId, String idLSGD,int kiemDuyetVienID) async {
  //   // check to see if posts are present in database, then fetch from database
  //   // else make a network call to get all posts, store them into database for
  //   // later use
  //   return await _userApi.KiemDuyetNaptien(userId, idLSGD,kiemDuyetVienID).then((lsgd) {
  //     return lsgd;
  //   }).catchError((error) => throw error);
  // }
  Future<bool> KiemDuyetGiaoDich(String idLSGD) async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _userApi.KiemDuyetGiaoDich(idLSGD).then((lsgd) {
      return lsgd;
    }).catchError((error) => throw error);
  }
  //User: ----------------------------------------------------------------------
  Future<UserList> getAllUsers() async {
    return await _userApi.getAllUsers().then((usersList) {
      // log('dataUserTest: $usersList');
      return usersList;
      }).catchError((error) => throw error);
  }
  Future<User> getUserByID(int userID) async {
    return await _userApi.getUserByID(userID).then((usersList) {
      // log('dataUserTest: $usersList');
      return usersList;
      }).catchError((error) => throw error);
  }
  Future<CurrentUserForEditdto> getCurrentUser() async {
    return await _userApi.getCurrentUser().then((user) {
      // log('dataUserTest: $user');
      return user;
    }).catchError((error) => throw error);
  }
  Future<double> getWalletUser() async {
    return await _userApi.getCurrentWalletUser().then((walletuser) {
      // log('dataUserTest: $user');
      return walletuser;
    }).catchError((error) => throw error);
  }
  Future<String> getPictureUser() async {
    return await _userApi.getCurrentPictureUser().then((pictureuser) {
      // log('dataUserTest: $user');
      return pictureuser;
    }).catchError((error) => throw error);
  }
  Future<dynamic> updateCurrentUser(String name,String surname,String phonenumber,String email,String userName) async {
    return await _userApi.updatetCurrentUser(name,surname,phonenumber,email,userName).then((user) {
      // log('dataUserTest: $user');
      return user;
    }).catchError((error) => throw error);
  }
  Future<dynamic> updatePictureCurrentUser(String fileToken) async {
    return await _userApi.updatetPictureCurrentUser(fileToken).then((user) {
      // log('dataUserTest: $user');
      return user;
    }).catchError((error) => throw error);
  }

  Future<CurrentUserForEditdto> getUserOfCurrentDeatiaiPost(int Id) async {
    return await _userApi.getUserOfCurrentDetailPost(Id).then((user) {
      return user;
    }).catchError((error) => throw error);
  }

  Future<RoleList> getAllRoles() async {
    return await _roleApi.getAllRoles().then((roleList) {
      return roleList;
    }).catchError((error) => throw error);
  }


  Future<List<Post>> findPostById(int id) {
    //creating filter
    List<Filter> filters = List();

    //check to see if dataLogsType is not null
    if (id != null) {
      Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
      filters.add(dataLogTypeFilter);
    }

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(Post post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(Post post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);


  //registration
  Future<dynamic> registing(String surname, String name, String username, String password, String email) async
  {
    return await _registrationApi.regist(surname, name, username, password, email).then((res) {

      return res;
    }).catchError((error) => throw error);
  }

  // Login:---------------------------------------------------------------------
  Future<bool> login(String username, String password) async {
    return await Future.delayed(Duration(seconds: 2), ()=> true);
  }

  Future<AuthToken> authorizing(String username, String password) async {
    //return await Future.delayed(Duration(seconds: 2), ()=> true);
    return await _authTokenApi.getToken(username, password)
        .catchError((error) {
          throw error;
    });
  }

  Future<dynamic> resetPassword(String email) async
  {
    return await _authTokenApi.resetPassword(email).catchError((e)=>throw e);
  }


  //Image
  Future<String> postImageToImageBB(String path) async {
    return await _imageApi.postImage(path)
        .catchError((error) {
      throw error;
    });
  }

  Future<ImageList> getImagesForDetail(String postId) async {
    return await _imageApi.getImages(postId)
        .catchError((error) {
      throw error;
    });
  }


  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  // Theme: --------------------------------------------------------------------
  Future<void> changeBrightnessToDark(bool value) =>
      _sharedPrefsHelper.changeBrightnessToDark(value);

  Future<bool> get isDarkMode => _sharedPrefsHelper.isDarkMode;

  // Language: -----------------------------------------------------------------
  Future<void> changeLanguage(String value) =>
      _sharedPrefsHelper.changeLanguage(value);

  Future<String> get currentLanguage => _sharedPrefsHelper.currentLanguage;
}
