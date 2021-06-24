import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/thuocTinh/thuocTinh.dart';
import 'package:boilerplate/stores/admin/thuocTinhManagement/thuocTinhManagement_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/thuocTinhManagement/thuocTinhManagement.dart';
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

import 'package:google_fonts/google_fonts.dart';

class CreateOrEditThuocTinhScreen extends StatefulWidget {
  final ThuocTinhManagement thuocTinh;

  @override
  CreateOrEditThuocTinhScreen({@required this.thuocTinh});
  _CreateOrEditThuocTinhScreenScreenState createState() => _CreateOrEditThuocTinhScreenScreenState(thuocTinh: thuocTinh);
}

class _CreateOrEditThuocTinhScreenScreenState extends State<CreateOrEditThuocTinhScreen> {
  final ThuocTinhManagement thuocTinh;
  _CreateOrEditThuocTinhScreenScreenState({@required this.thuocTinh});

  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  ThuocTinhManagementStore _thuocTinhManagementStore;

  bool _checkboxTrangThai = true;
  String titleForm = "Tạo thuộc tính mới";
  bool isFinishInit = true;

  @override
  void initState() {
    super.initState();
    if(this.thuocTinh != null) {
      _nameController.text = this.thuocTinh.tenThuocTinh;
      _checkboxTrangThai = this.thuocTinh.trangThai == "On" ? true : false;
      titleForm = "Chỉnh sửa thuộc tính";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _thuocTinhManagementStore = Provider.of<ThuocTinhManagementStore>(context);
    if (this.thuocTinh == null && isFinishInit) {
      _thuocTinhManagementStore.getKieuDuLieu("String");
      isFinishInit = false;
    }
    if(this.thuocTinh != null && isFinishInit) {
      _thuocTinhManagementStore.KieuDuLieu = this.thuocTinh.kieuDuLieu;
      _thuocTinhManagementStore.getKieuDuLieu(this.thuocTinh.kieuDuLieu);
      _thuocTinhManagementStore.setThuocTinhId(this.thuocTinh.id);
    isFinishInit = false;
    }
    _thuocTinhManagementStore.createThuocTinh_success = false;
    _thuocTinhManagementStore.updateThuocTinh_success = false;
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
          this.titleForm,
        ),
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
            if (_thuocTinhManagementStore.updateThuocTinh_success || _thuocTinhManagementStore.createThuocTinh_success) {
              Navigator.of(context).pop(setDataThuocTinh());
              if(_thuocTinhManagementStore.updateThuocTinh_success)
              {
                showSuccssfullMesssage("Cập nhật thành công", context);
              }
              else if(_thuocTinhManagementStore.createThuocTinh_success)
              {
                showSuccssfullMesssage("Thêm mới thành công", context);
              }
              return Container(width: 0, height: 0);

            } else {
              return showErrorMessage(_thuocTinhManagementStore.errorStore.errorMessage, context);
            }
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _thuocTinhManagementStore.loadingUpdateThuocTinh || _thuocTinhManagementStore.loadingCreateThuocTinh,
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
            _buildNameField(),
            SizedBox(height: 24.0),
            buildKieuDuLieu(),
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
    return TextFieldWidget(
      inputFontsize: 22,
      isDarkmode: _themeStore.darkMode,
      labelText: 'Tên',
      suffixIcon: Icon(Icons.clear),
      hint: ('Nhập tên thuộc tính'),
      // hintColor: Colors.white,
      icon: Icons.person,
      inputType: TextInputType.text,
      iconColor: Colors.amber,
      textController: _nameController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorMessage: (value) {
        _thuocTinhManagementStore.setNameThuocTinh(value);
        if (value.isEmpty) {
          return 'Vui lòng nhập tên thuộc tính';
        }
      },
    );
  }

  Widget buildKieuDuLieu(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 150,
            child: Text("Kiểu dữ liệu",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 6,),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Container(
                  width: 160,
                  height: 60,
                  child: Observer(
                      builder: (context){
                        return DropdownButton<String>(
                          isExpanded: true,
                          value: _thuocTinhManagementStore.KieuDuLieuShow,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          //style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 1,
                            color: _themeStore.darkMode ? Colors.red[400] : Colors.black,
                          ),
                          onChanged: (String newValue) {
                            _thuocTinhManagementStore.KieuDuLieuShow = newValue;
                            _thuocTinhManagementStore.setKieuDuLieu(newValue);
                          },
                          items: <String>['Chuỗi', 'Số nguyên', 'Số thực']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Row (
                                children: [
                                  Icon(Icons.workspaces_filled),
                                  SizedBox(width: 10,),
                                  Text(value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      //color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            );
                          }).toList(),
                        );
                      }),
                ),
              ),
            ],
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
          // checkColor: Colors.amber,
          value: _checkboxTrangThai,
          onChanged: (value) {
            setState(() {
              _checkboxTrangThai = !_checkboxTrangThai;
              _thuocTinhManagementStore.setTrangThaiThuocTinh(_checkboxTrangThai);
            });
          },
        ),
        Text(
          'Kích hoạt',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            // color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Lưu thông tin'),
      buttonColor: Colors.amber,
      textColor: Colors.white,
      onPressed: () async {
        if(this.thuocTinh != null) await {
          _thuocTinhManagementStore.setNameThuocTinh(_nameController.text),
          _thuocTinhManagementStore.setTrangThaiThuocTinh(_checkboxTrangThai),
          _thuocTinhManagementStore.setKieuDuLieu(_thuocTinhManagementStore.KieuDuLieuShow),
        };
        if(this.thuocTinh != null) {
          if(_thuocTinhManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _thuocTinhManagementStore.UpdateThuocTinh();
          }
          else{
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        }
        else {
          if(_thuocTinhManagementStore.canSubmit) {
            await _thuocTinhManagementStore.setTrangThaiThuocTinh(_checkboxTrangThai);
            DeviceUtils.hideKeyboard(context);
            _thuocTinhManagementStore.CreateThuocTinh();
          }
          else{
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        }

        //});
      },
    );
  }

  ThuocTinhManagement setDataThuocTinh() {
    ThuocTinhManagement thuocTinhSet = new ThuocTinhManagement();
    if (this.thuocTinh != null) {
      thuocTinhSet = this.thuocTinh;
    }
    String kieuDL = _thuocTinhManagementStore.KieuDuLieuShow;
    print("1112");
    print(kieuDL);
    thuocTinhSet.trangThai = _checkboxTrangThai ? "On" : "Off";
    if (kieuDL.compareTo("Số nguyên")==0)
      thuocTinhSet.kieuDuLieu="int";
    else if (kieuDL.compareTo("Số thực")==0)
      thuocTinhSet.kieuDuLieu="double";
    else
      thuocTinhSet.kieuDuLieu="String";

    thuocTinhSet.tenThuocTinh = _nameController.text;
    print("....");
    print(thuocTinhSet.kieuDuLieu);
    return thuocTinhSet;
  }

//endregion
  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    super.dispose();
  }

}
