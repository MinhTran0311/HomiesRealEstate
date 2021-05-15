import 'dart:async';

import 'package:boilerplate/data/local/datasources/post/post_datasource.dart';
import 'package:boilerplate/data/network/apis/image/image_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/image/image_list.dart';
import 'package:boilerplate/data/network/apis/lichsugiaodich/lichsugiaodich_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postProperties/postProperty_list.dart';
import 'package:boilerplate/models/post/post_list.dart';
import 'package:boilerplate/models/post/post_category_list.dart';
import 'package:boilerplate/models/post/postpack/pack_list.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';
import 'package:boilerplate/models/town/commune_list.dart';
import 'package:boilerplate/models/town/town_list.dart';
import 'package:boilerplate/models/town/town.dart';
import 'package:boilerplate/models/token/authToken.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/models/user/user_list.dart';
import 'package:sembast/sembast.dart';
import 'network/apis/authToken/authToken_api.dart';
import 'dart:developer';
import 'local/constants/db_constants.dart';
import 'network/apis/posts/post_api.dart';
import 'network/apis/towns/town_api.dart';
import 'network/apis/users/user_api.dart';
import 'network/apis/registration/registration_api.dart';

class Repository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;
  final TownApi _townApi;
  final AuthTokenApi _authTokenApi;
  final UserApi _userApi;
  final ImageApi _imageApi;

  final RegistrationApi _registrationApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  Repository(this._postApi, this._sharedPrefsHelper, this._postDataSource, this._authTokenApi, this._registrationApi, this._userApi, this._imageApi,this._townApi);

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
  Future<PostCategoryList> getPostCategorys() async {
    return await _postApi.getPostCategorys().then((postCategoryList) {
      return postCategoryList;
    }
    ).catchError((error) => throw error);
  }
  Future<PackList> getPacks() async {
    return await _postApi.getPacks().then((packList) {
      return packList;
    }
    ).catchError((error) => throw error);
  }
  Future<ThuocTinhList> getThuocTinhs() async {
    return await _postApi.getThuocTinhs().then((thuocTinhList) {
      return thuocTinhList;
    }
    ).catchError((error) => throw error);
  }

  Future<PropertyList> getPostProperties(String postId) async {
    return await _postApi.getPostProperties(postId)
        .catchError((error) {
      throw error;
    });
  }
  Future<String> postPost(Newpost post) async {
    return await _postApi.postPost(post)
        .catchError((error) {
      throw error;
    });
  }
  // Post: ---------------------------------------------------------------------
  // Future<listLSGD> getLSGD() async {
  //   // check to see if posts are present in database, then fetch from database
  //   // else make a network call to get all posts, store them into database for
  //   // later use
  //   return await _userApi.getLSGD().then((lsgdList) {
  //     return lsgdList;
  //   }).catchError((error) => throw error);
  // }
  // Town: ---------------------------------------------------------------------
  Future<TownList> getTowns() async {

    return await _townApi.getTowns().then((townsList) {
      return townsList;
    }).catchError((error) => throw error);
  }
  Future<CommuneList> getCommunes() async {
    return await _townApi.getCommunes().then((communesList) {

      return communesList;
    }).catchError((error) => throw error);
  }
  // Town: ---------------------------------------------------------------------

  //User: ----------------------------------------------------------------------
  Future<UserList> getAllUsers() async {
    return await _userApi.getAllUsers().then((usersList) {
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
  Future<dynamic> getWalletUser() async {
    return await _userApi.getCurrentWalletUser().then((user) {
      // log('dataUserTest: $user');
      return user;
    }).catchError((error) => throw error);
  }
  Future<dynamic> updateCurrentUser(String name,String surname,String phonenumber,String email,String userName,int id) async {
    return await _userApi.updatetCurrentUser(name,surname,phonenumber,email,userName,id).then((user) {
      // log('dataUserTest: $user');
      return user;
    }).catchError((error) => throw error);
  }

  Future<CurrentUserForEditdto> getUserOfCurrentDeatiaiPost(int Id) async {
    return await _userApi.getUserOfCurrentDetailPost(Id).then((user) {
      return user;
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
  Future<String> postImageToImageBB(String path,String name) async {
    return await _imageApi.postImage(path,name)
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