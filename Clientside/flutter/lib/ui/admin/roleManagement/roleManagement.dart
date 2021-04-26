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
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:boilerplate/ui/admin/userManagement/filterUser.dart';
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';

class RoleManagementScreen extends StatefulWidget {
  @override
  _RoleManagementScreenState createState() => _RoleManagementScreenState();
}

class _RoleManagementScreenState extends State<RoleManagementScreen> {
  RoleManagementStore _roleManagementStore;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Quản lý vai trò",
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      // body: _buildBody(),
    );
  }
}