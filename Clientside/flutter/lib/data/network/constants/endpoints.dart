class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "http://jsonplaceholder.typicode.com";

  // receiveTimeout
  static const int receiveTimeout = 7000;

  // connectTimeout
  static const int connectionTimeout = 6000;

  // booking endpoints
  static const String getPosts = baseUrl + "/posts";

}