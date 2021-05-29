import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/login/login.dart';
import 'package:boilerplate/utils/device/device_utils.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class changePassWordPage extends StatefulWidget {
  changePassWordPage({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  _changePassWordPageState createState() => _changePassWordPageState();
}

class _changePassWordPageState extends State<changePassWordPage> {
  UserStore _userStore;
  ThemeStore _themeStore;
  FormStore _store = new FormStore();

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _reenterNewPasswordController = TextEditingController();

  _changePassWordPageState({
    Key key,
  }) : super();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _userStore = Provider.of<UserStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

  }
  @override
  void initState() {
    super.initState();
  }
  Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

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
            onPressed: (){
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text("Đổi mật khẩu")
    );
  }

  Widget _buildBody(){
    return Material(
      child: Stack(
        children:[ SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _buildOldPasswordField(),
                SizedBox(height: 24.0),
                _buildNewPasswordField(),
                SizedBox(height: 24.0),
                _buildConfirmPasswordField(),
                SizedBox(height: 24.0),
                _buildSubmitButton(),

              ],
            ),
          ),
        ),
        Observer(
          builder: (context) {
            if (_store.changePassword_succes) {
              print("12312312");
              SharedPreferences.getInstance().then((prefs) {
                prefs.setBool(Preferences.is_logged_in, false);
              });
              _showSuccssfullMesssage("Đổi mật khẩu thành công, vui lòng đăng nhập lại");

              Future.delayed(Duration(milliseconds: 7), () {
              });
              //Navigator.of(context, rootNavigator: true).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen(loginAgain: true)));


              return Container(width: 0, height: 0);
            } else {
              print("failed");
              return _showErrorMessage(_store.errorStore.errorMessage);
            }
          },
        ),
      ]),
    );
  }

  Widget _buildOldPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Mật khẩu hiện tại'),
          hintColor: Colors.grey,
          isObscure: true,
          icon: Icons.security_outlined,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          iconColor: Colors.amber,
          textController: _oldPasswordController,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
            _store.setPassword(_oldPasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildNewPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Mật khẩu mới'),
          hintColor: Colors.grey,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: Colors.amber,
          textController: _newPasswordController,
          errorText: _store.formErrorStore.newPassword,
          autoFocus: false,
          onChanged: (value) {
            _store.setNewPassword(_newPasswordController.text);
          },
        );
      },
    );
  }
  Widget _buildConfirmPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Nhập lại mật khẩu mới'),
          hintColor: Colors.grey,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: Colors.amber,
          textController: _reenterNewPasswordController,
          autoFocus: false,
          errorText: _store.formErrorStore.confirmPassword,
          onChanged: (value) {
            _store.setConfirmPassword(_reenterNewPasswordController.text);
          },
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: ('Đổi mật khẩu'),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      minWidth: size.width - 48,
      onPressed: () {
        if(_store.canChangePassword) {
          DeviceUtils.hideKeyboard(context);
          _store.changePassword();
        }
        else{
          _showErrorMessage('Hãy điền đẩy đủ thông tin');
        }
        //});
      },
    );
  }
  _showErrorMessage(String message) {
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

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _reenterNewPasswordController.dispose();
    _newPasswordController.dispose();
    _oldPasswordController.dispose();
    super.dispose();
  }

}