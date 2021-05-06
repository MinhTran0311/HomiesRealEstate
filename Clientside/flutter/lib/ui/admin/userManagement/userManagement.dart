import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
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

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  //stores:---------------------------------------------------------------------
  UserManagementStore _userManagementStore;
  ThemeStore _themeStore;
  LanguageStore _languageStore;
  RoleManagementStore _roleManagementStore;

  var _selectedValue;
  var _selectedValueAfterTouchBtn;
  var _roles = List<DropdownMenuItem>();
  var _listUserFilterFromRole = List<User>();
  // bool selectedRole = false;

  // bool visibilityFilter = false;
  // bool visibilityObs = false;

  // _onClickItemUsers(var userSelected) {
  //
  // }

  @override
  void initState() {
    super.initState();
    // _loadRoles();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _userManagementStore = Provider.of<UserManagementStore>(context);
    _roleManagementStore = Provider.of<RoleManagementStore>(context);

    // initializing stores
    // check to see if already called api
    if (!_userManagementStore.loading) {
      _userManagementStore.getUsers();
    }

    if (!_roleManagementStore.loading) {
      _roleManagementStore.getRoles();
    }
  }

  _loadRoleList() {
    if (_roleManagementStore.roleList != null) {
      _roles.clear();
      _roles.add(DropdownMenuItem(
        child: Text("Tất cả vai trò"),
        value: "Tất cả vai trò",
      ));
      for (int i = 0; i < _roleManagementStore.roleList.roles.length; i++) {
        setState(() {
          _roles.add(DropdownMenuItem(
            child: Text(_roleManagementStore.roleList.roles[i].name),
            value: _roleManagementStore.roleList.roles[i].name,
          ));
        });
      }
    }
  }

  _clickButtonApDung() {
    if (_selectedValue != null && _selectedValue != "Tất cả vai trò") {
      _selectedValueAfterTouchBtn = _selectedValue;
      print(_selectedValueAfterTouchBtn);
      var listRoleSelect = _roleManagementStore.roleList;
      var listUserAll = _userManagementStore.userList;
      // var listUserFromRole = List<User>();
      _listUserFilterFromRole.clear();
      setState(() {
        for (int i = 0; i < listRoleSelect.roles.length; i++) {
          if (_selectedValue == listRoleSelect.roles[i].name) {
            for (int j = 0; j < listUserAll.users.length; j ++) {
              if (listUserAll.users[j].permissions == _selectedValue) {
                _listUserFilterFromRole.add(listUserAll.users[j]);
              }
            }
            Navigator.of(context).pop();
            return;
          }
        }
      });
    }
    else if (_selectedValue == "Tất cả vai trò") {
      _selectedValueAfterTouchBtn = _selectedValue;
      _listUserFilterFromRole.clear();
      setState(() {
        _listUserFilterFromRole = _userManagementStore.userList.users;
      });
      Navigator.of(context).pop();
      return;
    }
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
                  child: Text("Quản lý người dùng",
                    style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
                ),
              ),
              Expanded(
                // flex: 2,
                child: Container(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Icon(
                    Icons.person_add_alt_1,
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

  // Widget buildFilter(String filterName){
  //   return Container(
  //     padding: EdgeInsets.symmetric(horizontal: 12),
  //     margin: EdgeInsets.only(right: 12),
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.all(
  //           Radius.circular(5),
  //         ),
  //         border: Border.all(
  //           color: Colors.grey[300],
  //           width: 1,
  //         )
  //     ),
  //     child: Center(
  //       child: Text(
  //         filterName,
  //         style: TextStyle(
  //           fontSize: 16,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }




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
        return _userManagementStore.loading
            ? CustomProgressIndicatorWidget()
            : Material(
            child: _buildUsersList(),
            color: Color.fromRGBO(241, 242, 246, 1),);
      },
    );
  }

  Widget _buildUsersList()
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
        _selectedValueAfterTouchBtn != null ? _buildListViewFilter() : _buildListView(),
      ],
    );
  }

  Widget _buildListView() {
    return _userManagementStore.userList != null
        ? Expanded(
        child: ListView.separated(
          itemCount: _userManagementStore.userList.users.length,
          separatorBuilder: (context, position) {
            return Divider();
          },
          itemBuilder: (context, position) {
            return _buildListItem(_userManagementStore.userList.users[position], position);
          },
        )
    )
        : Center(
        child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy người dùng nào!",
      ),
    );
  }

  Widget _buildListViewFilter() {
    return _listUserFilterFromRole != null
        ? Expanded(
        child: ListView.separated(
          itemCount: _listUserFilterFromRole.length,
          separatorBuilder: (context, position) {
            return Divider();
          },
          itemBuilder: (context, position) {
            return _buildListItem(_listUserFilterFromRole[position], position);
          },
        )
    )
        : Center(
      child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy người dùng nào!",
      ),
    );
  }

  Widget _buildListItem(User user, int position) {
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
          height: 160,
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
                        '${user.name}',
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
                          Icons.person_outline_outlined,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            '${user.permissions}',
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
                  Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        // Padding(
                        //   padding: EdgeInsets.only(top: 20),
                        //   // child: ,
                        // ),
                        Text(
                          'Kích hoạt: ',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        user.isActive ? Container(
                              child: Icon(
                              Icons.check_circle_outline,
                              size: 20,
                              color: Colors.green,)
                            ) : Container(
                            child: Icon(
                              Icons.not_interested_outlined,
                              size: 20,
                              color: Colors.red,
                            ),
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
                    // alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Icon(
                          Icons.mail_outline,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Container(
                            padding: EdgeInsets.only(left: 5),
                            child: Text(
                              '${user.email}',
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
                    // alignment: Alignment.topRight,
                    child: Row(
                      children: [
                        Icon(
                          Icons.mark_email_read_outlined,
                          color: Colors.amber,
                          size: 20,
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Xác nhận email: ',
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        user.isEmailConfirmed ? Container(
                            child: Icon(
                              Icons.check_circle_outline,
                              size: 20,
                              color: Colors.green,)
                        ) : Container(
                          child: Icon(
                            Icons.not_interested_outlined,
                            size: 20,
                            color: Colors.red,
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
        if (_userManagementStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_userManagementStore.errorStore.errorMessage);
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

  _buildLanguageDialog() {
    _showDialog<String>(
      context: context,
      child: MaterialDialog(
        borderRadius: 5.0,
        enableFullWidth: true,
        title: Text(
          AppLocalizations.of(context).translate('home_tv_choose_language'),
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
          ),
        ),
        headerColor: Theme.of(context).primaryColor,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        closeButtonColor: Colors.white,
        enableCloseButton: true,
        enableBackButton: false,
        onCloseButtonClicked: () {
          Navigator.of(context).pop();
        },
        children: _languageStore.supportedLanguages
            .map(
              (object) => ListTile(
            dense: true,
            contentPadding: EdgeInsets.all(0.0),
            title: Text(
              object.language,
              style: TextStyle(
                color: _languageStore.locale == object.locale
                    ? Theme.of(context).primaryColor
                    : _themeStore.darkMode ? Colors.white : Colors.black,
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
              // change user language based on selected locale
              _languageStore.changeLanguage(object.locale);
            },
          ),
        )
            .toList(),
      ),
    );
  }

  void _showBottomSheet() async {
    await _loadRoleList();
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
                  "Bộ lọc người dùng",
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
                  "Vai trò",
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
      items: _roles,
      hint: Text("Chọn vai trò"),
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