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
  TextEditingController _phoneNumberController = TextEditingController();

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
      _surnameController.text = this.user.surName;
      _nameController.text = this.user.name;
      _userNameController.text = this.user.userName;
      _userEmailController.text = this.user.email;
      _phoneNumberController.text = this.user.phoneNumber;
      _checkbox = this.user.isActive;
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
          icon: Icon(Icons.arrow_back_ios_outlined,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          this.titleForm,),
        automaticallyImplyLeading: false,
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
            // decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topCenter,
            //         end: Alignment.bottomCenter,
            //         colors: [
            //           Colors.amber,
            //           Colors.orange[700],
            //         ]
            //     )
            // ),
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
              if (_store.updateUser_success) {
                Future.delayed(Duration(milliseconds: 0), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserManagementScreen()),
                  );
                });
                _showSuccssfullMesssage("Cập nhật thành công");
                return Container(width: 0, height: 0);

              } else {
                return _showErrorMessage(_store.errorStore.errorMessage);
              }
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.updateUserLoading,
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
            _buildNumberPhoneField(),
            SizedBox(height: 24.0),
            _buildPasswordField(),
            SizedBox(height: 24.0),
            _buildConfirmPasswordField(),
            SizedBox(height: 24.0),
            _buildActiveCheckBox(),
            SizedBox(height: 24.0),
            // _buildNeedChangePwCheckBox(),
            // SizedBox(height: 24.0),
            // _buildSendEmailConfirmCheckBox(),
            // SizedBox(height: 24.0),
            // _buildActiveCheckBox(),
            // SizedBox(height: 24.0),
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
          isDarkmode: _themeStore.darkMode,
          labelText: 'Họ',
          hint: ('Nhập họ'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
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
          hint: ('Nhập tên'),
          isDarkmode: _themeStore.darkMode,
          labelText: 'Tên',
          // hintColor: Colors.white,
          icon: Icons.person_add,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
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

  Widget _buildNumberPhoneField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Nhập điện thoại'),
          isDarkmode: _themeStore.darkMode,
          labelText: 'Điện thoại',
          // hintColor: Colors.white,
          icon: Icons.phone,
          inputType: TextInputType.phone,
          iconColor: Colors.amber,
          textController: _phoneNumberController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setPhoneNumber(_phoneNumberController.text);
          },
          // errorText: _store.formErrorStore.name,
          errorMessage: (value) {
            if (value == null || value.isEmpty)
            {
              return "Vui lòng nhập số điện thoại";
            }
            return null;
          },
        );
      },
    );
  }

  Widget _buildUserNameField() {
    return Observer(
      builder: (context) {
        return this.user != null ? TextFieldWidget(
          inputFontsize: 22,
          labelText: 'Tên đăng nhập',
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userNameController.text);
          },
          enable: false,
          errorText: _store.formErrorStore.username,
        ) : TextFieldWidget(
          inputFontsize: 22,
          labelText: 'Tên đăng nhập',
          hint: ('Nhập tên đăng nhập'),
          isDarkmode: _themeStore.darkMode,
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserId(_userNameController.text);
          },
          enable: true,
          errorText: _store.formErrorStore.username,
        );
      },
    );
  }

  Widget buildRadioBtn(BuildContext context) {
    // return Column(
    //   children: <Widget>[
    //     ListTile(
    //       title: const Text('Lafayette'),
    //       leading: Radio(
    //         value: i,
    //         groupValue: _value,
    //         activeColor: Color(0xFF6200EE),
    //         onChanged: ,
    //       ),
    //     ),
    //     ListTile(
    //       title: const Text('Thomas Jefferson'),
    //       leading: Radio<SingingCharacter>(
    //         value: SingingCharacter.jefferson,
    //         groupValue: _character,
    //         onChanged: (SingingCharacter? value) {
    //           setState(() {
    //             _character = value;
    //           });
    //         },
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildActiveCheckBox() {
    return Row(
      children: [
        Checkbox(
          activeColor: Colors.amber,
          value: _checkbox,
          onChanged: (value) {
            setState(() {
              _store.setIsActive(!_checkbox);
              _checkbox = !_checkbox;
            });
          },
        ),
        Text(
          'Kích hoạt',
          style: TextStyle(
            fontSize: 20,
            // color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return TextFieldWidget(
      inputFontsize: 22,
      labelText: ('Mật khẩu'),
      hint: ('Nhập mật khẩu'),
      isDarkmode: _themeStore.darkMode,
      // hintColor: Colors.white,
      isObscure: true,
      icon: Icons.vpn_key,
      iconColor: Colors.amber,
      textController: _passwordController,
      focusNode: _passwordFocusNode,
      errorText: _store.formErrorStore.password,
      onChanged: (value) {
        _store.setPassword(_passwordController.text);
      },
      errorMessage: (value){
        if (this.user == null)
        {
          if(value == null || value.isEmpty)
            return "Vui lòng nhập mật khẩu";
          else if (value.length < 6) {
            return "Mật khẩu phải có ít nhất 6 ký tự";
          }
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFieldWidget(
      inputFontsize: 22,
      labelText: "Xác nhận mật khẩu",
      isDarkmode: _themeStore.darkMode,
      hint: ('Nhập lại mật khẩu'),
      // hintColor: Colors.white,
      isObscure: true,
      icon: Icons.vpn_key,
      iconColor: Colors.amber,
      textController: _confirmPasswordController,
      autoFocus: false,
      errorText: _store.formErrorStore.confirmPassword,
      onChanged: (value) {
        _store.setConfirmPassword(_confirmPasswordController.text);
      },
    );
  }


  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          labelText: 'Email',
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          hint: ('Nhập địa chỉ email'),
          // hintColor: Colors.white,
          icon: Icons.email_rounded,
          inputType: TextInputType.emailAddress,
          iconColor: Colors.amber,
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
      buttonColor: Colors.amber,
      textColor: Colors.white,
      onPressed: () async {
         if(this.user != null) await {
          _store.setSurname(_surnameController.text),
          _store.setName(_nameController.text),
           _store.setUserId(_userNameController.text),
           _store.setUserEmail(_userEmailController.text),
           _store.setRoleName(this.user.roleName),
           if(_passwordController.text != null && _passwordController.text.isNotEmpty)
             {
               _store.setPassword(_passwordController.text),
               _store.setConfirmPassword(_confirmPasswordController.text),
             },
          //  else {
          //    _store.setPassword(this.user.),
          //    _store.setConfirmPassword(_confirmPasswordController.text),
          // },
           _store.setIdUser(this.user.id),
           _store.setPhoneNumber(_phoneNumberController.text),
           _store.setIsActive(_checkbox),
         };
         if(this.user != null) {
           if(_store.canUpdate) {
             DeviceUtils.hideKeyboard(context);
             _store.UpdateUser();
           }
           else{
             _showErrorMessage('Vui lòng nhập đầy đủ thông tin');
           }
         }
         else {
           if(_store.canCreate) {
             DeviceUtils.hideKeyboard(context);
             _store.CreateUser();
           }
           else{
             _showErrorMessage('Vui lòng nhập đầy đủ thông tin');
           }
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
