import 'dart:convert';

class AuthToken {
  String accessToken;
  String encryptedAccessToken;
  int expireInSeconds;
  int userId;
  String refreshToken;
  int refreshTokenExpireInSeconds;

  AuthToken({
    this.accessToken,
    this.encryptedAccessToken,
    this.expireInSeconds,
    this.userId,
    this.refreshToken,
    this.refreshTokenExpireInSeconds,
  });

  factory AuthToken.fromMap(Map<String, dynamic> json) => AuthToken(
    accessToken: json["result"]["accessToken"],
    encryptedAccessToken: json["result"]["encryptedAccessToken"],
    expireInSeconds: json["result"]["expireInSeconds"],
    userId: json["result"]["userId"],
    refreshToken: json["result"]["refreshToken"],
    refreshTokenExpireInSeconds: json["result"]["refreshTokenExpireInSeconds"],
  );

  Map<String, dynamic> toMap() => {
    "accessToken": accessToken,
    "encryptedAccessToken": encryptedAccessToken,
    "expireInSeconds": expireInSeconds,
    "userId": userId,
    "refreshToken": refreshToken,
    "refreshTokenExpireInSeconds": refreshTokenExpireInSeconds,
  };

  // factory AuthToken.fromJson(var response)
  // {
  //   AuthToken authToken = new AuthToken();
  //   authToken = AuthToken.fromMap(json.decode(response.body));
  //
  // }
}

