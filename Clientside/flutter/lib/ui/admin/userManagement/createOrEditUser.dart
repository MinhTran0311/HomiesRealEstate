import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/role/role.dart';
import 'package:boilerplate/models/role/role_list.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/userManagement/userManagement.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
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
import 'package:boilerplate/stores/admin/roleManagement/roleManagement_store.dart';


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
  RoleManagementStore _roleManagementStore;
  bool isFinishInit = true;

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
    _roleManagementStore = Provider.of<RoleManagementStore>(context);


    if (this.user != null && isFinishInit) {
      _store.setName(this.user.name);
      _store.setSurname(this.user.surName);
      _store.setIdUser(this.user.id);
      _store.setUserEmail(this.user.email);
      _store.setPhoneNumber(this.user.phoneNumber);
      _store.setIsActive(this.user.isActive);

      if (this.user.permissionsList != null && this.user.permissionsList.first["roleName"]!=null) {
        this.user.permissionsList.forEach((element) {
          _store.displayRoleName.add(element["roleName"]);
        });
      }
      else if (this.user.permissionsList != null && this.user.permissionsList.first["name"]!=null){
        this.user.permissionsList.forEach((element) {
          _store.displayRoleName.add(element["name"]);
        });
      }
      else
        _store.displayRoleName.clear();
      _store.setUserId(this.user.userName);
      isFinishInit=false;
    }

    if (!_roleManagementStore.loading) {
      _roleManagementStore.getRoles();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined,),
          onPressed: () {
            var future = showSimpleModalDialog(context, "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
            future.then((value) {
              if (value)  Navigator.of(context).pop();
            });
            return;
          },
        ),
        title: Text(
          this.titleForm,),
        automaticallyImplyLeading: false,
      ),

      body: WillPopScope(
        child: _buildBody(),
        onWillPop: () {
          var future = showSimpleModalDialog(context, "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
          future.then((value) {
            if (value)  Navigator.of(context).pop();
          });
          return;
        },
      ),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
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
            if (_store.updateUser_success || _store.createUser_success) {

              Navigator.of(context).pop(_setDataUser());
              if (_store.updateUser_success)
              {
                showSuccssfullMesssage("Cập nhật thành công", context);
                _store.updateUser_success = false;
              }
              else if(_store.createUser_success) {
                showSuccssfullMesssage("Thêm mới thành công",context);
                _store.createUser_success = false;
              }

              return Container(width: 0, height: 0);

            } else {
              return showErrorMessage(_store.errorStore.errorMessage, context);
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
            _buildChoosenRoles(),
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
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập họ'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _surnameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
             _store.setSurname(value);
            return _store.formErrorStore.surname;
          },
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
          suffixIcon: Icon(Icons.clear),
          labelText: 'Tên',
          // hintColor: Colors.white,
          icon: Icons.person_add,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _store.setName(value);
            return _store.formErrorStore.name;
          },
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
          suffixIcon: Icon(Icons.clear),
          // hintColor: Colors.white,
          icon: Icons.phone,
          inputType: TextInputType.phone,
          iconColor: Colors.amber,
          textController: _phoneNumberController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          // errorText: _store.formErrorStore.name,
          errorMessage: (value) {
            _store.setPhoneNumber(value);
            return _store.formErrorStore.phoneNumber;
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
          suffixIcon: Icon(Icons.clear),
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _userNameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          enable: true,
          errorMessage: (value) {
            _store.setUserId(value);
            return _store.formErrorStore.username;
          },
        );
      },
    );
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
      suffixIcon: Icon(Icons.clear),
      // hintColor: Colors.white,
      isObscure: true,
      icon: Icons.vpn_key,
      iconColor: Colors.amber,
      textController: _passwordController,
      focusNode: _passwordFocusNode,
      errorMessage: (value){
        if (this.user == null)
        {
          _store.setPassword(value);
          return _store.formErrorStore.password;
        }
        else if(value != null) {
          _store.setPassword(value);
          return _store.formErrorStore.password;
          }
        else return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFieldWidget(
      inputFontsize: 22,
      labelText: "Xác nhận mật khẩu",
      suffixIcon: Icon(Icons.clear),
      isDarkmode: _themeStore.darkMode,
      hint: ('Nhập lại mật khẩu'),
      // hintColor: Colors.white,
      isObscure: true,
      icon: Icons.vpn_key,
      iconColor: Colors.amber,
      textController: _confirmPasswordController,
      autoFocus: false,
      errorMessage: (value) {
        if (this.user == null)
        {
          _store.setConfirmPassword(value);
          return _store.formErrorStore.confirmPassword;
        }
        else if(value != null) {
          _store.setConfirmPassword(value);
          return _store.formErrorStore.confirmPassword;
        }
        else return null;
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
          suffixIcon: Icon(Icons.clear),
          // hintColor: Colors.white,
          icon: Icons.email_rounded,
          inputType: TextInputType.emailAddress,
          iconColor: Colors.amber,
          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            {
              _store.setUserEmail(value);
              return _store.formErrorStore.userEmail;
            }
          },
        );
      },
    );
  }

  Widget _buildChoosenRoles() {
    return Observer(
      builder: (context) {
        if (_roleManagementStore.roleList != null) {
          return Container(
            height: 230,
            child: ListView.builder(
                itemCount: _roleManagementStore.roleList.roles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    child: Container(
                      padding: new EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          CheckboxListTile(
                              activeColor: Colors.amber,
                              dense: true,
                              //font change
                              title: new Text(
                                _roleManagementStore.roleList.roles[index].displayName,
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 0.5),
                              ),
                              value: _store.displayRoleName.contains(_roleManagementStore.roleList.roles[index].name),
                              onChanged: (bool val) {
                                setState(() {
                                  if (val && !_store.displayRoleName.contains(_roleManagementStore.roleList.roles[index].name))
                                    _store.displayRoleName.add(_roleManagementStore.roleList.roles[index].name);
                                  else if (!val && _store.displayRoleName.contains(_roleManagementStore.roleList.roles[index].name))
                                    _store.displayRoleName.remove(_roleManagementStore.roleList.roles[index].name);
                                });
                              })
                        ],
                      ),
                    ),
                  );
                }),
          );
        }
        else return Container(
          height: 0,
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
           if(_passwordController.text != null && _passwordController.text.isNotEmpty) {
               _store.setPassword(_passwordController.text),
               _store.setConfirmPassword(_confirmPasswordController.text),
             },

         };
         if(this.user != null) {
           if(_store.canUpdate) {
             DeviceUtils.hideKeyboard(context);
             _store.UpdateUser();
           }
           else{
             showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
           }
         }
         else {
           if(_store.canCreate) {
             DeviceUtils.hideKeyboard(context);
             _store.CreateUser();
           }
           else{
             showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
           }
         }

        //});
      },
    );
  }

  User _setDataUser() {
    User updatedUser = new User();

    if (this.user != null) {
      updatedUser = this.user;
      updatedUser.permissionsList.clear();
    }
    if (this.user == null) {
      updatedUser.creationTime = DateTime.now().toIso8601String();
    }
    updatedUser.name = _nameController.text;
    updatedUser.surName = _surnameController.text;
    updatedUser.isActive = _checkboxActive;
    updatedUser.email = _userEmailController.text;
    updatedUser.userName = _userNameController.text;
    updatedUser.phoneNumber = _phoneNumberController.text;
    updatedUser.permissionsList = new List<dynamic>();
    updatedUser.permissions='';

    for (int j = 0; j < _store.displayRoleName.length; j++) {
      for (int i = 0; i < _roleManagementStore.roleList.roles.length; i++) {
        if (_roleManagementStore.roleList.roles[i].name.compareTo(_store.displayRoleName[j])==0) {
          updatedUser.permissionsList.add(
              (_roleManagementStore.roleList.roles[i]).toMap());
          updatedUser.permissions += _roleManagementStore.roleList.roles[i].displayName +", ";

        }
      }
    }
    updatedUser.permissions = updatedUser.permissions.substring(0,updatedUser.permissions.length-2);
    _store.displayRoleName.clear();
    return updatedUser;
  }

//endregion

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
