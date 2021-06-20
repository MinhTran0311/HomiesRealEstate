import 'package:flutter/material.dart';

class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  //base url Homies
  static const String homiesUrl = "https://homies.exscanner.edu.vn/api";
  static const String imagebb = "https://api.imgbb.com";

  // receiveTimeout
  static const int receiveTimeout = 25000;

  // connectTimeout
  static const int connectionTimeout = 15000;
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
  //get lichsugiaodich chua kiem duyet
  static const String getLSGDChuaKiemDuyet = homiesUrl + "/services/app/LichSuGiaoDichs/CountAllLichSuGiaoDichsChuaKiemDuyet";
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
  static const String addViewForPost = homiesUrl + "/services/app/BaiDangs/AddViewForBaiDang";
  //# endregion

  static const String getAllProvinces = homiesUrl + "/services/app/Tinhs/GetAll";
  static const String getAllTowns = homiesUrl + "/services/app/Huyens/GetAll";
  static const String getAllCommunes = homiesUrl + "/services/app/Xas/GetAll";

  //get all role
  static const String getCurrentUserRole = homiesUrl + "/services/app/Role/GetRoleForView";
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

  //Danh mục
  //Get all Danh Mục
  static const String getAllDanhMucs = homiesUrl + "/services/app/DanhMucs/GetAll";
  //Đếm tổng số danh mục
  static const String countAllDanhMucs = homiesUrl + "/services/app/DanhMucs/CountAllDanhMucs";
  //Create or edit danh mục
  static const String createOrEditDanhMuc = homiesUrl + "/services/app/DanhMucs/CreateOrEdit";

  //Gói bài đăng
  //Get all Gói bài đăng
  static const String getAllGoiBaiDangs = homiesUrl + "/services/app/GoiBaiDangs/GetAll";
  //Đếm tổng số gói bài đăng
  static const String countAllGoiBaiDangs = homiesUrl + "/services/app/GoiBaiDangs/CountAllGoiBaiDangs";
  //Create or edit gói bài đăng
  static const String createOrEditGoiBaiDang = homiesUrl + "/services/app/GoiBaiDangs/CreateOrEdit";

  //Thuộc tính
  //Get all Thuộc tính
  static const String getAllThuocTinhs = homiesUrl + "/services/app/ThuocTinhs/GetAll";
  //Đếm tổng số thuộc tính
  static const String countAllThuocTinhs = homiesUrl + "/services/app/ThuocTinhs/CountAllThuocTinhs";
  //Create or edit thuộc tính
  static const String createOrEditThuocTinh = homiesUrl + "/services/app/ThuocTinhs/CreateOrEdit";

  //Đếm tổng số bài đăng trong tháng
  static const String countNewBaiDangInMonth = homiesUrl + "/services/app/BaiDangs/CountNewBaiDangInMonth";

}