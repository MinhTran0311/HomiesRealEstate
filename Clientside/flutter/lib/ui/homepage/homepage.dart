import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';
import 'package:boilerplate/ui/home/home.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
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

class HomePageScreen extends StatefulWidget {
  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {

  int _currentIndex = 0;
  PageController _pageController;

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
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            HomeScreen(),
            //Container(color: Colors.white,),
            MapsScreen(),
            ManagementScreen(),
            Container(color: Colors.white,),
            ProfileScreen(),
            Container(color: Colors.white,),
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white,
        color: Colors.amber,
        items: <Widget>[
          Icon(Icons.home, size: 30,color: Colors.black87,),
          Icon(Icons.location_pin, size: 30,color: Colors.black87,),
          Icon(Icons.notifications, size: 30, color: Colors.black87,),
          Icon(Icons.person, size: 30, color: Colors.black87,),
          Icon(Icons.add_circle_rounded, size: 30, color: Colors.black87,),
        ],
        height: 60,
        index: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}