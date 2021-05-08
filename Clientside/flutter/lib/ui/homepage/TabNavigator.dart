import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/profile/profile.dart';
import 'package:boilerplate/ui/newpost/newpost.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class TabNavigator extends StatelessWidget {
  TabNavigator({this.navigatorKey, this.tabItem});
  final GlobalKey<NavigatorState> navigatorKey;
  final String tabItem;

  @override
  Widget build(BuildContext context) {

    Widget child ;
    if(tabItem == "HomeScreen")
      child = HomeScreen();
    else if(tabItem == "Map")
      child = UserManagementScreen();
    else if(tabItem == "Notification")
      child = ProfileScreen();
    else if(tabItem == "Profile")
      child = Container();
    else if(tabItem == "NewPost")
      child = NewpostScreen();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
            builder: (context) => child
        );
      },
    );
  }
}
