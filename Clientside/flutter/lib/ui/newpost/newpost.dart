import 'dart:io';
import 'dart:typed_data';
import 'dart:async';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:text_editor/text_editor.dart';
import 'add_image.dart';
class NewpostScreen extends StatefulWidget {
  @override
  _NewpostScreenState createState() => _NewpostScreenState();
}

class Item {
  const Item(this.name, this.icon);
  final String name;
  final Icon icon;
}
class UploadImage {
  List<String> images;

  UploadImage({this.images});

  factory UploadImage.fromJson(Map<String, dynamic> json) {
    return UploadImage(images: parseImage(json['images']));
  }

  static List<String> parseImage(json) {
    return new List<String>.from(json);
  }
}

class _NewpostScreenState extends State<NewpostScreen> {
  //region text controllers
  TextEditingController _TileController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _AcreageController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _DescribeController = TextEditingController();

  //endregion
  final FormStore _store = new FormStore();
  //region Item
  Item selectedType;
  Item selectedTypeType;
  Item selectedCity;
  Item selectedTown;
  Item selectedVil;
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
//endregion
  //region Time
  //region Time
  DateTime selectedDate1st = DateTime.now();
  DateTime selectedDatefl = DateTime.now().add(const Duration(days: 1));

  _selectDate1st(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate1st,
      firstDate: DateTime.now(),
      lastDate: (DateTime.now().add(Duration(days: 10))),
    );
    if (picked != null && picked != selectedDate1st)
      setState(() {
        selectedDate1st = picked;
        selectedDatefl = selectedDate1st.add(const Duration(days: 1));
      });
  }

  _selectDatefl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDatefl,
      firstDate: selectedDate1st.add(const Duration(days: 1)),
      lastDate: selectedDate1st.add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDatefl)
      setState(() {
        selectedDatefl = picked;
      });
  }

//endregion
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        // Icon: Icons.app_registration,
        title: Text(
          "Đăng tin bất động sản",
          style: Theme.of(context).textTheme.button.copyWith(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0),
        ),
        leading: IconButton(
          icon: Icon(Icons.app_registration),
          onPressed: () {
            // Do something.
          },
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

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
            AppIconWidget(image: 'assets/icons/ic_appicon.png'),
            SizedBox(height: 24.0),
            _buildTileField(),
            SizedBox(height: 24.0),
            _buildTypeField(),
            SizedBox(height: 24.0),
            _buildTypeTypeField(),
            SizedBox(height: 24.0),
            _buildTownField2(),
            SizedBox(height: 24.0),
            _buildCityField(),
            SizedBox(height: 24.0),
            _buildVilField(),
            SizedBox(height: 24.0),
            _buildAcreageField(),
            SizedBox(height: 24.0),
            _buildPriceField(),
            SizedBox(height: 24.0),
            _buildStartdateField(),
            SizedBox(height: 24.0),
            _buildEnddateField(),
            SizedBox(height: 24.0),
            _builddDscribeField(),
            SizedBox(height: 24.0),
            _buildImagepick(),
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
          onChanged: (value) {},
        );
      },
    );
  }
  final fonts = [
    'OpenSans',
    'Billabong',
    'GrandHotel',
    'Oswald',
    'Quicksand',
    'BeautifulPeople',
    'BeautyMountains',
    'BiteChocolate',
    'BlackberryJam',
    'BunchBlossoms',
    'CinderelaRegular',
    'Countryside',
    'Halimun',
    'LemonJelly',
    'QuiteMagicalRegular',
    'Tomatoes',
    'TropicalAsianDemoRegular',
    'VeganStyle',
  ];
  TextStyle _textStyle = TextStyle(
    fontSize: 22,
    color: Colors.white,
    fontFamily: 'Billabong',
  );
  TextAlign _textAlign = TextAlign.center;
  Widget _buildTileField2() {
    return Observer(
      builder: (context) {
        return TextEditor(
          fonts: fonts,
          text: null,
          textStyle: _textStyle,
          textAlingment: _textAlign,
          decoration: EditorDecoration(
            doneButton: Icon(Icons.close, color: Colors.white),
            fontFamily: Icon(Icons.title, color: Colors.white),
            colorPalette: Icon(Icons.palette, color: Colors.white),
            alignment: AlignmentDecoration(
              left: Text(
                'left',
                style: TextStyle(color: Colors.white),
              ),
              center: Text(
                'center',
                style: TextStyle(color: Colors.white),
              ),
              right: Text(
                'right',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
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

  Widget _buildTownField2() {
    return Observer(builder: (context) {
      //var town1;
      return Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        child: DropdownSearch<String>(
          //mode: Mode.BOTTOM_SHEET,
          items: [
            "Brazil",
            "Italia",
            "Tunisia",
            'Canada',
            'Zraoua',
            'France',
            'Belgique'
          ],
          hint: "Chọn tỉnh/thành phố",
          onChanged: print,
          selectedItem: null,
          showSearchBox: true,
          searchBoxDecoration: InputDecoration(
            //border: OutlineInputBorder(),
            contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
            labelText: "Tìm tỉnh/thành phố",
          ),
          popupTitle: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColorDark,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                'Tỉnh/thành phố',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      );
    });
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
          icon: Icons.api_outlined,
          inputType:
              TextInputType.numberWithOptions(decimal: false, signed: false),
          // iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,
          textController: _AcreageController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
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
          icon: Icons.money,
          inputType: TextInputType.numberWithOptions(decimal: false),
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
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
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
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.black87,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEnddateField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                "${selectedDatefl.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 24.0,
              ),
              RaisedButton(
                onPressed: () => _selectDatefl(context),
                child: Text(
                  'Chọn ngày kết thúc',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                color: Colors.black87,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _builddDscribeField() {
    return Observer(
      builder: (context) {
        return TextFieldWidget(
          inputFontsize: 22,
          hint: ('Mô tả'),
          hintColor: Colors.white,
          icon: Icons.textsms_rounded,
          inputType: TextInputType.text,
          //  iconColor: _themeStore.darkMode ? Colors.amber : Colors.white,
          iconColor: Colors.white,
          textController: _DescribeController,
          inputAction: TextInputAction.next,
          autoFocus: false,
          onChanged: (value) {},
        );
      },
    );
  }

  Widget _buildImagepick()
  {
    return Observer(builder: (context)
    {
      return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddImage()));
        },
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
          title: AppLocalizations.of(context).translate('home_tv_error'),
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
