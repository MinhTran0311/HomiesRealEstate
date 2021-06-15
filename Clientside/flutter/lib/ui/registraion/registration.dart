import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';
import 'package:boilerplate/widgets/generalMethods.dart';

import 'package:google_fonts/google_fonts.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  AuthTokenStore _authTokenStore;
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
    _authTokenStore = Provider.of<AuthTokenStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Đăng ký",
      ),),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        // Container(
        //   decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topCenter,
        //           end: Alignment.bottomCenter,
        //           colors: [
        //             Colors.amber,
        //             Colors.orange[700],
        //           ]
        //       )
        //   ),
        // ),
        MediaQuery.of(context).orientation == Orientation.landscape
            ? Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: _buildLeftSide(),
            ),
            Expanded(
              flex: 1,
              child: _buildRightSide(),
            ),
          ],
        ) :  _buildRightSide(),
        Observer(
          builder: (context) {
            if (_store.regist_success) {
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool(Preferences.is_logged_in, false);
              });
              Future.delayed(Duration(milliseconds: 0), () {
                Navigator.of(context).pop();
              });
              showSuccssfullMesssage("Đăng ký thành công",context);
              return Container(width: 0, height: 0);
            } else {
              return showErrorMessage(_store.errorStore.errorMessage,context);
            }
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _store.regist_loading,
              child: CustomProgressIndicatorWidget(),
            );
          },
        )
      ],
    );
  }

  Widget _buildLeftSide() {
    return SizedBox.expand(
      child: Image.asset(
        Assets.carBackground,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildRightSide() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            //AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            _buildSurnameField(),
            SizedBox(height: 24.0),
            _buildNameField(),
            SizedBox(height: 24.0),
            _buildUserEmail(),
            SizedBox(height: 24.0),
            _buildUserNameField(),
            SizedBox(height: 24.0),
            _buildPasswordField(),
            SizedBox(height: 24.0),
            _buildConfirmPasswordField(),
            SizedBox(height: 24.0),
            _buildSignUpButton(),
          ],
        ),
      ),
    );
  }
//#region build TextFieldWidget
  Widget _buildSurnameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Họ'),
          hintColor: Colors.grey,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _surnameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          // onChanged: (value) {
          //   _store.setSurname(_surnameController.text);
          // },
          // errorText: _store.formErrorStore.surname,
          labelText: "Họ",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setSurname(_surnameController.text);
            return _store.formErrorStore.surname;},
        );
      },
    );
  }
  Widget _buildNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Tên'),
          hintColor: Colors.grey,
          icon: Icons.person_add,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          // onChanged: (value) {
          //   _store.setName(_nameController.text);
          // },
          // errorText: _store.formErrorStore.name,
          labelText: "Tên",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setName(_nameController.text);
            return _store.formErrorStore.name;},
        );
      },
    );
  }
  Widget _buildUserNameField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Tên đăng nhập'),
          hintColor: Colors.grey,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          // onChanged: (value) {
          //   _store.setUserId(_userNameController.text);
          // },
          // errorText: _store.formErrorStore.username,
          labelText: "Tên đăng nhập",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setUserId(_userNameController.text);
            return _store.formErrorStore.username;},
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
          hintColor: Colors.grey,
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: Colors.amber,
          textController: _passwordController,
          focusNode: _passwordFocusNode,
          // errorText: _store.formErrorStore.password,
          // onChanged: (value) {
          //   _store.setPassword(_passwordController.text);
          // },
          labelText: "Mật khẩu",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setPassword(_passwordController.text);
            return _store.formErrorStore.password;},

        );
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Nhập lại mật khẩu'),
          hintColor: Colors.grey,
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: Colors.amber,
          textController: _confirmPasswordController,
          autoFocus: false,
          // errorText: _store.formErrorStore.confirmPassword,
          // onChanged: (value) {
          //   _store.setConfirmPassword(_confirmPasswordController.text);
          // },
          labelText: "Nhập lại mật khẩu",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setConfirmPassword(_confirmPasswordController.text);
            return _store.formErrorStore.confirmPassword;},
        );
      },
    );
  }


  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Email'),
          hintColor: Colors.grey,
          icon: Icons.email_rounded,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          // onChanged: (value) {
          //   _store.setUserEmail(_userEmailController.text);
          // },
          // errorText: _store.formErrorStore.userEmail,
          labelText: "Email",
          isDarkmode: _themeStore.darkMode,
          suffixIcon: Icon(Icons.clear),
          errorMessage: (value){
            _store.setUserEmail(_userEmailController.text);
            return _store.formErrorStore.userEmail;},
        );
      },
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Đăng ký'),
      buttonColor: Colors.black87,
      textColor: Colors.white,
      onPressed: () {
        if(_store.canRegister) {
          DeviceUtils.hideKeyboard(context);
          _store.register();
          //showSuccssfullMesssage("Đăng ký thành công",context);
        }
        else{
          showErrorMessage('Hãy điền đầy đủ thông tin',context);
        }
        //});
      },
    );
  }
//endregion

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, false);
    });
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
    });
    return Container();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    _surnameController.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _userEmailController.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

}
