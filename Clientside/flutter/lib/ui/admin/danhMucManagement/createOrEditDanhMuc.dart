import 'dart:developer';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/network/dio_client.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/models/danhMuc/danhMuc.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/stores/admin/danhMucManagement/danhMucManagement_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/admin/danhMucManagement/danhMucManagement.dart';
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

class CreateOrEditDanhMucScreen extends StatefulWidget {
  final DanhMuc danhMuc;

  @override
  CreateOrEditDanhMucScreen({@required this.danhMuc});
  _CreateOrEditDanhMucScreenScreenState createState() =>
      _CreateOrEditDanhMucScreenScreenState(danhMuc: danhMuc);
}

class _CreateOrEditDanhMucScreenScreenState
    extends State<CreateOrEditDanhMucScreen> {
  final DanhMuc danhMuc;
  _CreateOrEditDanhMucScreenScreenState({@required this.danhMuc});

  //text controllers:-----------------------------------------------------------
  TextEditingController _nameController = TextEditingController();
  TextEditingController _tagController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  DanhMucManagementStore _danhMucManagementStore;

  bool _checkboxTrangThai = true;
  String titleForm = "Tạo danh mục mới";
  DanhMuc selectedType;
  DanhMuc selectedTypeType;
  bool isVisible = true;
  DanhMuc TypeDanhMucCurrent;
  bool isFinishInit = true;
  List<DanhMuc> type = [];
  List<DanhMuc> typetype = [];

  @override
  void initState() {
    super.initState();
    if (this.danhMuc != null) {
      _nameController.text = this.danhMuc.tenDanhMuc;
      _tagController.text = this.danhMuc.tag;
      // print
      _checkboxTrangThai = this.danhMuc.trangThai == "On" ? true : false;
      selectedType = null;
      selectedTypeType = null;
      titleForm = "Chỉnh sửa danh mục";
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //_store = Provider.of<FormStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _danhMucManagementStore = Provider.of<DanhMucManagementStore>(context);

    if (this.danhMuc != null && isFinishInit) {
      _danhMucManagementStore.setDanhMucId(this.danhMuc.id);
      _danhMucManagementStore.setTagDanhMuc(this.danhMuc.tag);
      _danhMucManagementStore.setNameDanhMuc(this.danhMuc.tenDanhMuc);

      if (this.danhMuc.trangThai == "On") {
        _danhMucManagementStore.setTrangThaiDanhMuc(true);
      } else
        _danhMucManagementStore.setTrangThaiDanhMuc(false);
      isFinishInit = false;
    }

    if (!_danhMucManagementStore.loadingAll) {
      _danhMucManagementStore.getAllDanhMucs();
    }
    _danhMucManagementStore.createDanhMuc_success = false;
    _danhMucManagementStore.updateDanhMuc_success = false;
  }

  var firstrun = true;
  @override
  Widget build(BuildContext context) {
    if (firstrun) {
      setState(() {
        isVisible = true;
        firstrun = false;
        for (var i in _danhMucManagementStore.danhMucListAll.danhMucs)
          if (i.danhMucCha == null) type.add(i);
        if (this.danhMuc != null) {
          if (this.danhMuc.danhMucCha != null) {
            _danhMucManagementStore.setDanhMucCha(this.danhMuc.danhMucCha);
            TypeDanhMucCurrent =
                _danhMucManagementStore.findDanhMucCha(this.danhMuc.danhMucCha);
            if (TypeDanhMucCurrent.danhMucCha != null) {
              selectedType = _danhMucManagementStore
                  .findDanhMucCha(this.TypeDanhMucCurrent.danhMucCha);
              selectedTypeType = TypeDanhMucCurrent;
              isVisible = false;
              typetype = [];
              for (var i = 0;
              i < _danhMucManagementStore.danhMucListAll.danhMucs.length;
              i++)
                if (_danhMucManagementStore.danhMucListAll.danhMucs[i].danhMucCha ==
                    selectedType.id) if (_danhMucManagementStore
                    .danhMucListAll.danhMucs[i] !=
                    null)
                  typetype.add(_danhMucManagementStore.danhMucListAll.danhMucs[i]);
            } else {
              selectedType = TypeDanhMucCurrent;
            }
          }
        }
      });
    }
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
      body: WillPopScope(onWillPop: () {
        var future = showSimpleModalDialog(
            context, "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
        future.then((value) {
          if (value) Navigator.of(context).pop();
        });
        return;
      }, child: Observer(
        builder: (context) {
          return _danhMucManagementStore.loadingAll
              ? CustomProgressIndicatorWidget()
              : _buildBody();
        },
      )),
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
              )
            : Center(child: _buildRightSide()),
        Observer(
          builder: (context) {
            if (_danhMucManagementStore.updateDanhMuc_success ||
                _danhMucManagementStore.createDanhMuc_success) {
              Navigator.of(context).pop(setDataBack());
              if (_danhMucManagementStore.updateDanhMuc_success) {
                showSuccssfullMesssage("Cập nhật thành công", context);
              } else if (_danhMucManagementStore.createDanhMuc_success) {
                showSuccssfullMesssage("Thêm mới thành công, , vui lòng tải lại trang!", context);
              }
              return Container(width: 0, height: 0);
            } else {
              return showErrorMessage(
                  _danhMucManagementStore.errorStore.errorMessage, context);
            }
          },
        ),
        Observer(
          builder: (context) {
            return Visibility(
              visible: _danhMucManagementStore.loadingUpdateDanhMuc ||
                  _danhMucManagementStore.loadingCreateDanhMuc,
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
            _buildTagField(),
            SizedBox(height: 24.0),
            // _buildDanhMucChaField(),
            _buildTypeField(),
            SizedBox(height: 24.0),
            if (!isVisible) _buildTypeTypeField(),
            SizedBox(height: 24.0),
            _buildActiveCheckBox(),
            SizedBox(height: 24.0),
            // _buildTypeTypeTypeField(),
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
      hint: ('Nhập tên danh mục'),
      // hintColor: Colors.white,
      icon: Icons.person,
      inputType: TextInputType.text,
      iconColor: Colors.amber,
      textController: _nameController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorMessage: (value) {
        _danhMucManagementStore.setNameDanhMuc(value);
        if (value.isEmpty) {
          return 'Vui lòng nhập tên danh mục';
        }
      },
    );
  }

  Widget _buildTagField() {
    return TextFieldWidget(
      inputFontsize: 22,
      isDarkmode: _themeStore.darkMode,
      labelText: 'Nhãn',
      suffixIcon: Icon(Icons.clear),
      hint: ('Gắn nhãn cho danh mục'),
      // hintColor: Colors.white,
      icon: Icons.loyalty,
      inputType: TextInputType.text,
      iconColor: Colors.amber,
      textController: _tagController,
      inputAction: TextInputAction.next,
      autoFocus: false,
      errorMessage: (value) {
        _danhMucManagementStore.setTagDanhMuc(value);
        if (value.isEmpty) {
          return 'Vui lòng nhập nhãn cho danh mục';
        }
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
              _danhMucManagementStore.setTrangThaiDanhMuc(_checkboxTrangThai);
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
        if (this.danhMuc != null)
          await {
            _danhMucManagementStore.setNameDanhMuc(_nameController.text),
            // _danhMucManagementStore.setDanhMucCha(int.tryParse(_danhMucChaController.text)),
            if (selectedType != null)
              {
                if (selectedTypeType != null)
                  {
                    _danhMucManagementStore.setDanhMucCha(selectedTypeType.id),
                  }
                else
                  _danhMucManagementStore.setDanhMucCha(selectedType.id),
              }
            else
              {_danhMucManagementStore.setDanhMucCha(null)},
            _danhMucManagementStore.setTrangThaiDanhMuc(_checkboxTrangThai),
          };
        if (this.danhMuc != null) {
          if (_danhMucManagementStore.canSubmit) {
            DeviceUtils.hideKeyboard(context);
            _danhMucManagementStore.UpdateDanhMuc();
          } else {
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        } else {
          if (_danhMucManagementStore.canSubmit) {
            if (selectedType != null)
            {
              if (selectedTypeType != null)
              {
                _danhMucManagementStore.setDanhMucCha(selectedTypeType.id);
            }
            else
              _danhMucManagementStore.setDanhMucCha(selectedType.id);
            }
            else
            {_danhMucManagementStore.setDanhMucCha(null);};
            _danhMucManagementStore.setTrangThaiDanhMuc(_checkboxTrangThai);
        DeviceUtils.hideKeyboard(context);
            _danhMucManagementStore.CreateDanhMuc();
          } else {
            showErrorMessage('Vui lòng nhập đầy đủ thông tin', context);
          }
        }
      },
    );
  }

  Widget _buildTypeField() {
    return DropdownButtonFormField<DanhMuc>(
      hint: Text("Chọn danh mục cha (nếu có)"),
      value: selectedType,
      onChanged: (DanhMuc Value) {
        setState(() {
          try {
            selectedType = Value;
            isVisible = false;
            selectedTypeType = null;
            typetype = [];
            for (var i = 0;
                i < _danhMucManagementStore.danhMucListAll.danhMucs.length;
                i++)
              if (_danhMucManagementStore
                      .danhMucListAll.danhMucs[i].danhMucCha ==
                  selectedType.id) if (_danhMucManagementStore
                      .danhMucListAll.danhMucs[i] !=
                  null)
                typetype
                    .add(_danhMucManagementStore.danhMucListAll.danhMucs[i]);
          } catch (_) {
            selectedType = type[0];
          }
        });
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
        onPressed: () => setState(() {
          selectedType = null;
        }),
        icon: Icon(Icons.clear),
      )),
      items: type.map((DanhMuc types) {
        return DropdownMenuItem<DanhMuc>(
          value: types,
          //showClearButton:true,
          child: Row(
            children: <Widget>[
              Icon(
                Icons.home_work_sharp,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                types.tenDanhMuc,
                style: TextStyle(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTypeTypeField() {
    if (selectedType != null) {
      if (typetype.length != 0)
        return Observer(
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 24.0),
              child: DropdownButtonFormField<DanhMuc>(
                hint: Text("Chọn hình thức nhà đất"),
                autovalidateMode: AutovalidateMode.always,
                // validator: (value) =>
                // value == null ? 'Vui lòng chọn hình thức nhà đất' : null,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    selectedTypeType = null;
                  }),
                  icon: Icon(Icons.clear),
                )),
                value: selectedTypeType,
                //icon:Icons.attach_file ,
                onChanged: (DanhMuc Value) {
                  setState(() {
                    selectedTypeType = Value;
                  });
                },

                items: typetype.map((DanhMuc type) {
                  return DropdownMenuItem<DanhMuc>(
                    value: type,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home_work_sharp,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          type.tenDanhMuc,
                          style: TextStyle(),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            );
          },
        );
      else {
        selectedTypeType = null;
        return Container(height: 0, width: 0);
      }
    } else
      return Container(height: 0, width: 0);
  }

  DanhMuc setDataBack() {
    DanhMuc danhMucBack = new DanhMuc();
    if (this.danhMuc != null) {
      danhMucBack = this.danhMuc;
    }
    danhMucBack.tenDanhMuc = _nameController.text;
    danhMucBack.tag = _tagController.text;
    danhMucBack.trangThai = _checkboxTrangThai ? "On" : "Off";
    if (selectedType != null) {
      if (selectedTypeType != null) {
        danhMucBack.danhMucCha = selectedTypeType.id;
      }
      else danhMucBack.danhMucCha = selectedType.id;
    }
    return danhMucBack;
  }

  //endregion

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _nameController.dispose();
    _tagController.dispose();
    super.dispose();
  }
}
