import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
// import 'package:boilerplate/stores/language/language_store.dart';
// import 'package:boilerplate/stores/post/post_store.dart';
// import 'package:boilerplate/stores/theme/theme_store.dart';
// import 'package:boilerplate/stores/user/user_store.dart';
// import 'package:boilerplate/models/user/user.dart';
// import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:boilerplate/ui/admin/userManagement/filterUser.dart';
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';
import 'package:boilerplate/models/role/role.dart';
import 'package:boilerplate/models/role/role_list.dart';

class RoleManagementScreen extends StatefulWidget {
  @override
  _RoleManagementScreenState createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  RoleManagementStore _roleManagementStore;

  var _selectedValue;
  var _permissions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _roleManagementStore = Provider.of<RoleManagementStore>(context);

    // initializing stores

    // check to see if already called api
    // if (!_roleManagementStore.loading) {
    //   _roleManagementStore.getRoles();
    // }
    // check to see if already called api
    if (!_roleManagementStore.loading) {
      _roleManagementStore.getRoles();
    }
  }

  _clickButtonApDung() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Container(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    child: Icon(
                      Icons.arrow_back,
                      size: 28,
                      color: Colors.white,
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  child: Text("Quản lý vai trò",
                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Icon(
                      Icons.add,
                      size: 28,
                      color: Colors.white,
                    ),
                    onTap: (){
                      // Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
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
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _roleManagementStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(
          child: _buildRolesList(),
          color: Color.fromRGBO(241, 242, 246, 1),);
      },
    );
  }

  Widget _buildRolesList()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 20,left: 24,right: 24, bottom: 16),
          child: TextField(
            style: TextStyle(
              fontSize: 28,
              height: 1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border:  UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                    size: 28,
                  ),
                )
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 25),
          child: GestureDetector(
            child: Row(
              children: [
                Text(
                  'Hiển thị bộc lọc nâng cao',
                  style: TextStyle(
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black26,
                  size: 20,
                ),
              ],
            ),
            onTap: (){
              _showBottomSheet();
            },
          ),

        ),
        // _selectedValueAfterTouchBtn != null ? _buildListViewFilter() : _buildListView(),
        _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return _roleManagementStore.roleList != null
        ? Expanded(
        child: ListView.separated(
          itemCount: _roleManagementStore.roleList.roles.length,
          separatorBuilder: (context, position) {
            return Divider();
          },
          itemBuilder: (context, position) {
            return _buildListItem(_roleManagementStore.roleList.roles[position], position);
          },
        )
    )
        : Center(
      child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy vai trò nào!",
      ),
    );
  }

  // Widget _buildListViewFilter() {
  //   return _listUserFilterFromRole != null
  //       ? Expanded(
  //       child: ListView.separated(
  //         itemCount: _listUserFilterFromRole.length,
  //         separatorBuilder: (context, position) {
  //           return Divider();
  //         },
  //         itemBuilder: (context, position) {
  //           return _buildListItem(_listUserFilterFromRole[position], position);
  //         },
  //       )
  //   )
  //       : Center(
  //     child: Text(
  //       // AppLocalizations.of(context).translate('home_tv_no_post_found'),
  //       "Không tìm thấy người dùng nào!",
  //     ),
  //   );
  // }

  Widget _buildListItem(Role role, int position) {
    return Container(
      decoration: new BoxDecoration(
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
      child: Card(
        margin: EdgeInsets.only(top: 8, right: 10, left: 10),
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Container(
          padding: EdgeInsets.all(20),
          height: 130,
          // color: Color.fromRGBO(242, 242, 242, 1),
          color: Colors.white,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      '${role.name}',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){

                    },
                    child: Icon(
                      Icons.menu_outlined,
                      size: 25,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.more_time,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '${role.creationTime}',
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                // fontWeight: FontWeight.bold,
                              ),
                            )
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(top: 20),
                        //   // child: ,
                        // ),
                        // Text(
                        //   'Kích hoạt: ',
                        //   overflow: TextOverflow.ellipsis,
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 18,
                        //     // fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                        role.isStatic ? Container(
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.all(Radius.circular(5))
                          ),
                          width: 60,
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Center(
                            child: Text(
                              "Tĩnh",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ) : Container(),
                        !role.isDefault ? Container()
                            : Container(
                          padding: EdgeInsets.only(left: 20),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.all(Radius.circular(5))
                            ),
                            width: 80,
                            // height: 30,
                            padding: EdgeInsets.symmetric(vertical: 4),
                            child: Center(
                              child: Text(
                                "Mặc định",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),

    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_roleManagementStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_roleManagementStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  void _showBottomSheet() async {
    // await _loadRoleList();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              buildFilterAdvance(),
            ],
          );
        }
    );
  }

  Widget buildFilterAdvance() {
    return Container(
        padding: EdgeInsets.only(right: 24,left: 24,top: 32,bottom: 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Bộ lọc vai trò",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4,),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(
                  "Quyền",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4,),
              ],
            ),
            _buildListDropdownItem(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSignUpButton(),
                SizedBox(
                  height: 20,
                  // width: double.infinity,
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Áp dụng'),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () {
        _clickButtonApDung();
      },
    );
  }

  Widget _buildListDropdownItem() {
    return DropdownButtonFormField(
      value: _selectedValue,
      items: _permissions,
      hint: Text("Chọn quyền"),
      onChanged: (value) {
        setState(() {
          _selectedValue = value;
        });
      },
    );
  }

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }

}