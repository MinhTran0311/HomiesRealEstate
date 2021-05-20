import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/ui/admin/management.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/newpost/newpost.dart';
import 'package:boilerplate/ui/profile/account/account.dart';
import 'package:boilerplate/ui/profile/profile.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/ui/admin/management.dart';

import 'TabNavigator.dart';

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  String _currentPage = "HomeScreen";
  int _currentIndex = 0;
  PageController _pageController;
  int _selectedIndex = 0;

  List<String> pageKeys = ["HomeScreen", "MapsScreen", "ManagementScreen","ProfileScreen","NewPost"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "HomeScreen": GlobalKey<NavigatorState>(),
    "MapsScreen": GlobalKey<NavigatorState>(),
    "ManagementScreen": GlobalKey<NavigatorState>(),
    "ProfileScreen": GlobalKey<NavigatorState>(),
    "NewPost": GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage].currentState.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "HomeScreen") {
            _selectTab("HomeScreen", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        // body: SizedBox.expand(
        //   child: PageView(
        //     controller: _pageController,
        //     onPageChanged: (index) {
        //       setState(() => _currentIndex = index);
        //     },
        //     children: <Widget>[
        //       _buildOffstageNavigator("HomeScreen"),
        //       _buildOffstageNavigator("Map"),
        //       _buildOffstageNavigator("Notification"),
        //       _buildOffstageNavigator("Profile"),
        //       _buildOffstageNavigator("NewPost"),
        //       // HomeScreen(),
        //       // //Container(color: Colors.white,),
        //       // UserManagementScreen(),
        //       // Container(color: Colors.white,),
        //       // ProfileScreen(),
        //       // Container(color: Colors.white,),
        //     ],
        //   ),
        // ),
        body: Stack(
          children: [
            _buildOffstageNavigator("HomeScreen"),
            _buildOffstageNavigator("MapsScreen"),
            _buildOffstageNavigator("ManagementScreen"),
            _buildOffstageNavigator("ProfileScreen"),
            _buildOffstageNavigator("NewPost"),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          backgroundColor: Colors.transparent,
          color: Colors.amber,
          items: <Widget>[
            Icon(Icons.home, size: 30,color: Colors.black87,),
            Icon(Icons.location_pin, size: 30,color: Colors.black87,),
            Icon(Icons.notifications, size: 30, color: Colors.black87,),
            Icon(Icons.person, size: 30, color: Colors.black87,),
            Icon(Icons.add_circle_rounded, size: 30, color: Colors.black87,),
          ],
          index: _currentIndex,

          onTap: (index) {
            setState(() {
              _selectTab(pageKeys[index], index);
              _currentIndex = index;
            });
            _pageController.jumpToPage(index);
          },
        ),
      ),
    );
  }



  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  Widget _buildOffstageNavigator(String tabItem) {
    return Offstage(
      offstage: _currentPage != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}
