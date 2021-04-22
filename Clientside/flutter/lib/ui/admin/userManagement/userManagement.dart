import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/language/language_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/stores/admin/userManagement/userManagement_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserManagementScreen extends StatefulWidget {
  @override
  _UserManagementScreenState createState() => _UserManagementScreenState();
}

class _UserManagementScreenState extends State<UserManagementScreen> {
  //stores:---------------------------------------------------------------------
  UserManagementStore _userManagementStore;
  ThemeStore _themeStore;
  LanguageStore _languageStore;

  _onClickItemUsers(var userSelected) {

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _languageStore = Provider.of<LanguageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _userManagementStore = Provider.of<UserManagementStore>(context);

    // check to see if already called api
    if (!_userManagementStore.loading) {
      _userManagementStore.getUsers();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Danh sách người dùng",
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),

      body: _buildBody(),
    );
  }



  // // app bar methods:-----------------------------------------------------------
  // Widget _buildAppBar() {
  //   return AppBar(
  //     title: Text(AppLocalizations.of(context).translate('TestUsers')),
  //     actions: _buildActions(context),
  //   );
  // }
  //
  // List<Widget> _buildActions(BuildContext context) {
  //   return <Widget>[
  //     // _buildLanguageButton(),
  //     // _buildThemeButton(),
  //     _buildLogoutButton(),
  //   ];
  // }
  //
  // Widget _buildThemeButton() {
  //   return Observer(
  //     builder: (context) {
  //       return IconButton(
  //         onPressed: () {
  //           _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
  //         },
  //         icon: Icon(
  //           _themeStore.darkMode ? Icons.brightness_5 : Icons.brightness_3,
  //         ),
  //       );
  //     },
  //   );
  // }
  //
  // Widget _buildLanguageButton() {
  //   return IconButton(
  //     onPressed: () {
  //       _buildLanguageDialog();
  //     },
  //     icon: Icon(
  //       Icons.language,
  //     ),
  //   );
  // }
  //
  // Widget _buildLogoutButton() {
  //   return IconButton(
  //     onPressed: () {
  //       SharedPreferences.getInstance().then((preference) {
  //         preference.setBool(Preferences.is_logged_in, false);
  //         Navigator.of(context).pushReplacementNamed(Routes.login);
  //       });
  //     },
  //     icon: Icon(
  //       Icons.power_settings_new,
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
            : Material(child: _buildListView());
      },
    );
  }

  Widget _buildListView() {
    return _userManagementStore.userList != null
        ? ListView.separated(
      itemCount: _userManagementStore.userList.users.length,
      separatorBuilder: (context, position) {
        return Divider();
      },
      itemBuilder: (context, position) {
        return _buildListItem(position);
      },
    )
        : Center(
      child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy người dùng nào!",
      ),
    );
  }

  Widget _buildListItem(int position) {
    return ListTile(
      dense: true,
      leading: Icon(Icons.people_alt, size: 30, color: Colors.black,),
      title: Text(
        '${_userManagementStore.userList.users[position].name}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
        style: Theme.of(context).textTheme.title,
      ),
      subtitle: Text(
        '${_userManagementStore.userList.users[position].permissions}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        softWrap: false,
      ),
      onTap: _onClickItemUsers(_userManagementStore.userList.users[position]),
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

  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }
}