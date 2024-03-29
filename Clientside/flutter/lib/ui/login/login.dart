import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';


class LoginScreen extends StatefulWidget {
  @override

  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  UserStore _userStore;
  //focus node:-----------------------------------------------------------------
  FocusNode _passwordFocusNode;

  //stores:---------------------------------------------------------------------
  final FormStore _store = new FormStore();

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _userStore = Provider.of<UserStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: EmptyAppBar(),
      body: Stack(
        children: <Widget>[
          _handleErrorMessage(),
          _buildBody(),
        ]
      )
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.amber,
                      Colors.orange[700],
                    ]
                )
            ),
          ),
           Center(child: _buildRightSide()),

          Observer(
            builder: (context) {
              return _store.loggedIn && _store.getCurrentUserRoleSuccess
                  ? navigate(context, true)
                  : showErrorMessage(_store.errorStore.errorMessage,context);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.loading,
                child: CustomProgressIndicatorWidget(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            SizedBox(height: 24.0),
            _buildUserIdField(),
            _buildPasswordField(),
            _buildForgotPasswordButton(),
            _buildSignInButton(),
            _buildSignUpButton(),
            _buildContinueAsGuestButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserIdField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Tên đăng nhập'),
          // labelText: ('Tên đăng nhập'),
          hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.white,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userNameController.text);
          },
          onFieldSubmitted: (value) {
            FocusScope.of(context).requestFocus(_passwordFocusNode);
          },
          //errorText: _store.formErrorStore.username,
          errorMessage: (value){return  _store.formErrorStore.username;},
        );
      },
    );
  }

  Widget _buildPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Mật khẩu'),
          hintColor: Colors.white,
          isObscure: true,
          padding: EdgeInsets.only(top: 16.0),
          icon: Icons.vpn_key,
          iconColor: Colors.white,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          // errorText: _store.formErrorStore.password,
          errorMessage: (value){return  _store.formErrorStore.password;},
          onChanged: (value) {
            _store.setPassword(_passwordController.text);
          },
        );
      },
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: FractionalOffset.centerRight,
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Text(
          "Quên mật khẩu?",
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(color: Colors.white),
        ),
        onPressed: () {
          SharedPreferences.getInstance().then((preference) {
            preference.setBool(Preferences.is_logged_in, false);
            Navigator.pushNamed(context, '/resetPassword');
          });
        },
      ),
    );
  }

  Widget _buildSignInButton() {
    return RoundedButtonWidget(
      buttonText: ('Đăng nhập'),
      buttonColor: Colors.amber,
      textColor: Colors.white,
      onPressed: () async {
        if (_store.canLogin) {
          DeviceUtils.hideKeyboard(context);
          _store.authLogIn(_userNameController.text,_passwordController.text);
          //_authTokenStore.authLogIn(_store.userEmail, _store.password);
        } else {
          showErrorMessage('Hãy nhập đầy đủ thông tin',context);
        }
      },
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Đăng ký'),
      buttonColor: Colors.black87,
      textColor: Colors.white,
      onPressed: () {
        SharedPreferences.getInstance().then((preference) {
          preference.setBool(Preferences.is_logged_in, false);
          //Navigator.of(context).pushNamedAndRemoveUntil(Routes.signup, (Route<dynamic> route) => false);
          Navigator.pushNamed(context, '/signup');
        });
      },
    );
  }

  Widget _buildContinueAsGuestButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 54,vertical: 8),
      child: FlatButton(
        padding: EdgeInsets.all(0.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.info,
              color: Colors.white,
            ),
            SizedBox(width: 5,),
            Text(
              "Tiếp tục với tư cách khách",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.white),
            ),
          ],
        ),
        onPressed: () {
          SharedPreferences.getInstance().then((preference) {
            preference.setBool(Preferences.is_logged_in, false);
            preference.setString(Preferences.auth_token, "");
          });
          Preferences.userRole="";
          Preferences.userRoleRank=0;
          navigate(context, false);
        },
      ),
    );
  }

  Widget navigate(BuildContext context, bool isLoggedIn) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, isLoggedIn);
    });
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Routes.home, (Route<dynamic> route) => false);
    });

    return Container();
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_store.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(_store.errorStore.errorMessage,context);
        }
        return SizedBox.shrink();
      },
    );
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _userNameController.dispose();
    _passwordController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

}
