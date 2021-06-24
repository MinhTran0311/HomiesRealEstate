import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/post/filter_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes.dart';
import 'changePassword/changePassword.dart';

class SettingPage extends StatefulWidget {
  SettingPage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  _SettingPageState({
    Key key,
  }) : super();
  ThemeStore _themeStore;
  FilterStore _filterStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _themeStore = Provider.of<ThemeStore>(context);
    _filterStore = Provider.of<FilterStore>(context);

  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: _buildBody()
    );
  }
  Widget _buildAppBar(){
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: (){
            Navigator.pop(context);
          }),
      title: Text("Cài đặt"),
    );
  }

  Widget _buildBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildChangeBrightMode(),
        _buildChangePassword(),
        _buildLogOut(),
      ],
    );
  }

  Widget _buildChangeBrightMode(){
    return Observer(
        builder: (context){
          return Stack(
              children:[
                CardItem(
                  text: "Đổi chế độ nền ${_themeStore.darkMode ? "sáng" : "tối"}",
                  icon: _themeStore.darkMode ? Icons.nights_stay_outlined : Icons.wb_sunny_outlined,
                  isFunction: true,
                  press: () {
                    //Preferences.is_dark_mode=!_themeStore.darkMode;
                    _themeStore.changeBrightnessToDark(!_themeStore.darkMode);
                  },
                ),
              ]
          );
        }
    );
  }

  Widget _buildChangePassword(){
    return CardItem(
      text: "Đổi mật khẩu",
      icon: Icons.security_outlined,
      isFunction: false,
      press: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => changePassWordPage()));
      },
    );
  }

  Widget _buildLogOut(){
    return CardItem(
      text: "Đăng xuất",
      icon: Icons.logout,
      isFunction: true,
      press: () {
        var future = showSimpleModalDialog(context, "Bạn có chắc chắn muốn đăng xuất không?");
        future.then((value) {
          if (value)  {
            SharedPreferences.getInstance().then((preference) {
              preference.setBool(Preferences.is_logged_in, false);
              preference.setString(Preferences.auth_token, "");
            });
            Preferences.userRole="";
            Preferences.userRoleRank=0;
            _filterStore.resetValue();
            Preferences.userRole="";
            _themeStore.changeBrightnessToDark(false);
            Preferences.grantedPermissions.clear();
            Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
          };
        });
        return;
      },
    );
  }
}