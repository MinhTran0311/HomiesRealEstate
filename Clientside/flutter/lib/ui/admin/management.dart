import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/ui/admin/roleManagement/roleManagement.dart';
import 'package:boilerplate/ui/admin/thuocTinhManagement/thuocTinhManagement.dart';
import 'package:boilerplate/ui/kiemduyet/kiemduyet.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
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
import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';
import 'package:boilerplate/stores/admin/danhMucManagement/danhMucManagement_store.dart';
import 'package:boilerplate/stores/admin/thuocTinhManagement/thuocTinhManagement_store.dart';
import 'package:boilerplate/stores/admin/goiBaiDangManagement/goiBaiDangManagement_store.dart';
import 'package:boilerplate/stores/admin/baiDangManagement/baiDangManagement_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';

import 'danhMucManagement/danhMucManagement.dart';
import 'goiBaiDangManagement/goiBaiDangManagement.dart';

class ManagementScreen extends StatefulWidget {
  @override
  _ManagementScreenState createState() => _ManagementScreenState();
}

class _ManagementScreenState extends State<ManagementScreen> {

  UserManagementStore _userManagementStore;
  ThemeStore _themeStore;
  RoleManagementStore _roleManagementStore;
  DanhMucManagementStore _danhMucManagementStore;
  ThuocTinhManagementStore _thuocTinhManagementStore;
  GoiBaiDangManagementStore _goiBaiDangManagementStore;
  BaiDangManagementStore _baiDangManagementStore;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _themeStore = Provider.of<ThemeStore>(context);
    _userManagementStore = Provider.of<UserManagementStore>(context);
    _roleManagementStore = Provider.of<RoleManagementStore>(context);
    _danhMucManagementStore = Provider.of<DanhMucManagementStore>(context);
    _thuocTinhManagementStore = Provider.of<ThuocTinhManagementStore>(context);
    _goiBaiDangManagementStore = Provider.of<GoiBaiDangManagementStore>(context);
    _baiDangManagementStore = Provider.of<BaiDangManagementStore>(context);
    if(!_userManagementStore.loadingCountAllUser) {
      _userManagementStore.fCountAllUsers();
    }
    if(!_userManagementStore.loadingCountNewUsersInMonth) {
      _userManagementStore.fCountNewUsersInMonth();
    }
    if(!_roleManagementStore.loadingCountAllRoles) {
      _roleManagementStore.fCountAllRoles();
    }
    if(!_danhMucManagementStore.loadingCountAllDanhMucs) {
      _danhMucManagementStore.fCountAllDanhMucs();
    }
    if(!_thuocTinhManagementStore.loadingCountAllThuocTinhs) {
      _thuocTinhManagementStore.fCountAllThuocTinhs();
    }
    if(!_goiBaiDangManagementStore.loadingCountAllGoiBaiDangs) {
      _goiBaiDangManagementStore.fCountAllGoiBaiDangs();
    }
    if(!_baiDangManagementStore.loadingCountNewBaiDangsInMonth) {
      _baiDangManagementStore.fCountNewBaiDangsInMonth();
    }
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
        return (_userManagementStore.loadingCountAllUser
        || _userManagementStore.loadingCountNewUsersInMonth
        || _roleManagementStore.loadingCountAllRoles
        || _danhMucManagementStore.loadingCountAllDanhMucs
        || _thuocTinhManagementStore.loadingCountAllThuocTinhs
        || _goiBaiDangManagementStore.loadingCountAllGoiBaiDangs
        || _baiDangManagementStore.loadingCountNewBaiDangsInMonth)
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildMenuItems(),
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
            stops: [0.0, 0.08, 0.08, 1],
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
                    "Tổng Quan Tháng " + "${_userManagementStore.dateCurrent.month}/${_userManagementStore.dateCurrent.year}",
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
                            "${_userManagementStore.countNewUsersInMonth}",
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
                            "${_baiDangManagementStore.countNewBaiDangsInMonth}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                ],
              ),
            ),
            SizedBox(height: 25,),
            _buildListItem("Người dùng", "assets/images/customer.png", _userManagementStore.countAllUsers, "Danh sách người dùng", _clickBtnListUser, Colors.amber, 0),
            SizedBox(height: 25,),
            _buildListItem("Vai trò", "assets/images/project-management.png", _roleManagementStore.countAllRoles, "Danh sách vai trò", _clickBtnListRole, Colors.lightBlueAccent, 0),
            SizedBox(height: 25,),
            _buildListItem("Danh mục", "assets/images/project-management.png", _danhMucManagementStore.countAllDanhMucs, "Danh sách danh mục", _clickBtnListDanhMuc, Colors.lightBlueAccent, 0),
            SizedBox(height: 25,),
            _buildListItem("Gói bài đăng", "assets/images/project-management.png", _goiBaiDangManagementStore.countAllGoiBaiDangs, "Danh sách gói bài đăng", _clickBtnListGoiBaiDang, Colors.lightBlueAccent, 0),
            SizedBox(height: 25,),
            _buildListItem("Thuộc tính", "assets/images/project-management.png", _thuocTinhManagementStore.countAllThuocTinhs, "Danh sách thuộc tính", _clickBtnListThuocTinh, Colors.lightBlueAccent, 0),
            SizedBox(height: 25,),
            // _buildListItem("Vai trò", "assets/images/project-management.png", _roleManagementStore.countAllRoles, "Danh sách vai trò", _clickBtnListRole, Colors.lightBlueAccent, 0),
            // SizedBox(height: 25,),
            // _buildListItem("Vai trò", "assets/images/project-management.png", _roleManagementStore.countAllRoles, "Danh sách vai trò", _clickBtnListRole, Colors.lightBlueAccent, 0),
            // SizedBox(height: 25,),
            _buildListItem("Nhật ký kiểm tra", "assets/images/open-book.png", 300, "Nhật ký kiểm tra", _clickBtnListTester, Colors.red, 0),
            SizedBox(height: 25,),
            _buildListItem("Maps", "assets/images/maps-and-flags.png", 15, "Xem bản đồ", _clickBtnMaps, Colors.green, 0),
            SizedBox(height: 25,),
            _buildListItem("Maps đăng bài", "assets/images/maps-and-flags.png", 15, "Xem bản đồ", _clickBtnMapsDangBai, Colors.green, 0),
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

  _clickBtnListDanhMuc() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DanhMucManagementScreen()),
    );
  }

  _clickBtnListGoiBaiDang() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoiBaiDangManagementScreen()),
    );
  }

  _clickBtnListThuocTinh() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ThuocTinhManagementScreen()),
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
      MaterialPageRoute(builder: (context) => MapsScreen(type: "Xem bản đồ")),
    );
  }

  _clickBtnMapsDangBai() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MapsScreen(type: "Đăng bài")),
    );
  }

  _clickBtnChecker() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => KiemDuyetPage()),
    );
  }
}