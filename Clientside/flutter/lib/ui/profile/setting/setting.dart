import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: _buildAppBar(),
            body: _buildBody()
          ),
        )

    );;
  }
  Widget _buildAppBar(){
    return AppBar(
      leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
          onPressed: (){setState(() {
            Navigator.pop(context);
          });}),
      centerTitle: true,
      title: Text("Cài đặt")
    );
  }

  Widget _buildBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildChangePassword(),
        _buildLogOut(),
      ],
    );

  }

  Widget _buildChangePassword(){
    return CardItem(
      text: "Đổi mật khẩu",
      icon: Icons.security_outlined,
      colorbackgroud: Colors.grey[200],
      colortext: Colors.black,
      coloricon: Colors.amber,
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
      colorbackgroud: Colors.grey[200],
      colortext: Colors.black,
      coloricon: Colors.amber,
      isFunction: true,
      press: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          preference.setString(Preferences.auth_token, "");
          ///Navigator.of(context).pushReplacementNamed(Routes.login);
          Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
        });
      },
    );
  }
}