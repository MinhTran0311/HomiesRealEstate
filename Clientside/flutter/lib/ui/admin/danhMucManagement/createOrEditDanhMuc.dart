import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/danhMuc/danhMuc.dart';
import 'package:boilerplate/stores/admin/danhMucManagement/danhMucManagement_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/danhMucManagement/danhMucManagement.dart';
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

import 'package:google_fonts/google_fonts.dart';

class CreateOrEditDanhMucScreen extends StatefulWidget {
  final DanhMuc danhMuc;

  @override
  CreateOrEditDanhMucScreen({ @required this.danhMuc });
  _CreateOrEditDanhMucScreenScreenState createState() => _CreateOrEditDanhMucScreenScreenState(danhMuc: danhMuc);
}

class _CreateOrEditDanhMucScreenScreenState extends State<CreateOrEditDanhMucScreen> {
  final DanhMuc danhMuc;
  _CreateOrEditDanhMucScreenScreenState({ @required this.danhMuc });

  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  DanhMucManagementStore _danhMucManagementStore;

  bool _checkboxTrangThai = true;
  String titleForm = "Tạo danh mục mới";

  @override
  void initState() {
    super.initState();

    if (this.danhMuc != null) {
      _nameController.text = this.danhMuc.tenDanhMuc;
      _tagController.text = this.danhMuc.tag;
      _checkboxTrangThai = this.danhMuc.trangThai == "On" ? true : false;
      titleForm = "Chỉnh sửa danh mục";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _danhMucManagementStore = Provider.of<DanhMucManagementStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar : AppBar(
        leading : IconButton(
          icon : Icon(Icons.arrow_back_ios_outlined,
            color: Colors.white, ),
          onPressed : () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DanhMucManagementScreen()),
            );
          },
        ),
        title: Text(
          this.titleForm,
          style: Theme.of(context).textTheme.button.copyWith(color : Colors.white, fontSize : 23, fontWeight : FontWeight.bold, letterSpacing : 1.0), ),
        automaticallyImplyLeading : false,
        centerTitle : true,
        backgroundColor : Colors.amber,
      ),

      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Material(
      child: Stack(
        children : <Widget>[
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
            children : <Widget>[
              Expanded(
                flex:1,
                child : _buildLeftSide(),
              ),
              Expanded(
                flex:1,
                child : _buildRightSide(),
              ),
            ],
          ) : Center(child : _buildRightSide()),
          Observer(
            builder : (context) {
              if (_danhMucManagementStore.updateDanhMuc_success || _danhMucManagementStore.createDanhMuc_success) {
                Future.delayed(Duration(milliseconds: 0), () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DanhMucManagementScreen()),
                  );
                });
                if (_danhMucManagementStore.updateDanhMuc_success)
                {
                  _showSuccssfullMesssage("Cập nhật thành công");
                  _danhMucManagementStore.updateDanhMuc_success = false;
                }
                else if (_danhMucManagementStore.createDanhMuc_success)
                {
                  _showSuccssfullMesssage("Thêm mới thành công");
                  _danhMucManagementStore.createDanhMuc_success = false;
                }
                return Container(width: 0, height : 0);

              }
              else {
                return _showErrorMessage(_danhMucManagementStore.errorStore.errorMessage);
              }
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _danhMucManagementStore.loadingUpdateDanhMuc || _danhMucManagementStore.loadingCreateDanhMuc,
                child : CustomProgressIndicatorWidget(),
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
        padding : const EdgeInsets.symmetric(horizontal : 24.0, vertical : 24.0),
        child : Column(
          mainAxisSize : MainAxisSize.max,
          crossAxisAlignment : CrossAxisAlignment.stretch,
          mainAxisAlignment : MainAxisAlignment.center,
          children : <Widget>[
            //AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            //SizedBox(height: 24.0),
            _buildNameField(),
            SizedBox(height:24.0),
            _buildTagField(),
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
  Widget _buildNameField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:80,
            child : Text("Tên",
              style: TextStyle(
                fontWeight : FontWeight.bold,
                fontSize : 22,
              ),
              textAlign : TextAlign.start,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: TextField(
              autofocus : false,
              keyboardType : TextInputType.text,
              controller : _nameController,
              onChanged : (value) {
                _danhMucManagementStore.setNameDanhMuc(value);
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Tên danh mục",
                suffixIcon : IconButton(
                  onPressed : () {
                    _nameController.clear();
                    _danhMucManagementStore.setNameDanhMuc("");
                  },
                  icon : Icon(Icons.clear),
                ),
                hintStyle: TextStyle(
                  fontSize : 18,
                  // color: Colors.grey[400],
                ),
                enabledBorder : UnderlineInputBorder(
                  borderSide : BorderSide(color : Colors.red[400]),
                ),
                focusedBorder : UnderlineInputBorder(
                  borderSide : BorderSide(color : Colors.orange[400]),
                ),
                border : UnderlineInputBorder(
                    borderSide : BorderSide(color : Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTagField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:80,
            child : Text("Nhãn",
              style: TextStyle(
                fontWeight : FontWeight.bold,
                fontSize : 22,
              ),
              textAlign : TextAlign.start,
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Expanded(
            child: TextField(
              autofocus : false,
              keyboardType : TextInputType.text,
              controller : _tagController,
              onChanged : (value) {
                _danhMucManagementStore.setTagDanhMuc(value);
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Gắn nhãn",
                suffixIcon : IconButton(
                  onPressed : () {
                    _tagController.clear();
                    _danhMucManagementStore.setTagDanhMuc("");
                  },
                  icon : Icon(Icons.clear),
                ),
                hintStyle: TextStyle(
                  fontSize : 18,
                  // color: Colors.grey[400],
                ),
                enabledBorder : UnderlineInputBorder(
                  borderSide : BorderSide(color : Colors.red[400]),
                ),
                focusedBorder : UnderlineInputBorder(
                  borderSide : BorderSide(color : Colors.orange[400]),
                ),
                border : UnderlineInputBorder(
                    borderSide : BorderSide(color : Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveCheckBox() {
    return Row(
      children: [
        Checkbox(
          value:_checkboxTrangThai,
          onChanged : (value) {
            setState(() {
              _danhMucManagementStore.setTrangThaiDanhMuc(!_checkboxTrangThai);
              _checkboxTrangThai = !_checkboxTrangThai;
            });
          },
        ),
        Text(
          'Kích hoạt',
          style: TextStyle(
            fontSize : 22,
            fontWeight : FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Lưu thông tin'),
      buttonColor : Colors.black87,
      textColor : Colors.white,
      onPressed : () async {
        if (this.danhMuc != null) await{
          _danhMucManagementStore.setNameDanhMuc(_nameController.text),
          //  else {
          //    _store.setPassword(this.user.),
          //    _store.setConfirmPassword(_confirmPasswordController.text),
          // },
          _danhMucManagementStore.setDanhMucId(this.danhMuc.id),
          _danhMucManagementStore.setTrangThaiDanhMuc(_checkboxTrangThai),
        };
        if (this.danhMuc != null) {
          if (_danhMucManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _danhMucManagementStore.UpdateDanhMuc();
          }
          else {
            _showErrorMessage('Vui lòng điền đầy đủ thông tin');
          }
        }
        else {
          if (_danhMucManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _danhMucManagementStore.CreateDanhMuc();
          }
          else {
            _showErrorMessage('Vui lòng điền đầy đủ thông tin');
          }
        }

        //});
      },
    );
  }
  //endregion

  // General Methods:-----------------------------------------------------------


  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title : AppLocalizations.of(context).translate('home_tv_error'),
          duration : Duration(seconds : 5),
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
          title : "Thông báo",
          duration : Duration(seconds : 5),
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
    _tagController.dispose();
    super.dispose();
  }

}
