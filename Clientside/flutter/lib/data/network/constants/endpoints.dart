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
  static const String changePassword = homiesUrl + "/services/app/Profile/ChangePassword";

  //#endregion

  static const String getUserOfCurrentPost = homiesUrl + "/services/app/Profile/GetUserProfileById";
  //# region user
  //get all users
  static const String getAllUsers = homiesUrl + "/services/app/User/GetUsers";
  //get all users
  static const String getUsersByID = homiesUrl + "/services/app/User/GetUserForEdit";
  //get Avatar by User
  static const String getAvatarByUser = homiesUrl + "/services/app/Profile/GetProfilePictureByUser";
  //get all users
  static const String getCurrenUser = homiesUrl + "/services/app/Profile/GetCurrentUserProfileForEdit";
  //get all users
  static const String getCurrenWalletUser = homiesUrl + "/services/app/Profile/GetCurrentUserWallet";
  //get picture users
  static const String getCurrentPictureUser = homiesUrl + "/services/app/Profile/GetProfilePicture";
  //get current lichsugiaodich
  static const String getCurrenlichsugiaodich = homiesUrl + "/services/app/LichSuGiaoDichs/GetAllLSGDByCurrentUser";
  //getReportDate
  static const String getReportDate = homiesUrl + "/services/app/User/GetReportByUser";
  //# region Post

  //get all lichsugiaodich
  static const String getAllLSGD = homiesUrl + "/services/app/LichSuGiaoDichs/GetAll";
  //update all lichsugiaodich
  static const String CreateOrEditLSGD = homiesUrl + "/services/app/LichSuGiaoDichs/CreateOrEdit";
  //update kiemduyetgiaodich
  static const String kiemDuyetGiaoDich = homiesUrl + "/services/app/LichSuGiaoDichs/KiemDuyetGiaoDich";
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

  static const String getAllProvinces = homiesUrl + "/services/app/Tinhs/GetAll";
  static const String getAllTowns = homiesUrl + "/services/app/Huyens/GetAll";
  static const String getAllCommunes = homiesUrl + "/services/app/Xas/GetAll";

  //Cout all role
  static const String coutAllRole = homiesUrl + "/services/app/Role/CountAllRoles";
  //Cout all user
  static const String coutAllUser = homiesUrl + "/services/app/User/CountAllUsers";
  //Cout new user in month
  static const String coutNewUserInMonth = homiesUrl + "/services/app/User/CountNewUsersInMonth";
  //Update user
  static const String createOrUpdateUser = homiesUrl + "/services/app/User/CreateOrUpdateUser";
  // //Delete user
  // static const String createOrUpdateUser = homiesUrl + "/services/app/User/CreateOrUpdateUser";

}