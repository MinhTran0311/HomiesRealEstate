import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

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
            onPressed: (){
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text("Đổi mật khẩu")
    );
  }

  Widget _buildBody(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildOldPasswordField(),
        _buildNewPasswordField(),
        _buildConfirmPasswordField(),
      ],
    );
  }

  Widget _buildOldPasswordField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Mật khẩu hiện tại'),
          hintColor: Colors.white,
          isObscure: true,
          icon: Icons.vpn_key,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _oldPasswordController,
          errorText: _store.formErrorStore.password,
          onChanged: (value) {
           // _store.setPassword(_oldPasswordController.text);
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
          hintColor: Colors.white,
          onEditingComplete: () => FocusScope.of(context).nextFocus(),
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _newPasswordController,
          autoFocus: false,
          onChanged: (value) {
            _store.setPassword(_newPasswordController.text);
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
          hintColor: Colors.white,
          onEditingComplete: () => FocusScope.of(context).unfocus(),
          isObscure: true,
          icon: Icons.vpn_key,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
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

}