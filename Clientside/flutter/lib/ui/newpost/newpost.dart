import 'dart:async';
import 'dart:io';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/models/town/commune%20.dart';
import 'package:boilerplate/models/post/postpack/pack.dart';

import 'package:boilerplate/models/town/town.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/stores/form/form_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/app_icon_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  PostStore _postStore;
  TownStore _townStore;
  ImageStore _imageStore;
  //region text controllers
  TextEditingController _TileController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _AcreageController = TextEditingController();
  TextEditingController _userEmailController = TextEditingController();
  TextEditingController _DescribeController = TextEditingController();
  GlobalKey<FlutterSummernoteState> _keyEditor = GlobalKey();

  //endregion
  final FormStore _store = new FormStore();

  //region Item
  Postcategory selectedType;
  Postcategory selectedTypeType;
  Postcategory selectedTypeTypeType;
  Pack selectedPack;
  String postId;
  Town selectedTown = null;
  Commune selectedCommune = null;
  String selectedCity = null;
  String result = "";
  Item selectedVil;
  List<Commune> commune = [];
//endregion
  //region Time
  //region Time
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
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
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    _postStore = Provider.of<PostStore>(context);
    _townStore = Provider.of<TownStore>(context);
    // check to see if already called api
    if (!_postStore.loadinggetcategorys) {
      _postStore.getPostcategorys();
    }
    if(!_postStore.loading)
    { _postStore.getPosts();}
    if (!_townStore.loading) {
      _townStore.getTowns();
    }
    if (!_townStore.loadingCommune) {
      _townStore.getCommunes();
    }
    if (!_postStore.loadingPack) {
      _postStore.getPacks();
    }
  }

  @override
  void initState() {
    super.initState();
    // ifuserstore.loading
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        primary: true,
        appBar: AppBar(
          // Icon: Icons.app_registration,
          backgroundColor: Colors.amber,
          title: Text(
            "Đăng tin bất động sản",
            style: Theme.of(context).textTheme.button.copyWith(
                color: Colors.white,
                fontSize: 23,
                // backgroundColor:Colors.amber ,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.0),
          ),
          centerTitle: true,
        ),
        body: Material(child: _buildbody()));
  }

  Widget _buildbody() {
    return Stack(children: <Widget>[
      _handleErrorMessage(),
      _buildMainContent(),
    ]);
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_postStore.errorStore.errorMessage.isNotEmpty) {
          return _showErrorMessage(_postStore.errorStore.errorMessage);
        }

        return SizedBox.shrink();
      },
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _postStore.loadinggetcategorys
            ? CustomProgressIndicatorWidget()
            : Material(child: _buildBody());
      },
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
                  Colors.amber[600],
                  Colors.amber[50],
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
            _buildCityField(),
            SizedBox(height: 24.0),
            _buildTownField(),
            _buildCommuneField(),
            _buildTypeField(),
            SizedBox(height: 24.0),
            _buildTypeTypeField(),
            _buildTypeTypeTypeField(),
            //_buildVilField(),
            _buildAcreageField(),
            SizedBox(height: 24.0),
            _buildPriceField(),
            SizedBox(height: 24.0),
            _buildPackField(),
            SizedBox(height: 24.0),
            //_textpackmota(),

            _buildPackinfoField(),
            SizedBox(height: 24.0),
            _buildStartdateField(),
            SizedBox(height: 24.0),
            _buildTileField2(),
            SizedBox(height: 24.0),
            _buildImagepick(),
            SizedBox(height: 24.0),
            //_buildImagepick2(),
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

  Widget _buildTypeField() {
    List<Postcategory> type = [];
    for (var i = 0; i < _postStore.postCategoryList.categorys.length; i++)
      if (_postStore.postCategoryList.categorys[i].danhMucCha ==
          null) if (_postStore.postCategoryList.categorys[i] != null)
        type.add(_postStore.postCategoryList.categorys[i]);
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: DropdownButton<Postcategory>(
        hint: Text("Chọn phương thức"),
        value: selectedType,
        onChanged: (Postcategory Value) {
          setState(() {
            try {
              selectedType = Value;
              selectedTypeType = null;
            } catch (_) {
              selectedType = type[0];
            }
          });
        },
        items: type.map((Postcategory type) {
          if (type.danhMucCha == null)
            return DropdownMenuItem<Postcategory>(
              value: type,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.home_work_sharp,
                    color: const Color(0xFF167F67),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    type.tenDanhMuc,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          else
            return
                //Container(width: 0, height: 0);
                DropdownMenuItem<Postcategory>(
              value: type,
              child: SizedBox(height: 0),
            );
        }).toList(),
      ),
    );
  }

  Widget _buildTypeTypeField() {
    List<Postcategory> typetype = [];
    if (selectedType != null) {
      for (var i = 0; i < _postStore.postCategoryList.categorys.length; i++)
        if (_postStore.postCategoryList.categorys[i].danhMucCha ==
            selectedType
                .id) if (_postStore.postCategoryList.categorys[i] != null)
          typetype.add(_postStore.postCategoryList.categorys[i]);

      if (typetype.length != 0)
        return Observer(
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 24.0),
              child: DropdownButton<Postcategory>(
                hint: Text("Chọn hình thức nhà đất"),
                value: selectedTypeType,
                //icon:Icons.attach_file ,
                onChanged: (Postcategory Value) {
                  setState(() {
                    selectedTypeType = Value;
                    selectedTypeTypeType = null;
                  });
                },
                items: typetype.map((Postcategory type) {
                  return DropdownMenuItem<Postcategory>(
                    value: type,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home_work_sharp,
                          color: const Color(0xFF167F67),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          type.tenDanhMuc,
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
      else {
        selectedTypeType = null;
        return Container(height: 0, width: 0);
      }
    } else
      return Container(height: 0, width: 0);
  }

  Widget _buildTypeTypeTypeField() {
    List<Postcategory> typetypetype = [];
    if (selectedTypeType != null) {
      for (var i = 0; i < _postStore.postCategoryList.categorys.length; i++)
        if (_postStore.postCategoryList.categorys[i].danhMucCha ==
            selectedTypeType
                .id) if (_postStore.postCategoryList.categorys[i] != null)
          typetypetype.add(_postStore.postCategoryList.categorys[i]);
      if (typetypetype.length != 0)
        return Observer(
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 10.0, bottom: 24.0),
              child: DropdownButton<Postcategory>(
                hint: Text("Chọn hình thức nhà đất bổ sung"),
                value: selectedTypeTypeType,
                //icon:Icons.attach_file ,
                onChanged: (Postcategory Value) {
                  setState(() {
                    selectedTypeTypeType = Value;
                  });
                },
                items: typetypetype.map((Postcategory type) {
                  return DropdownMenuItem<Postcategory>(
                    value: type,
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.home_work_sharp,
                          color: const Color(0xFF167F67),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          type.tenDanhMuc,
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
      else {
        selectedTypeTypeType = null;
        return Container(height: 0, width: 0);
      }
    } else
      return Container(height: 0, width: 0);
  }

  Widget _buildCityField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 10.0),
          child: DropdownSearch<String>(
            //mode: Mode.BOTTOM_SHEET,
            items: [
              "Thành phố Hà Nội",
              "Tỉnh Hà Giang",
              "Tỉnh Cao Bằng",
              "Tỉnh Bắc Kạn",
              "Tỉnh Tuyên Quang",
              "Tỉnh Lào Cai",
              "Tỉnh Điện Biên",
              "Tỉnh Lai Châu",
              "Tỉnh Sơn La",
              "Tỉnh Yên Bái",
              "Tỉnh Hoà Bình",
              "Tỉnh Thái Nguyên",
              "Tỉnh Lạng Sơn",
              "Tỉnh Quảng Ninh",
              "Tỉnh Bắc Giang",
              "Tỉnh Phú Thọ",
              "Tỉnh Vĩnh Phúc",
              "Tỉnh Bắc Ninh",
              "Tỉnh Hải Dương",
              "Thành phố Hải Phòng",
              "Tỉnh Hưng Yên",
              "Tỉnh Thái Bình",
              "Tỉnh Hà Nam",
              "Tỉnh Nam Định",
              "Tỉnh Ninh Bình",
              "Tỉnh Thanh Hóa",
              "Tỉnh Nghệ An",
              "Tỉnh Hà Tĩnh",
              "Tỉnh Quảng Bình",
              "Tỉnh Quảng Trị",
              "Tỉnh Thừa Thiên Huế",
              "Thành phố Đà Nẵng",
              "Tỉnh Quảng Nam",
              "Tỉnh Quảng Ngãi",
              "Tỉnh Bình Định",
              "Tỉnh Phú Yên",
              "Tỉnh Khánh Hòa",
              "Tỉnh Ninh Thuận",
              "Tỉnh Bình Thuận",
              "Tỉnh Kon Tum",
              "Tỉnh Gia Lai",
              "Tỉnh Đắk Lắk",
              "Tỉnh Đắk Nông",
              "Tỉnh Lâm Đồng",
              "Tỉnh Bình Phước",
              "Tỉnh Tây Ninh",
              "Tỉnh Bình Dương",
              "Tỉnh Đồng Nai",
              "Tỉnh Bà Rịa - Vũng Tàu",
              "Thành phố Hồ Chí Minh",
              "Tỉnh Long An",
              "Tỉnh Tiền Giang",
              "Tỉnh Bến Tre",
              "Tỉnh Trà Vinh",
              "Tỉnh Vĩnh Long",
              "Tỉnh Đồng Tháp",
              "Tỉnh An Giang",
              "Tỉnh Kiên Giang",
              "Thành phố Cần Thơ",
              "Tỉnh Hậu Giang",
              "Tỉnh Sóc Trăng",
              "Tỉnh Bạc Liêu",
              "Tỉnh Cà Mau",
            ],
            hint: "Chọn tỉnh/thành phố",
            onChanged: (String Value) {
              setState(() {
                selectedCity = Value;
                selectedTown = null;
              });
            },
            selectedItem: null,
            showSearchBox: true,
            searchBoxDecoration: InputDecoration(
              border: OutlineInputBorder(),
              // contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
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
      },
    );
  }

  Widget _buildTownField() {
    if (selectedCity != null) {
      List<Town> town = [];
      for (var i = 0; i < _townStore.townList.towns.length; i++)
        if (_townStore.townList.towns[i].tinhTenTinh == selectedCity)
          town.add(_townStore.townList.towns[i]);
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 10.0, bottom: 24.0),
        child: DropdownButton<Town>(
          hint: Text("Chọn quận/huyện"),
          value: selectedTown,
          //icon:Icons.attach_file ,
          onChanged: (Town Value) {
            setState(() {
              selectedTown = Value;
              selectedCommune = null;
              commune = [];
              for (var i = 0; i < _townStore.communeList.communes.length; i++)
                if (_townStore.communeList.communes[i].huyenTenHuyen ==
                    selectedTown.tenHuyen)
                  commune.add(_townStore.communeList.communes[i]);
            });
          },
          items: town.map((Town type) {
            return DropdownMenuItem<Town>(
              value: type,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.blur_circular,
                    color: const Color(0xFF167F67),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    type.tenHuyen,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else
      return Container(
        height: 0,
        width: 0,
      );
  }

  Widget _buildCommuneField() {
    if (selectedTown != null) {
      return Padding(
        padding: const EdgeInsets.only(left: 40.0, right: 10.0, bottom: 24.0),
        child: DropdownButton<Commune>(
          hint: Text("Chọn xã/phường"),
          value: selectedCommune,
          //icon:Icons.attach_file ,
          onChanged: (Commune Value) {
            setState(() {
              selectedCommune = Value;
            });
          },
          items: commune.map((Commune type) {
            return DropdownMenuItem<Commune>(
              value: type,
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.blur_circular,
                    color: const Color(0xFF167F67),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    type.tenXa,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      );
    } else
      return Container(
        height: 0,
        width: 0,
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
          hint: ('Giá bán'),
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

  Widget _buildPackField() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: DropdownButton<Pack>(
        hint: Text("Chọn gói bài đăng"),
        value: selectedPack,
        onChanged: (Pack Value) {
          setState(() {
            selectedPack = Value;
          });
        },
        items: _postStore.packList.packs.map((Pack type) {
          return DropdownMenuItem<Pack>(
            value: type,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                  color: const Color(0xFF167F67),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  type.tenGoi,
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // Widget _textpackmota()
  // {
  //   return selectedPack!=null?
  //     Text(
  //       "Chi phí gói bài đăng: ${selectedPack.phi}",
  //       style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
  //       textAlign:TextAlign.left ,
  //     )
  //       :Container(width: 0,height: 0);
  // }
  Widget _buildPackinfoField() {
    return selectedPack != null
        ?
        // Padding(
        //     // padding: const EdgeInsets.only(left: 0.0, right: 0.0),
        //     child:
        //     Column(
        //       //mainAxisSize: MainAxisSize.min,
        //       children:
        //       <Widget>[
        //
        //         SizedBox(
        //           height: 24.0,
        //         ),
        Text(
            "Mô tả: ${selectedPack.moTa}",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            //   SizedBox(
            //     height: 24.0,
            //   ),
            //   Text(
            //     "Độ ưu tiên: ${selectedPack.doUuTien}",
            //     textAlign:TextAlign.left ,
            //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            //   ),
            // ],
          )
        // )
        : Container(
            width: 0,
            height: 0,
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
              Center(
                  child: Text(
                "Ngày bắt đầu:" + "${selectedDate1st.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.left,
              )),
              SizedBox(
                height: 24.0,
              ),
              RoundedButtonWidget(
                buttonColor: Colors.orangeAccent,
                textColor: Colors.white,
                onPressed: () => _selectDate1st(context),
                buttonText: ('Chọn ngày bắt đầu'),
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

  Widget _buildTileField2() {
    //  print(result);
    return Observer(
      builder: (context) {
        return SingleChildScrollView(
          child: FlutterSummernote(
            height: 180.0,
            decoration: BoxDecoration(
              color: Colors.amber[100],
              borderRadius: BorderRadius.circular(12),
            ),
            hint: "Mô tả thêm về bài đăng",
            //   final _etEditor = await _keyEditor.currentState.getText();
            // print(_etEditor);
            key: _keyEditor,
            value: result,
            hasAttachment: false,
            customToolbar: """
                  [
                      ['style', ['bold', 'italic', 'underline']],
                      ['font', ['strikethrough', 'superscript', 'subscript']]
                  ]
                """,
            showBottomToolbar: true,
          ),
        );
      },
    );
  }

  List<File> _image = [];
  final picker = ImagePicker();
  chooseImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      _image.add(File(pickedFile?.path));
    });
    // if (pickedFile.path == null) retrieveLostData();
  }

  Widget _buildImagepick() {
    return Observer(
      builder: (context) {
        return FloatingActionButton(
            child: Icon(Icons.camera_enhance_rounded),
            onPressed: () async {
              chooseImage();
              _imageStore.postImages(_image.last.path.toString(), true);
              //_imageStore.getImagesForDetail((_postStore.postList.posts.last.id+1).toString());
            }
            // Navigator.of(context)
            //     .push(MaterialPageRoute(builder: (context) => AddImage()));
            // },
            );
      },
    );
  }

  Widget _buildUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Đăng tin'),
      buttonColor: Colors.amber[700],
      textColor: Colors.white,
      onPressed: () {},
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
}
