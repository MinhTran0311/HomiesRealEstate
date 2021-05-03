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
import 'package:boilerplate/widgets/empty_app_bar_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


class ResetPasswordScreen extends StatefulWidget {
  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _emailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  //focus node:-----------------------------------------------------------------
  FocusNode _emailFocusNode;

  //stores:---------------------------------------------------------------------
  final FormStore _store = new FormStore();

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
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
              return _store.success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.sendingCode,
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
            AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            SizedBox(height: 24.0),
            _buildForgotPasswordNoti(),
            _buildUserEmail(),
            _buildSubmitButton()
          ],
        ),
      ),
    );
  }

  Widget _buildForgotPasswordNoti() {
    return RichText(
      text: TextSpan(
        text: "Forgot Password?\n",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),
        children: [
          TextSpan(
          text: "Một liên kết đặt lại mật khẩu sẽ được gửi đến email của bạn để đặt lại mật khẩu của bạn. Nếu bạn không nhận được email trong vòng vài phút, vui lòng thử lại.",
          style: TextStyle(fontSize: 18))
          ]
        )
      );
  }

  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Email *'),
          hintColor: Colors.white,
          icon: Icons.email_rounded,
          inputType: TextInputType.text,
          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          textController: _emailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserEmail(_emailController.text);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return RoundedButtonWidget(
      buttonText: ('Gửi'),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () async {
        if (_store.canSubmitResetPassword) {
          DeviceUtils.hideKeyboard(context);
          _store.resetPassword();
        } else {
          _showErrorMessage('Please fill in all fields');
        }
      },
    );
  }



  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, false);
    });
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
    });

    return Container();
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_store.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_store.errorStore.errorMessage);
        }
        return SizedBox.shrink();
      },
    );
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

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _emailController.dispose();
    _emailFocusNode.dispose();
    super.dispose();
  }

}
