import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/ui/admin/roleManagement/roleManagement.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/maps/maps.dart';

class ManagementScreen extends StatefulWidget {
  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Quản trị",
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        // _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return Material(child: _buildMenuItems(),
          color: Color.fromRGBO(236, 236, 238, 1),
          // color: Colors.white,
        );
      },
    );
  }

  Widget _buildMenuItems() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 0.15, 0.15, 1],
            colors: [
              Color.fromRGBO(230, 145, 56, 1),
              Colors.amberAccent,
              Color.fromRGBO(236, 236, 238, 1),
              Color.fromRGBO(236, 236, 238, 1),
            ],
            tileMode: TileMode.repeated,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 35 ,),
            Container(
              padding: EdgeInsets.only(top: 15, left: 18),
              width: MediaQuery.of(context).size.width*0.95,
              // height: 200,
              decoration: BoxDecoration(
                boxShadow: [
                  // color: Colors.white, //background color of box
                  BoxShadow(
                    color: Color.fromRGBO(198, 199, 202, 1),
                    blurRadius: 12, // soften the shadow
                    spreadRadius: 0.01, //extend the shadow
                    offset: Offset(
                      8.0, // Move to right 10  horizontally
                      12.0, // Move to bottom 10 Vertically
                    ),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Tổng Quan Tháng 05/2021",
                    style: TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/analytics.png',
                            width: MediaQuery.of(context).size.width*0.15,
                          ),
                          SizedBox(height: 10,),
                          Text("Người dùng mới"),
                          SizedBox(height: 10,),
                          Text(
                            "155",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'assets/images/map.png',
                            width: MediaQuery.of(context).size.width*0.15,
                          ),
                          SizedBox(height: 10,),
                          Text("Bài đăng mới"),
                          SizedBox(height: 10,),
                          Text(
                            "1.055",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                      // Column(
                      //   children: [
                      //     Image.asset(
                      //       'assets/images/map.png',
                      //       width: MediaQuery.of(context).size.width*0.15,
                      //     ),
                      //     SizedBox(height: 10,),
                      //     Text("Bài đăng mới"),
                      //     SizedBox(height: 10,),
                      //     Text(
                      //       "1.055",
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 20,
                      //       ),
                      //     )
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
            _buildListItem("Người dùng", "assets/images/customer.png", 20, "Danh sách người dùng", _clickBtnListUser, Colors.amber, 0),
            SizedBox(height: 25,),
            _buildListItem("Vai trò", "assets/images/project-management.png", 15, "Danh sách vai trò", _clickBtnListRole, Colors.lightBlueAccent, 0),
            SizedBox(height: 25,),
            _buildListItem("Nhật ký kiểm tra", "assets/images/open-book.png", 300, "Nhật ký kiểm tra", _clickBtnListTester, Colors.red, 0),
            SizedBox(height: 25,),
            _buildListItem("Maps tạm", "assets/images/maps-and-flags.png", 15, "Xem bản đồ", _clickBtnMaps, Colors.green, 0),
            SizedBox(height: 25,),
            _buildListItem("Kiểm duyệt giao dịch", "assets/images/approve.png", 15, "Kiểm duyệt giao dịch", _clickBtnChecker, Colors.deepOrangeAccent, 0),
            SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(String nameItem, String pathPicture, int totalItems, String nameButton, Function function, Color colors, double leftPadding) {
    return Container(
      decoration: new BoxDecoration(
        boxShadow: [
          // color: Colors.white, //background color of box
          BoxShadow(
            color: Color.fromRGBO(198, 199, 202, 1),
            blurRadius: 12, // soften the shadow
            spreadRadius: 0.01, //extend the shadow
            offset: Offset(
              8.0, // Move to right 10  horizontally
              12.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      child: Card(
        margin: EdgeInsets.only(top: 8, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          // height: 130,
          // color: Color.fromRGBO(242, 242, 242, 1),
          color: Colors.white,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Flexible(
                // child: Image.asset(
                //   pathPicture,
                //   width: MediaQuery.of(context).size.width*0.2,
                // ),
                child: Container(
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: colors,
                  ),
                  padding: EdgeInsets.all(8),
                  child: Container(
                    padding: EdgeInsets.only(left: leftPadding),
                    decoration: new BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Colors.white, width: 2),
                      color: colors,
                    ),
                    // backgroundColor: colors,
                    child: Image.asset(
                      pathPicture,
                      width: 40,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 15,),
              Flexible(
                flex: 4,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          nameItem,
                          style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        // SizedBox(width: 15,),
                        Text(
                          totalItems.toString(),
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6,),
                    ElevatedButton(
                        child: Text(
                            nameButton.toUpperCase(),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            )
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(colors),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: BorderSide(color: colors)
                                )
                            )
                        ),
                        onPressed: function,
                    )
                  ],
                )
              ),
            ],
          ),

        ),
      ),

    );
  }

  _clickBtnListUser() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UserManagementScreen()),
    );
  }

  _clickBtnListRole() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RoleManagementScreen()),
    );
  }

  _clickBtnListTester() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => UserManagementScreen()),
    // );
  }

  _clickBtnMaps() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapsScreen()),
    );
  }

  _clickBtnChecker() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => MapsScreen()),
    // );
  }
}