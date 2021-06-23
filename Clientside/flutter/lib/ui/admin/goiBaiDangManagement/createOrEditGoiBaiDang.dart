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
  CreateOrEditGoiBaiDangScreen({@required this.goiBaiDang});

  _CreateOrEditGoiBaiDangScreenScreenState createState() =>
      _CreateOrEditGoiBaiDangScreenScreenState(goiBaiDang: goiBaiDang);
}

class _CreateOrEditGoiBaiDangScreenScreenState
    extends State<CreateOrEditGoiBaiDangScreen> {
  final GoiBaiDang goiBaiDang;

  _CreateOrEditGoiBaiDangScreenScreenState({@required this.goiBaiDang});

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
      _thoiGianToiThieuController.text =
          this.goiBaiDang.thoiGianToiThieu.toString();
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
    _goiBaiDangManagementStore =
        Provider.of<GoiBaiDangManagementStore>(context);
    _goiBaiDangManagementStore.updateGoiBaiDang_success = false;
    _goiBaiDangManagementStore.createGoiBaiDang_success = false;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
          ),
          onPressed: () {
            var future = showSimpleModalDialog(
                context, "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
            future.then((value) {
              if (value) Navigator.of(context).pop();
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
          var future = showSimpleModalDialog(
              context, "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
          future.then((value) {
            if (value) Navigator.of(context).pop();
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
              )
            : Center(child: _buildRightSide()),
        Observer(
          builder: (context) {
            if (_goiBaiDangManagementStore.updateGoiBaiDang_success || _goiBaiDangManagementStore.createGoiBaiDang_success) {
              Navigator.of(context).pop(context);
              if(_goiBaiDangManagementStore.updateGoiBaiDang_success)
              {
                showSuccssfullMesssage("Cập nhật thành công", context);
              }
              else if(_goiBaiDangManagementStore.createGoiBaiDang_success)
              {
                showSuccssfullMesssage("Thêm mới thành công", context);
              }
              return Container(width: 0, height: 0);
            } else {
              return showErrorMessage(
                  _goiBaiDangManagementStore.errorStore.errorMessage, context);
            }
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _goiBaiDangManagementStore.loadingUpdateGoiBaiDang ||
                  _goiBaiDangManagementStore.loadingCreateGoiBaiDang,
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
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          labelText: 'Tên',
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập tên gói bài đăng'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _nameController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _goiBaiDangManagementStore.setNameGoiBaiDang(value);
            if (value.isEmpty) {
              return 'Vui lòng nhập tên gói bài đăng';
            }
          },
        );
      },
    );
  }

  Widget _buildPhiField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          labelText: 'Phí',
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập phí gói bài đăng'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.number,
          iconColor: Colors.amber,
          textController: _phiController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _goiBaiDangManagementStore.setPhiGoiBaiDang(double.tryParse(value));
            if (value.isEmpty) {
              return 'Vui lòng nhập phí gói bài đăng';
            }
          },
        );
      },
    );
  }

  Widget _buildDoUuTienField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          labelText: 'Độ ưu tiên',
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập độ ưu tiên gói bài đăng'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.number,
          iconColor: Colors.amber,
          textController: _doUuTienController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _goiBaiDangManagementStore
                .setDoUuTienGoiBaiDang(int.tryParse(value));
          },
        );
      },
    );
  }

  Widget _buildThoiGianToiThieuField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          labelText: 'Thời gian tối thiểu (ngày)',
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập thời gian tối thiểu'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.number,
          iconColor: Colors.amber,
          textController: _thoiGianToiThieuController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _goiBaiDangManagementStore
                .setThoiGianToiThieuGoiBaiDang(int.tryParse(value));
          },
        );
      },
    );
  }

  Widget _buildMoTaField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          isDarkmode: _themeStore.darkMode,
          labelText: 'Mô tả',
          suffixIcon: Icon(Icons.clear),
          hint: ('Nhập mô tả gói bài đăng'),
          // hintColor: Colors.white,
          icon: Icons.person,
          inputType: TextInputType.text,
          iconColor: Colors.amber,
          textController: _moTaController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          errorMessage: (value) {
            _goiBaiDangManagementStore.setMoTaGoiBaiDang(value);
            if (value.isEmpty) {
              return 'Vui lòng nhập mô tả gói bài đăng';
            }
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
          value: _checkboxTrangThai,
          onChanged: (value) {
            setState(() {
              _checkboxTrangThai = !_checkboxTrangThai;
              _goiBaiDangManagementStore.setTrangThaiGoiBaiDang(_checkboxTrangThai);
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
        if (this.goiBaiDang != null)
          await {
            _goiBaiDangManagementStore.setNameGoiBaiDang(_nameController.text),
            _goiBaiDangManagementStore.setGoiBaiDangId(this.goiBaiDang.id),
            _goiBaiDangManagementStore.setMoTaGoiBaiDang(_moTaController.text),
            if (_doUuTienController.text == null || _doUuTienController.text.isEmpty) {
              _goiBaiDangManagementStore.setDoUuTienGoiBaiDang(1),
            } else {
              _goiBaiDangManagementStore.setDoUuTienGoiBaiDang(int.tryParse(_doUuTienController.text)),
            },
            if (_thoiGianToiThieuController.text == null || _thoiGianToiThieuController.text.isEmpty) {
              _goiBaiDangManagementStore.setThoiGianToiThieuGoiBaiDang(1),
            } else {
              _goiBaiDangManagementStore.setThoiGianToiThieuGoiBaiDang(int.tryParse(_thoiGianToiThieuController.text)),
            },
            _goiBaiDangManagementStore
                .setPhiGoiBaiDang(double.tryParse(_phiController.text)),
            _goiBaiDangManagementStore
                .setTrangThaiGoiBaiDang(_checkboxTrangThai),
          };
        if (this.goiBaiDang != null) {
          if (_goiBaiDangManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _goiBaiDangManagementStore.UpdateGoiBaiDang();
          } else {
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        } else {
          if (_goiBaiDangManagementStore.canSubmit) {
            if (_doUuTienController.text == null ||
                _doUuTienController.text.isEmpty)
              await {
                _goiBaiDangManagementStore.setDoUuTienGoiBaiDang(1),
              };
            if (_thoiGianToiThieuController.text == null ||
                _thoiGianToiThieuController.text.isEmpty)
              await {
                _goiBaiDangManagementStore.setThoiGianToiThieuGoiBaiDang(1),
              };
            await _goiBaiDangManagementStore
                .setTrangThaiGoiBaiDang(_checkboxTrangThai);
            DeviceUtils.hideKeyboard(context);
            _goiBaiDangManagementStore.CreateGoiBaiDang();
          } else {
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        }

        //});
      },
    );
  }

  _updateOrCreateSuccess() async {
    // await Navigator.of(context).pop();
    // if(_goiBaiDangManagementStore.updateActiveGoiBaiDang_success)
    // {
    //   showSuccssfullMesssage("Cập nhật thành công", context);
    //   _goiBaiDangManagementStore.updateActiveGoiBaiDang_success = false;
    // }
    // else if(_goiBaiDangManagementStore.createGoiBaiDang_success)
    // {
    //   showSuccssfullMesssage("Thêm mới thành công", context);
    //   _goiBaiDangManagementStore.createGoiBaiDang_success = false;
    // }
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
