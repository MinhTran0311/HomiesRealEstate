import 'dart:convert';
import 'dart:typed_data';
import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
import 'package:boilerplate/ui/admin/management.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:boilerplate/ui/admin/userManagement/filterUser.dart';
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';
import 'package:boilerplate/ui/admin/userManagement/createOrEditUser.dart';

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

  TextEditingController _searchController = new TextEditingController();

  var _selectedValue;
  var _selectedValueAfterTouchBtn;
  var _roles = List<DropdownMenuItem>();
  var _listUserFilterFromRole = List<User>();
  var userChoosen;
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final ScrollController _scrollController =
  ScrollController(keepScrollOffset: true);
  bool isRefreshing = false;
  // ↓ hold tap position, set during onTapDown, using getPosition() method
  Offset tapXY;
  // ↓ hold screen size, using first line in build() method
  RenderBox overlay;
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
      _userManagementStore.isIntialLoading = true;
      _userManagementStore.setStringFilter('');
      _userManagementStore.getUsers(false);
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
    overlay = Overlay.of(context).context.findRenderObject();
    return Scaffold(
      primary: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Quản lý người dùng",),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.person_add_alt_1,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateOrEditUserScreen()),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
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
        print(_userManagementStore.isIntialLoading);
        return (_userManagementStore.loading || _userManagementStore.loadingAvatar)
            ? CustomProgressIndicatorWidget()
            : _buildUsersList();
        // FutureBuilder(
        //     future: Future.delayed(Duration(seconds: 3)),
        //     builder: (c, s) => (s.connectionState == ConnectionState.done || _userManagementStore.isIntialLoading)
        //         ? _buildUsersList()
        //         : CustomProgressIndicatorWidget());

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
              // color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            onSubmitted: (value) {
              _userManagementStore.isIntialLoading = true;
              _userManagementStore.getUsers(false);
            },
            onChanged: (value) {
              _userManagementStore.setStringFilter(_searchController.text);
            },
            controller: _searchController,
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
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 28,
                    ),
                    onPressed: () {
                      _userManagementStore.isIntialLoading = true;
                      _userManagementStore.getUsers(false);
                    },
                  ),
                )
            ),
          ),
        ),
        Expanded(child: _buildListView()),
      ],
    );
  }

  Widget _buildListView() {
    return _userManagementStore.userList != null
        ? SmartRefresher(
        //key: _refresherKey,
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: WaterDropHeader(
          refresh: SizedBox(
            width: 25.0,
            height: 25.0,
            child: Icon(
              Icons.flight_takeoff_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
          idleIcon: SizedBox(
            width: 25.0,
            height: 25.0,
            child: Icon(
              Icons.flight_takeoff_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
          waterDropColor: Colors.amber,
        ),
        physics: BouncingScrollPhysics(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onLoading: () async {
          _userManagementStore.getUsers(true);
          while(_userManagementStore.loadingAvatar && !_userManagementStore.isIntialLoading){
          }
          await Future.delayed(Duration(milliseconds: 3000));
          if (mounted) {
            setState(() {});
          }
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );
          _refreshController.loadComplete();
        },
        onRefresh: () async {
          print("refresh");
          _userManagementStore.getUsers(false);

          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) setState(() {});
          isRefreshing = true;
          _refreshController.refreshCompleted();
        },
        //scrollController: _scrollController,
        primary: false,
        child: ListView.builder(
          //key: _contentKey,
          controller: _scrollController,
          itemCount: _userManagementStore.userList.users.length,
          // separatorBuilder: (context, position) {
          //   return Divider();
          // },
          itemBuilder: (context, position) {
            return _buildListItem(
                _userManagementStore.userList.users[position], position);
            //_buildListItem(position);
          },
        ),
      )
        : Center(
      child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy người dùng nào!",
      ),
    );
  }


  Widget _buildListItem(User user, int position) {
    return ListTile(
      leading: _userManagementStore.userList.users[position].avatar == null ? CircleAvatar(
        backgroundColor: Colors.amber.shade800,
        child: Text((_userManagementStore.userList.users[position].surName.substring(0,1) + _userManagementStore.userList.users[position].name.substring(0,1)).toUpperCase(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      )
          : CircleAvatar(
        child: ClipOval(child: _userManagementStore.userList.users[position].avatarImage),
        backgroundColor: Colors.brown.shade800,
      ),
      title: Text(
        _userManagementStore.userList.users[position].name,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        _userManagementStore.userList.users[position].email,
        style: TextStyle(
          color: Colors.grey,
        ),
      ),
      onTap: (){
        this.userChoosen = _userManagementStore.userList.users[position];
        _showSimpleModalDialog(context, _userManagementStore.userList.users[position]);
      },
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

  _showSimpleModalDialog(context, User user){
    showModalBottomSheet(
      // backgroundColor: Colors.red,
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            )
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      // Colors.blue,
                      // Colors.red,
                      Colors.orange.shade700,
                      Colors.amberAccent.shade100,
                    ],
                  )
                ),
                // padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                        children:[
                          Container(
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              // mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.arrow_back_ios_outlined,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    user.avatar == null ? CircleAvatar(
                                      backgroundColor: Colors.white,
                                      maxRadius: 50,
                                      minRadius: 25,
                                      child: Text((user.surName.substring(0,1) + user.name.substring(0,1)).toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 35,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    )
                                        : CircleAvatar(
                                      maxRadius: 50,
                                      minRadius: 25,
                                      // child: imageFromBase64String(user.profilePictureID),
                                      child: ClipOval(child: user.avatarImage),
                                      backgroundColor: Colors.brown.shade800,
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.menu,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                      onPressed: () {
                                        _showPopupMenu();
                                      },
                                    )
                                  ],
                                ),
                                SizedBox(height: 17,),
                                Text(
                                  "${user.surName} " + "${user.name} ",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person_pin,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                    SizedBox(width: 10,),
                                    Text(
                                      "${user.permissions}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(20),
                          ),
                        ]
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topRight,
                        //   end: Alignment.bottomLeft,
                        //   colors: [
                        //     // Colors.blue,
                        //     // Colors.red,
                        //     Colors.orange.shade700,
                        //     Colors.amberAccent.shade100,
                        //   ],
                        // )
                        color: _themeStore.darkMode ? AppColors.backgroundDarkThemeColor : AppColors.backgroundLightThemeColor,
                      ),
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.only(bottom: 10),
                      // padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                      // color: Colors.white,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(25),
                                //   topRight: Radius.circular(25),
                                // ),
                                border: Border(
                                  bottom: BorderSide( //                   <--- left side
                                    color: Colors.amber,
                                    width: 1.0,
                                  ),
                                  // top: BorderSide( //                    <--- top side
                                  //   color: Colors.amber,
                                  //   width: 1.0,
                                  // ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Colors.amber,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Tài khoản",
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        // alignment: Alignment.centerRight,
                                        "${user.userName}",
                                        // "00000000000000000000000000000000000000",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      user.isActive == false ? Icon(
                                        Icons.cancel,
                                        color: Colors.red,
                                        size: 24,
                                      ) : Icon (
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 24,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.mail,
                                          color: Colors.amber,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Email",
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 5,),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    child:
                                      Text(
                                        // alignment: Alignment.centerRight,
                                        "${user.email}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                user.isEmailConfirmed == false ? Container(
                                  padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 20),
                                  child: Row(
                                      children: [
                                        Text("Chưa xác nhận",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                        SizedBox(width: 10,),
                                        Icon(
                                          Icons.warning_rounded,
                                          color: Colors.red,
                                          size: 24,
                                        ),
                                      ]
                                  ),
                                ) : Container(
                                  padding: EdgeInsets.only(top: 5, left: 15, right: 15, bottom: 20),
                                  child: Row(
                                      children: [
                                        Text("Đã xác nhận",
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),),
                                        SizedBox(width: 10,),
                                        Icon (
                                          Icons.check_circle,
                                          color: Colors.green,
                                          size: 24,
                                        ),
                                      ]
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height: 30,),
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide( //                   <--- left side
                                    color: Colors.amber,
                                    width: 1.0,
                                  ),
                                  top: BorderSide( //                    <--- top side
                                    color: Colors.amber,
                                    width: 1.0,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.phone,
                                          color: Colors.amber,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Điện thoại",
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  (user.phoneNumber == null || user.phoneNumber.isEmpty) ?
                                  Text(
                                    // alignment: Alignment.centerRight,
                                    "****",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                      :Text(
                                    // alignment: Alignment.centerRight,
                                    "${user.phoneNumber}",
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide( //                   <--- left side
                                    color: Colors.amber,
                                    width: 1.0,
                                  ),
                                  // top: BorderSide( //                    <--- top side
                                  //   color: Colors.amber,
                                  //   width: 1.0,
                                  // ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.timelapse,
                                          color: Colors.amber,
                                          size: 28,
                                        ),
                                        SizedBox(width: 10,),
                                        Text(
                                          "Ngày tham gia",
                                          style: TextStyle(
                                            color: Colors.amber,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    // alignment: Alignment.centerRight,
                                    "${_handlingStringCreationTime(user.creationTime)}",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                                // decoration: BoxDecoration(
                                //   border: Border(
                                //     bottom: BorderSide( //                   <--- left side
                                //       color: Colors.amber,
                                //       width: 1.0,
                                //     ),
                                //     // top: BorderSide( //                    <--- top side
                                //     //   color: Colors.amber,
                                //     //   width: 1.0,
                                //     // ),
                                //   ),
                                // ),
                                child: ElevatedButton(
                                  child: Text(
                                    "Chỉnh sửa thông tin",
                                    style: TextStyle(fontSize: 22,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  style: ButtonStyle(
                                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(18)),
                                            side: BorderSide(color: Colors.red),
                                          )
                                      )
                                  ),
                                  onPressed: () async {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => CreateOrEditUserScreen(user: user)),
                                    );
                                  },
                                )
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
      buttonColor: Colors.amber,
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

  _showPopupMenu(){
    getPosition;
    showMenu<String>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),

      // builder: (BuildContext context){
      //   return Wrap(
      //     children: [
      //       buildFilterAdvance(),
      //     ],
      //   );
      // }
      position: RelativeRect.fromLTRB(25.0, 0.0, 0.0, 0.0),      //position where you want to show the menu on screen
      // position: relRectSize,
      items: [
        PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(
                  Icons.edit,
                  size: 20,
                ),
                SizedBox(width: 10,),
                Text("Chỉnh sửa",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            value: '1'),
        PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(
                  Icons.people_alt,
                  size: 20,
                ),
                SizedBox(width: 10,),
                Text("Quyền",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            value: '2'),
        PopupMenuItem<String>(
            child: Row(
              children: [
                Icon(
                  Icons.delete_rounded,
                  size: 20,
                ),
                SizedBox(width: 10,),
                Text("Xóa bỏ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )
              ],
            ),
            value: '3'),
      ],
      elevation: 8.0,
    )
        .then<void>((String itemSelected) {

      if (itemSelected == null) return;

      if(itemSelected == "1"){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CreateOrEditUserScreen(user: this.userChoosen)),
        );
      }else if(itemSelected == "2"){
        //code here
      }else{
        _showSimpleModalDialogConfirmDelete(context, this.userChoosen);
      }

    });
  }

  RelativeRect get relRectSize => RelativeRect.fromSize(tapXY & const Size(40,40), overlay.size);

  void getPosition(TapDownDetails detail) {
    tapXY = detail.globalPosition;
  }

  String _handlingStringCreationTime(String time) {
    if (time.isEmpty)
      return '';
    else {
      String nam = time.substring(0,4);
      String thang = time.substring(5,7);
      String ngay = time.substring(8,10);
      // String gio = time.substring(11,13);
      // String phut = time.substring(14,16);
      // String giay = time.substring(17,19);
      return ngay + "/" + thang + "/" + nam;
    }
  }

  _showSimpleModalDialogConfirmDelete(context, User user){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:BorderRadius.circular(12.0)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  // constraints: user.name == "admin" ? BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.25,) : BoxConstraints(maxHeight: MediaQuery.of(context).size.height*0.35,),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12.0, left: 18,top: 12, bottom: 16),
                    child: Container(
                      child: Stack(
                          children: [
                            user.name == "admin" ? Positioned(
                              right: 0.0,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                    radius: 14.0,
                                    backgroundColor: Colors.grey.shade300,
                                    child: Icon(Icons.close, color: Colors.red),
                                  ),
                                ),
                              ),
                            ) : Container(),
                            Column(
                              children: [
                                Icon(
                                  Icons.warning_rounded,
                                  size: MediaQuery.of(context).size.width*0.2,
                                  color: Colors.red,
                                ),
                                SizedBox(height: 10,),
                                (user.name == "admin") ?
                                Text(
                                  "Bạn không thể xóa người dùng này!",
                                  style: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                )
                                    : Text(
                                  "Bạn có chắc muốn xóa người dùng này?",
                                  style: TextStyle(
                                    fontSize: 18,
                                    // fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10,),
                                user.name != "admin" ? Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      child: Text(
                                        "Xóa",
                                        style: TextStyle(fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                                side: BorderSide(color: Colors.red),
                                              )
                                          )
                                      ),
                                      onPressed: () {
                                        // _userManagementStore.deleteUser(user.id);
                                      },
                                    ),
                                    // SizedBox(width: 10,),
                                    ElevatedButton(
                                      child: Text(
                                        "Hủy bỏ",
                                        style: TextStyle(fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      style: ButtonStyle(
                                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                          backgroundColor: MaterialStateProperty.all<Color>(Colors.grey.shade400),
                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                                side: BorderSide(color: Colors.red),
                                              )
                                          )
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    )
                                  ],
                                ) : Container()
                              ],
                            ),
                          ]
                      ),
                    )
                  ),
                ),
              ],
            ),
          );
        });
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchController.dispose();
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }
}