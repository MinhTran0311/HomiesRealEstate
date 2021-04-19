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
import 'package:boilerplate/stores/token/authToken_store.dart';

import 'package:google_fonts/google_fonts.dart';

class NewpostScreen extends StatefulWidget {
  @override
  _NewpostScreenState createState() => _NewpostScreenState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}

class _NewpostScreenState extends State<NewpostScreen> {
  //text controllers:-----------------------------------------------------------
  TextEditingController _TileController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _AcreageController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();

  //stores:---------------------------------------------------------------------
  ThemeStore _themeStore;
  //focus node:-----------------------------------------------------------------

  //stores:---------------------------------------------------------------------
  final FormStore _store = new FormStore();
  Item selectedType;
  Item selectedTypeType;
  Item selectedCity;
  Item selectedTown;
  Item selectedVil;
  DateTime selectedDate1st = DateTime.now();
  _selectDate1st(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1st,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate1st)
      setState(() {
        selectedDate1st = picked;
      });
  }

  List<Item> type = <Item>[
    const Item(
        'Bán',
        Icon(
          Icons.point_of_sale,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Cho thuê',
        Icon(
          Icons.point_of_sale,
          color: const Color(0xFF167F67),
        )),
  ];
  List<Item> typetype = <Item>[
    const Item(
        'Nhà',
        Icon(
          Icons.android,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Căn hộ chung cư',
        Icon(
          Icons.flag,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Đất',
        Icon(
          Icons.format_indent_decrease,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Nhà xưởng',
        Icon(
          Icons.mobile_screen_share,
          color: const Color(0xFF167F67),
        )),
  ];
  List<Item> city = <Item>[
    const Item(
        'Hồ Chí Minh',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Hà Nội',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
  ];
  List<Item> town = <Item>[
    const Item(
        'Hồ Chí Minh',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Hà Nội',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
  ];
  List<Item> vil = <Item>[
    const Item(
        'Hồ Chí Minh',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
    const Item(
        'Hà Nội',
        Icon(
          Icons.home_work_sharp,
          color: const Color(0xFF167F67),
        )),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        title: Text(
          "Đăng tin bất động sản",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
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
                ])),
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
              return _store.regist_success
                  ? navigate(context)
                  : _showErrorMessage(_store.errorStore.errorMessage);
            },
          ),
          Observer(
            builder: (context) {
              return Visibility(
                visible: _store.regist_loading,
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
            _buildTileField(),
            SizedBox(height: 24.0),
            _buildTypeField(),
            SizedBox(height: 24.0),
            _buildTypeTypeField(),
            SizedBox(height: 24.0),
            // _buildUserEmail(),
            // SizedBox(height: 24.0),
            _buildCityField(),
            SizedBox(height: 24.0),
            _buildTownField(),
            SizedBox(height: 24.0),
            _buildVilField(),
            SizedBox(height: 24.0),
            _buildAcreageField(),
            SizedBox(height: 24.0),
            _buildPriceField(),
            SizedBox(height: 24.0),
            _buildStartdateField(),
            SizedBox(height: 24.0),
            _buildUpButton(),
          ],
        ),
      ),
    );
  }

//#region build TextFieldWidget
  Widget _buildTileField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Tiêu đề'),
          hintColor: Colors.white,
          icon: Icons.textsms_rounded,
          inputType: TextInputType.text,
          //  iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,
          textController: _TileController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
          },
        );
      },
    );
  }
  Widget _buildTypeField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: DropdownButton<Item>(
            hint: Text("Chọn loại hình"),
            value: selectedType,
            //icon:Icons.attach_file ,
            onChanged: (Item Value) {
              setState(() {
                selectedType = Value;
              });
            },
            items: type.map((Item type) {
              return DropdownMenuItem<Item>(
                value: type,
                child: Row(
                  children: <Widget>[
                    type.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  Widget _buildTypeTypeField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: DropdownButton<Item>(
            hint: Text("Chọn hình thức"),
            value: selectedTypeType,
            //icon:Icons.attach_file ,
            onChanged: (Item Value) {
              setState(() {
                selectedTypeType = Value;
              });
            },
            items: typetype.map((Item type) {
              return DropdownMenuItem<Item>(
                value: type,
                child: Row(
                  children: <Widget>[
                    type.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  Widget _buildCityField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: DropdownButton<Item>(
            hint: Text("Chọn tỉnh/thành phố"),
            value: selectedCity,
            //icon:Icons.attach_file ,
            onChanged: (Item Value) {
              setState(() {
                selectedCity = Value;
              });
            },
            items: city.map((Item type) {
              return DropdownMenuItem<Item>(
                value: type,
                child: Row(
                  children: <Widget>[
                    type.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  Widget _buildTownField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: DropdownButton<Item>(
            hint: Text("Chọn quận/huyện"),
            value: selectedTown,
            //icon:Icons.attach_file ,
            onChanged: (Item Value) {
              setState(() {
                selectedTown = Value;
              });
            },
            items: town.map((Item type) {
              return DropdownMenuItem<Item>(
                value: type,
                child: Row(
                  children: <Widget>[
                    type.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  Widget _buildVilField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: DropdownButton<Item>(
            hint: Text("Chọn phường/xã"),
            value: selectedVil,
            //icon:Icons.attach_file ,
            onChanged: (Item Value) {
              setState(() {
                selectedVil = Value;
              });
            },
            items: vil.map((Item type) {
              return DropdownMenuItem<Item>(
                value: type,
                child: Row(
                  children: <Widget>[
                    type.icon,
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      type.name,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }
  Widget _buildAcreageField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Diện tích'),
          hintColor: Colors.white,
          icon: Icons.textsms_rounded,
          inputType: TextInputType.text,
          // iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,
          textController: _AcreageController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
          },
        );
      },
    );
  }
  Widget _buildPriceField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Giá'),
          hintColor: Colors.white,
          icon: Icons.textsms_rounded,
          inputType: TextInputType.text,
//          iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,
          textController: _PriceController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            // _store.setTile(_TileController.text);
          },
          //errorText: _store.formErrorStore.Tile,
        );
      },
    );
  }
  Widget _buildStartdateField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "${selectedDate1st.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 24.0,
              ),
              RaisedButton(
                onPressed: () => _selectDate1st(context),
                child: Text(
                  'Chọn ngày bắt đầu',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                color: Colors.black45,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUserEmail() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Email'),
          hintColor: Colors.white,
          icon: Icons.email_rounded,
          inputType: TextInputType.text,
          //iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,

          textController: _userEmailController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {
            _store.setUserEmail(_userEmailController.text);
          },
          errorText: _store.formErrorStore.userEmail,
        );
      },
    );
  }

  Widget _buildUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Đăng tin'),
      buttonColor: Colors.black87,
      textColor: Colors.white,
      onPressed: () {
        // if(_store.canRegister) {
        //   DeviceUtils.hideKeyboard(context);
        // //   _store.register();
        // }
        // else{
        //   _showErrorMessage('Please fill in all fields');
        // }
        //});
      },
    );
  }
//endregion

  Widget navigate(BuildContext context) {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool(Preferences.is_logged_in, false);
    });
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
    });

    return Container();
  }

  // General Methods:-----------------------------------------------------------
  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('không được để trống'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _TileController.dispose();
    _AcreageController.dispose();
    _userEmailController.dispose();
    super.dispose();
  }
}
