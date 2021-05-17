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

  static const String getUserOfCurrentPost = homiesUrl + "/services/app/Profile/GetUserProfileById";
  //# region user
  //get all users
  static const String getAllUsers = homiesUrl + "/services/app/User/GetUsers";
  //get all users
  static const String getUsersByID = homiesUrl + "/services/app/User/GetUserForEdit";
  //get all users
  static const String getCurrenUser = homiesUrl + "/services/app/Profile/GetCurrentUserProfileForEdit";
  //get all users
  static const String getCurrenWalletUser = homiesUrl + "/services/app/Profile/GetCurrentUserWallet";
  //get current lichsugiaodich
  static const String getCurrenlichsugiaodich = homiesUrl + "/services/app/LichSuGiaoDichs/GetAllLSGDByCurrentUser";

  //# region Post

  //get all lichsugiaodich
  static const String getAllLSGD = homiesUrl + "/services/app/LichSuGiaoDichs/GetAll";
  //update all lichsugiaodich
  static const String CreateOrEditLSGD = homiesUrl + "/services/app/LichSuGiaoDichs/CreateOrEdit";
  //get all lichsugiaodich
  static const String updateCurrenUser = homiesUrl + "/services/app/Profile/UpdateCurrentUserProfile";
  // getAllPost
  static const String getAllBaiDang = homiesUrl + "/services/app/BaiDangs/GetAll";
  //getAllRole
  static const String getAllRole = homiesUrl + "/services/app/Role/GetRoles";
  // getPostProperties
  static const String getAllChiTietBaiDangByPostId = homiesUrl + "/services/app/ChiTietBaiDangs/GetAllChiTietBaiDangByPostId";
  static const String isBaiDangYeuThichOrNot = homiesUrl + "/services/app/BaiGhimYeuThichs/IsExistOrNot";
  static const String createOrChangeStatusBaiGhimYeuThich = homiesUrl + "/services/app/BaiGhimYeuThichs/CreateOrChangeStatus";
  //post image
  static const String postImageToImageBB = imagebb + "/1/upload";
  static const String getImagesForDetail = homiesUrl + "/services/app/HinhAnhs/GetAllByPostId";
  //search
  static const String searchPosts = homiesUrl + "/services/app/BaiDangs/GetAllByFilter";
  //# endregion
}