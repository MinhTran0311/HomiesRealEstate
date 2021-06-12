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
  bool _radioBtnKDL = true;
  String titleForm = "Tạo thuộc tính mới";
  String _kieuDuLieu = "Chuỗi";

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
              MaterialPageRoute(builder: (context) => ThuocTinhManagementScreen()),
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
              if (_thuocTinhManagementStore.updateThuocTinh_success || _thuocTinhManagementStore.createThuocTinh_success) {
                Future.delayed(Duration(milliseconds: 0), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ThuocTinhManagementScreen()),
                  );
                });
                if(_thuocTinhManagementStore.updateThuocTinh_success)
                  {
                    _showSuccssfullMesssage("Cập nhật thành công");
                    _thuocTinhManagementStore.updateThuocTinh_success = false;
                  }
                else if(_thuocTinhManagementStore.createThuocTinh_success)
                  {
                    _showSuccssfullMesssage("Thêm mới thành công");
                    _thuocTinhManagementStore.createThuocTinh_success = false;
                  }
                return Container(width: 0, height: 0);

              } else {
                return _showErrorMessage(_thuocTinhManagementStore.errorStore.errorMessage);
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
            _buildNameField(),
            SizedBox(height: 24.0),
            buildLoaiBaiDang(),
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
    Widget buildDiaChiFilter(){
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 110,
              child: Text("Địa chỉ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              // child: TextField(
              //   autofocus: false,
              //   keyboardType: TextInputType.text,
              //   controller: _diaChiController,
              //   onChanged: (value){
              //     _filterStore.setDiaChiContent(value);
              //   },
              //   textAlign: TextAlign.start,
              //   style: TextStyle(
              //     fontSize: 18,
              //     color: Colors.black,
              //   ),
              //   decoration: InputDecoration(
              //     hintText: "Địa chỉ bất kì",
              //     suffixIcon: IconButton(
              //       onPressed: () {
              //         _diaChiController.clear();
              //         _filterStore.setDiaChiContent("");
              //       },
              //       icon: Icon(Icons.clear),
              //     ),
              //     hintStyle: TextStyle(
              //       fontSize: 18,
              //       color: Colors.grey[400],
              //     ),
              //     enabledBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.red[400]),
              //     ),
              //     focusedBorder: UnderlineInputBorder(
              //       borderSide: BorderSide(color: Colors.orange[400]),
              //     ),
              //     border:  UnderlineInputBorder(
              //         borderSide:  BorderSide(color: Colors.black)
              //     ),
              //   ),
              // ),
            ),
          ],
        ),
      );
    }
  }

  Widget buildLoaiBaiDang(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.loyalty,
                size: 26,
                color: Colors.white,
              ),
              SizedBox(width: 12,),
              Text("Kiểu dữ liệu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.white,
                ),
                textAlign: TextAlign.start,
              ),
            ],
          ),
          SizedBox(width: 12,),
          Container(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 160,
                      height: 60,
                      child: DropdownButtonFormField(
                        value: _kieuDuLieu,
                        items: <String>['Chuỗi', 'Số nguyên', 'Số thực']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          );
                        }).toList(),
                        hint: Text("Chọn vai trò"),
                        onChanged: (value) {
                          setState(() {
                            _kieuDuLieu = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              )
          ),
        ],
      ),
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
          value: _checkboxTrangThai,
          onChanged: (value) {
            setState(() {
              _thuocTinhManagementStore.setTrangThaiThuocTinh(!_checkboxTrangThai);
              _checkboxTrangThai = !_checkboxTrangThai;
            });
          },
        ),
        Text(
          'Kích hoạt',
          style: TextStyle(
            fontSize: 22,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Lưu thông tin'),
      buttonColor: Colors.black87,
      textColor: Colors.white,
      onPressed: () async {
        if(this.thuocTinh != null) await {
          _thuocTinhManagementStore.setNameThuocTinh(_nameController.text),
          //  else {
          //    _store.setPassword(this.user.),
          //    _store.setConfirmPassword(_confirmPasswordController.text),
          // },
          _thuocTinhManagementStore.setThuocTinhId(this.thuocTinh.id),
          _thuocTinhManagementStore.setTrangThaiThuocTinh(_checkboxTrangThai),
          _thuocTinhManagementStore.setKieuDuLieu(_kieuDuLieu),
        };
        if(this.thuocTinh != null) {
          if(_thuocTinhManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _thuocTinhManagementStore.UpdateThuocTinh();
          }
          else{
            _showErrorMessage('Please fill in all fields');
          }
        }
        else {
          if(_thuocTinhManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _thuocTinhManagementStore.CreateThuocTinh();
          }
          else{
            _showErrorMessage('Please fill in all fields');
          }
        }

        //});
      },
    );
  }
//endregion

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
    super.dispose();
  }

}
