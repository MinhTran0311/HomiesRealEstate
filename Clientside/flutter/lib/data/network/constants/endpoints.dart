class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  //base url Homies
  static const String homiesUrl = "https://homies.exscanner.edu.vn/api";
  static const String imagebb = "https://api.imgbb.com";

  // receiveTimeout
  static const int receiveTimeout = 7000;

  // connectTimeout
  static const int connectionTimeout = 6000;
  //#region login & sign up
  static const String login = homiesUrl + "/TokenAuth/Authenticate";
  static const String signup = homiesUrl + "/services/app/Account/Register";
  static const String resetPassword = homiesUrl + "/services/app/Account/SendPasswordResetCode";


  //#endregion


  //# region user
  //get all users
  static const String getAllUsers = homiesUrl + "/services/app/User/GetUsers";
  //get users
  static const String getCurrenUser = homiesUrl + "/services/app/Profile/GetCurrentUserProfileForEdit";
  static const String getUserOfCurrentPost = homiesUrl + "/services/app/Profile/GetUserProfileById";
  //# endregion

  //get all lichsugiaodich
  static const String getCurrenlichsugiaodich = homiesUrl + "/services/app/LichSuGiaoDichs/GetAllLSGDByCurrentUser";

  //# region Post

  //get all users
  static const String getCurrenWalletUser = homiesUrl + "/services/app/Profile/GetCurrentUserWallet";
  //get all lichsugiaodich
  static const String updateCurrenUser = homiesUrl + "/services/app/Profile/UpdateCurrentUserProfile";
  // getAllPost
  static const String getAllBaiDang = homiesUrl + "/services/app/BaiDangs/GetAll";
  // getPostProperties
  static const String getAllChiTietBaiDangByPostId = homiesUrl + "/services/app/ChiTietBaiDangs/GetAllChiTietBaiDangByPostId";
  //post image
  static const String postImageToImageBB = imagebb + "/1/upload";
  static const String getImagesForDetail = homiesUrl + "/services/app/HinhAnhs/GetAllByPostId";

//# endregion
}
