import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/goiBaiDang/goiBaiDang.dart';
import 'package:boilerplate/stores/admin/goiBaiDangManagement/goiBaiDangManagement_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/goiBaiDangManagement/goiBaiDangManagement.dart';
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
import 'package:boilerplate/ui/admin/thuocTinhManagement/createOrEditThuocTinh.dart';

import 'package:google_fonts/google_fonts.dart';

class CreateOrEditGoiBaiDangScreen extends StatefulWidget {
  final GoiBaiDang goiBaiDang;

  @override
  CreateOrEditGoiBaiDangScreen({ @required this.goiBaiDang });
  _CreateOrEditGoiBaiDangScreenScreenState createState() => _CreateOrEditGoiBaiDangScreenScreenState(goiBaiDang: goiBaiDang);
}

class _CreateOrEditGoiBaiDangScreenScreenState extends State<CreateOrEditGoiBaiDangScreen> {
  final GoiBaiDang goiBaiDang;
  _CreateOrEditGoiBaiDangScreenScreenState({ @required this.goiBaiDang });

  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phiController = TextEditingController();
  TextEditingController _doUuTienController = TextEditingController();
  TextEditingController _thoiGianToiThieuController = TextEditingController();
  TextEditingController _moTaController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  GoiBaiDangManagementStore _goiBaiDangManagementStore;

  bool _checkboxTrangThai = true;
  String titleForm = "Tạo gói mới";

  @override
  void initState() {
    super.initState();

    if (this.goiBaiDang != null) {
      _nameController.text = this.goiBaiDang.tenGoi;
      _phiController.text = this.goiBaiDang.phi.toString();
      _doUuTienController.text = this.goiBaiDang.doUuTien.toString();
      _thoiGianToiThieuController.text = this.goiBaiDang.thoiGianToiThieu.toString();
      _moTaController.text = this.goiBaiDang.moTa;
      _checkboxTrangThai = this.goiBaiDang.trangThai == "On" ? true : false;
      titleForm = "Chỉnh sửa gói";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _goiBaiDangManagementStore = Provider.of<GoiBaiDangManagementStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar : AppBar(
        leading : IconButton(
          icon : Icon(Icons.arrow_back_ios_outlined,),
          onPressed : () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          this.titleForm,
        ),
        automaticallyImplyLeading : false,
      ),

      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
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
            if (_goiBaiDangManagementStore.updateGoiBaiDang_success || _goiBaiDangManagementStore.createGoiBaiDang_success) {
              Future.delayed(Duration(milliseconds: 0), () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GoiBaiDangManagementScreen()),
                );
              });
              if (_goiBaiDangManagementStore.updateGoiBaiDang_success)
              {
                showSuccssfullMesssage("Cập nhật thành công",context);
                _goiBaiDangManagementStore.updateGoiBaiDang_success = false;
              }
              else if (_goiBaiDangManagementStore.createGoiBaiDang_success)
              {
                showSuccssfullMesssage("Thêm mới thành công",context);
                _goiBaiDangManagementStore.createGoiBaiDang_success = false;
              }
              return Container(width: 0, height : 0);

            }
            else {
              return showErrorMessage(_goiBaiDangManagementStore.errorStore.errorMessage,context);
            }
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _goiBaiDangManagementStore.loadingUpdateGoiBaiDang || _goiBaiDangManagementStore.loadingCreateGoiBaiDang,
              child : CustomProgressIndicatorWidget(),
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
            _buildPhiField(),
            SizedBox(height: 24.0),
            _buildDoUuTienField(),
            SizedBox(height: 24.0),
            _buildThoiGianToiThieuField(),
            SizedBox(height: 24.0),
            _buildMoTaField(),
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
                _goiBaiDangManagementStore.setNameGoiBaiDang(value);
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                // color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Tên danh mục",
                suffixIcon : IconButton(
                  onPressed : () {
                    _nameController.clear();
                    _goiBaiDangManagementStore.setNameGoiBaiDang("");
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

  Widget _buildPhiField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:200,
            child : Text("Phí",
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
              keyboardType : TextInputType.number,
              controller : _phiController,
              onChanged : (value) {
                _goiBaiDangManagementStore.setPhiGoiBaiDang(double.tryParse(value));
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                // color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "VNĐ",
                suffixIcon : IconButton(
                  onPressed : () {
                    _phiController.clear();
                    _goiBaiDangManagementStore.setPhiGoiBaiDang(0);
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

  Widget _buildDoUuTienField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:200,
            child : Text("Độ ưu tiên",
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
              keyboardType : TextInputType.number,
              controller : _doUuTienController,
              onChanged : (value) {
                _goiBaiDangManagementStore.setDoUuTienGoiBaiDang(int.tryParse(value));
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                // color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Độ ưu tiên",
                suffixIcon : IconButton(
                  onPressed : () {
                    _doUuTienController.clear();
                    _goiBaiDangManagementStore.setDoUuTienGoiBaiDang(0);
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

  Widget _buildThoiGianToiThieuField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:200,
            child : Text("Thời gian tối thiểu",
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
              keyboardType : TextInputType.number,
              controller : _thoiGianToiThieuController,
              onChanged : (value) {
                _goiBaiDangManagementStore.setThoiGianToiThieuGoiBaiDang(int.tryParse(value));
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                // color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Ngày",
                suffixIcon : IconButton(
                  onPressed : () {
                    _thoiGianToiThieuController.clear();
                    _goiBaiDangManagementStore.setThoiGianToiThieuGoiBaiDang(0);
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

  Widget _buildMoTaField() {
    return Padding(
      padding: const EdgeInsets.only(bottom : 12.0),
      child : Row(
        mainAxisAlignment : MainAxisAlignment.start,
        children : [
          Container(
            width:80,
            child : Text("Mô tả",
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
              controller : _moTaController,
              onChanged : (value) {
                _goiBaiDangManagementStore.setMoTaGoiBaiDang(value);
              },
              textAlign : TextAlign.start,
              style : TextStyle(
                fontSize : 18,
                // color : Colors.black,
              ),
              decoration : InputDecoration(
                hintText : "Mô tả",
                suffixIcon : IconButton(
                  onPressed : () {
                    _moTaController.clear();
                    _goiBaiDangManagementStore.setMoTaGoiBaiDang("");
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
          activeColor: Colors.amber,
          value:_checkboxTrangThai,
          onChanged : (value) {
            setState(() {
              _goiBaiDangManagementStore.setTrangThaiGoiBaiDang(!_checkboxTrangThai);
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
      buttonColor : Colors.amber,
      textColor : Colors.white,
      onPressed : () async {
        if (this.goiBaiDang != null) await{
          _goiBaiDangManagementStore.setNameGoiBaiDang(_nameController.text),
          //  else {
          //    _store.setPassword(this.user.),
          //    _store.setConfirmPassword(_confirmPasswordController.text),
          // },
          _goiBaiDangManagementStore.setGoiBaiDangId(this.goiBaiDang.id),
          _goiBaiDangManagementStore.setTrangThaiGoiBaiDang(_checkboxTrangThai),
        };
        if (this.goiBaiDang != null) {
          if (_goiBaiDangManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _goiBaiDangManagementStore.UpdateGoiBaiDang();
          }
          else {
            showErrorMessage('Vui lòng điền đầy đủ thông tin',context);
          }
        }
        else {
          if (_goiBaiDangManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _goiBaiDangManagementStore.CreateGoiBaiDang();
          }
          else {
            showErrorMessage('Vui lòng điền đầy đủ thông tin',context);
          }
        }

        //});
      },
    );
  }
  //endregion

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    _phiController.dispose();
    _doUuTienController.dispose();
    _thoiGianToiThieuController.dispose();
    _moTaController.dispose();
    super.dispose();
  }

}
