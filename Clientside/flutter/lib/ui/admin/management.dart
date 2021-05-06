import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/ui/admin/roleManagement/roleManagement.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';

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
          color: Color.fromRGBO(241, 242, 246, 1),
        );
      },
    );
  }

  Widget _buildMenuItems() {
    return Container(
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.only(top: 30, right: 25, left: 25, bottom: 25),
        crossAxisSpacing: 25,
        mainAxisSpacing: 25,
        crossAxisCount: 2,
        children: <Widget>[
          GestureDetector(
            child: _buildItemsGridView("Người dùng"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserManagementScreen()),
              );
            },
          ),
          GestureDetector(
            child: _buildItemsGridView("Vai trò"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RoleManagementScreen()),
              );
            },
          ),
          GestureDetector(
              child: _buildItemsGridView("Nhật ký kiểm tra"),
            onTap: () {

            },
          ),
          GestureDetector(
            child: _buildItemsGridView("Cài đặt"),
            onTap: () {

            },
          ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Text('Revolution is coming...'),
          //   color: Colors.amberAccent,
          // ),
          // Container(
          //   padding: const EdgeInsets.all(8),
          //   child: const Text('Revolution, they...'),
          //   color: Colors.amberAccent,
          // ),
        ],
      ),
    );
  }

  Widget _buildItemsGridView(String nameItem)
  {
    return Container(
      decoration: new BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.amber,
            Colors.orange[700],
          ]
        ),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10)
        ),
        boxShadow: [
          // color: Colors.white, //background color of box
          BoxShadow(
            color: Color.fromRGBO(198, 199, 202, 1),
            blurRadius: 10, // soften the shadow
            spreadRadius: 0.01, //extend the shadow
            offset: Offset(
              8.0, // Move to right 10  horizontally
              12.0, // Move to bottom 10 Vertically
            ),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      alignment: Alignment.topCenter,
      child: Container (
        padding: EdgeInsets.only(top: 10),
        child: Text(
          nameItem,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      )
    );
  }


}