
import 'package:flutter/material.dart';
import 'ui/profile/profile.dart';
import 'ui/home/home.dart';
import 'ui/login/login.dart';
import 'ui/splash/splash.dart';
import 'ui/registraion/registration.dart';
import 'ui/homepage/homepage.dart';
import 'ui/admin/userManagement/userManagement.dart';
class Routes {
  Routes._();

  //static variables
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';
  static const String resetPassword = '/resetPassword';
  static const String signup = '/signup';
  static const String userManagement = '/userManagement';
  static const String profile = '/profile';
  static const String newpost = '/newpost';


  static final routes = <String, WidgetBuilder>{
    splash: (BuildContext context) => SplashScreen(),
    login: (BuildContext context) => LoginScreen(),
    home: (BuildContext context) => HomePageScreen(),
    signup: (BuildContext context) => RegistrationScreen(),
    userManagement: (BuildContext context) => UserManagementScreen(),
    profile: (BuildContext context) => ProfileScreen(),
    newpost: (BuildContext context) => NewpostScreen(),
    resetPassword: (BuildContext context) => ResetPasswordScreen(),
  };
}



