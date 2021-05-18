import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/stores/token/authToken_store.dart';

import 'package:google_fonts/google_fonts.dart';

class CreateOrEditUserScreen extends StatefulWidget {
  final User user;
  @override
  CreateOrEditUserScreen({@required this.user});
  _CreateOrEditUserScreenScreenState createState() => _CreateOrEditUserScreenScreenState(user: user);
}

class _CreateOrEditUserScreenScreenState extends State<CreateOrEditUserScreen> {
  final User user;
  _CreateOrEditUserScreenScreenState({@required this.user});

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
  bool _checkbox = true;
  bool _checkboxNeedChangePs = true;
  bool _checkboxSendEmailActive = true;
  bool _checkboxActive = true;
  String titleForm = "Tạo tài khoản mới";

  @override
  void initState() {
    super.initState();
    _passwordFocusNode = FocusNode();

    if(this.user != null) {
      _surnameController.text = "${this.user.surName}";
      _nameController.text = "${this.user.name}";
      _userNameController.text = "${this.user.userName}";
      _userEmailController.text = "${this.user.email}";
      titleForm = "Chỉnh sửa tài khoản";
    }
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,
          color: Colors.white,),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserManagementScreen()),
            );
          },
        ),
        title: Text(
          this.titleForm,
          style: Theme.of(context).textTheme.button.copyWith(color: Colors.white,fontSize: 23,fontWeight: FontWeight.bold,letterSpacing: 1.0),),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),

      body: _buildBody(),
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
          ) : Center(child: _buildRightSide()),
          Observer(
            builder: (context) {
              if (_store.regist_success) {

                SharedPreferences.getInstance().then((prefs) {
                  prefs.setBool(Preferences.is_logged_in, false);
                });
                Future.delayed(Duration(milliseconds: 0), () {
                  Navigator.of(context).pop();
                });
                _showSuccssfullMesssage("Đăng ký thành công");
                return Container(width: 0, height: 0);

              } else {
                return _showErrorMessage(_store.errorStore.errorMessage);
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
      ),
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
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            //AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            //SizedBox(height: 24.0),
            _buildSurnameField(),
            SizedBox(height: 24.0),
            _buildNameField(),
            SizedBox(height: 24.0),
            _buildUserEmail(),
            SizedBox(height: 24.0),
            _buildUserNameField(),
            SizedBox(height: 24.0),
            _buildPasswordField(),
            !this._checkbox ? SizedBox(height: 24.0) : SizedBox(),
            _buildConfirmPasswordField(),
            !this._checkbox ? SizedBox(height: 24.0) : SizedBox(),
            _buildAutoPasswordCheckBox(),
            SizedBox(height: 24.0),
            _buildNeedChangePwCheckBox(),
            SizedBox(height: 24.0),
            _buildSendEmailConfirmCheckBox(),
            SizedBox(height: 24.0),
            _buildActiveCheckBox(),
            SizedBox(height: 24.0),
            Container(
              width: MediaQuery.of(context).size.width/1.3,
              height: MediaQuery.of(context).size.height/2.5,
              child: MapsScreen(),
            ),
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
          hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _surnameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setSurname(_surnameController.text);
          },
          errorText: _store.formErrorStore.surname,
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
          hintColor: Colors.white,
          icon: Icons.person_add,
          inputType: TextInputType.text,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setName(_nameController.text);
          },
          errorText: _store.formErrorStore.name,
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
          hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userNameController.text);
          },
          errorText: _store.formErrorStore.username,
        );
      },
    );
  }

  Widget _buildAutoPasswordCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: _checkbox,
          onChanged: (value) {
            setState(() {
              _checkbox = !_checkbox;
            });
          },
        ),
        Text(
          'Đặt mật khẩu ngẫu nhiên',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildNeedChangePwCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: _checkboxNeedChangePs,
          onChanged: (value) {
            setState(() {
              _checkboxNeedChangePs = !_checkboxNeedChangePs;
            });
          },
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cần thay đổi mật khẩu vào lần đăng nhập tiếp theo',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ],
          )
        )
      ],
    );
  }

  Widget _buildSendEmailConfirmCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: _checkboxSendEmailActive,
          onChanged: (value) {
            setState(() {
              _checkboxSendEmailActive = !_checkboxSendEmailActive;
            });
          },
        ),
        Text(
          'Gửi email kích hoạt',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildActiveCheckBox() {
    return Row(
      children: [
        Checkbox(
          value: _checkboxActive,
          onChanged: (value) {
            setState(() {
              _checkboxActive = !_checkboxActive;
            });
          },
        ),
        Text(
          'Kích hoạt',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    if (!this._checkbox) {
      return TextFieldWidget(
        inputFontsize: 22,
        hint: ('Mật khẩu'),
        hintColor: Colors.white,
        isObscure: true,
        icon: Icons.vpn_key,
        iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
        textController: _passwordController,
        focusNode: _passwordFocusNode,
        errorText: _store.formErrorStore.password,
        onChanged: (value) {
          _store.setPassword(_passwordController.text);
        },
      );
    }
    else return Container();
  }

  Widget _buildConfirmPasswordField() {
    if (!this._checkbox) {
      return TextFieldWidget(
        inputFontsize: 22,
        hint: ('Nhập lại mật khẩu'),
        hintColor: Colors.white,
        isObscure: true,
        icon: Icons.vpn_key,
        iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
        textController: _confirmPasswordController,
        autoFocus: false,
        errorText: _store.formErrorStore.confirmPassword,
        onChanged: (value) {
          _store.setConfirmPassword(_confirmPasswordController.text);
        },
      );
    }
    else return Container();
  }


  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Email'),
          hintColor: Colors.white,
          icon: Icons.email_rounded,
          inputType: TextInputType.text,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserEmail(_userEmailController.text);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }
  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Lưu thông tin'),
      buttonColor: Colors.black87,
      textColor: Colors.white,
      onPressed: () {
        if(_store.canRegister) {
          DeviceUtils.hideKeyboard(context);

          //SharedPreferences.getInstance().then((preference) {
          // preference.setBool(Preferences.is_logged_in, false);
          //Navigator.of(context).pushNamedAndRemoveUntil(Routes.signup, (Route<dynamic> route) => false);
          _store.register();
        }
        else{
          _showErrorMessage('Please fill in all fields');
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

  // General Methods:-----------------------------------------------------------


  _showErrorMessage( String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 5),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }
  _showSuccssfullMesssage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: "Thông báo",
          duration: Duration(seconds: 5),
        )
            .show(context);
      }
      return SizedBox.shrink();
    });
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
