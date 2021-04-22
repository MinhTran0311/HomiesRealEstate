class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  //base url Homies
  static const String homiesUrl = "https://homies.exscanner.edu.vn/api";

  // receiveTimeout
  static const int receiveTimeout = 7000;

  // connectTimeout
  static const int connectionTimeout = 6000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

  //get all users
  static const String getAllUsers = homiesUrl + "/services/app/User/GetUsers";
  // getAllPost
  static const String getAllBaiDang = homiesUrl + "/services/app/BaiDangs/GetAll";
}
