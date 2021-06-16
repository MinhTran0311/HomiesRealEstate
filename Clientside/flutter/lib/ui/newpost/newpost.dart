import 'dart:async';
import 'dart:io';
import 'package:boilerplate/constants/strings.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/image/image.dart';
import 'package:boilerplate/models/post/hoadonbaidang/hoadonbaidang.dart';
import 'package:boilerplate/models/post/newpost/newpost.dart';
import 'package:boilerplate/models/post/post.dart';
import 'package:boilerplate/models/post/postProperties/postProperty.dart';
import 'package:boilerplate/models/post/post_category.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh.dart';
import 'package:boilerplate/models/post/propertiesforpost/ThuocTinh_list.dart';
import 'package:boilerplate/models/town/commune.dart';
import 'package:boilerplate/models/post/postpack/pack.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/ui/profile/wallet/wallet.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:boilerplate/models/town/town.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/postDetail/build_properties.dart';

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
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_summernote/flutter_summernote.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';

class NewpostScreen extends StatefulWidget {
  @override
  _NewpostScreenState createState() => _NewpostScreenState();
}

class _NewpostScreenState extends State<NewpostScreen> {
  PostStore _postStore;
  TownStore _townStore;
  ImageStore _imageStore;
  UserStore _userStore;
  ThemeStore _themeStore;

  //region text controllers
  TextEditingController _TileController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _AcreageController = TextEditingController();
  TextEditingController _keyEditor2 = TextEditingController();
  var _ThuocTinhController = new List<TextEditingController>(20);

  TextEditingController _LocateController = TextEditingController();
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
  int songay = 0;
  Town selectedTown = null;
  Commune selectedCommune = null;
  String selectedCity = null;
  String selectedhuongnha = null;
  String selectedhuongbancong = null;
  List<String> Huong = new List<String>();

  String result = "";
  List<Commune> commune = [];
//endregion
  //region Time
  //region Time
  DateFormat dateFormat = DateFormat("yyyy-MM-ddTHH:mm:ss");
  DateTime selectedDatefl = null;
  _selectDatefl(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      locale: const Locale('en', ''),
      initialDate: selectedDatefl,
      firstDate:
          DateTime.now().add(Duration(days: selectedPack.thoiGianToiThieu)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != selectedDatefl)
      setState(() {
        selectedDatefl = picked;
        songay = 0;
        while (selectedDatefl
            .isAfter(DateTime.now().add(Duration(days: songay)))) songay++;
      });
  }

//endregion

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // initializing stores
    //set initialLoading = true ;
    _postStore = Provider.of<PostStore>(context);
    _townStore = Provider.of<TownStore>(context);
    _userStore = Provider.of<UserStore>(context);
    _imageStore = Provider.of<ImageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    if (!_postStore.loadinggetcategorys) {
      _postStore.getPostcategorys();
    }
    if (!_townStore.loading) {
      _townStore.getTowns();
    }
    if (!_townStore.loadingCommune) {
      _townStore.getCommunes();
      _townStore.isIntialLoading = true;
    }
    if (!_postStore.loadingPack) {
      _postStore.getPacks();
    }
    if (!_postStore.loadingThuocTinh) {
      _postStore.getThuocTinhs();
    }
    if (!_userStore.loadingCurrentUserWallet) {
      _userStore.getCurrentWalletUser();
    }
    // if (!_userStore.loadingCurrentUserWallet) {
    //   _userStore.getCurrentWalletUser();
    // }
  }

  @override
  void initState() {
    super.initState();
    Huong = [
      "Đông",
      "Đông bắc",
      "Đông nam",
      "Tây",
      "Tây nam",
      "Tây bắc",
      "Nam",
      "Bắc"
    ];
    songay = 0;
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
          title: Text("Đăng tin bất động sản"),
          //actions: _buildActions(context),
          centerTitle: true,
        ),
        body: WillPopScope(
            onWillPop: () {
              return;
            },
            child: _buildbody()));
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
          return showErrorMessage(_postStore.errorStore.errorMessage, context);
        }
        if (_postStore.successNewpost) {
          showSuccssfullMesssage("Đăng tin thành công", context);
          //dispose();.
          _postStore.successNewpost = false;
          _postStore.getPostForCurs(false, "", 0);
          Future.delayed(Duration(milliseconds: 3000), () {
            Route route = MaterialPageRoute(
                builder: (context) =>
                    Detail(post: _postStore.postForCurList.posts.first));
            Navigator.push(context, route);
          });
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return !_postStore.loadinggetcategorys &&
                !_townStore.loadingCommune &&
                !_postStore.loadingThuocTinh &&
                !_postStore.loadingPack &&
                !_userStore.loadingCurrentUserWallet
            ? _buildBody()
            : CustomProgressIndicatorWidget();
      },
    );
  }

  Widget _buildBody() {
    var _formKey;
    return Material(
        child: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Stack(
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
        ],
      ),
    ));
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
            _buildLocateField(),
            SizedBox(height: 24.0),
            _buildTypeField(),
            SizedBox(height: 24.0),
            _buildTypeTypeField(),
            _buildTypeTypeTypeField(),
            _buildAcreageField(),
            SizedBox(height: 24.0),
            _buildPriceField(),
            SizedBox(height: 24.0),
            _buildListView(),
            SizedBox(height: 24.0),
            _buildPackField(),
            SizedBox(height: 24.0),
            _buildPackinfoField(),
            SizedBox(height: 24.0),
            _buildEnddateField(),
            _buildTileField2(),
            SizedBox(height: 24.0),
            _buildImagepick2(),
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
        var _formKey;
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.textsms_rounded,
                      color:
                          _themeStore.darkMode ? Colors.white : Colors.amber),
                  labelStyle: TextStyle(
                    color: (_themeStore.darkMode) ? Colors.white : Colors.black,
                  ),
                  hintText: 'Tối đa 50 kí tự',
                  labelText: 'Tiêu đề',
                  suffixIcon: IconButton(
                    onPressed: () => _TileController.clear(),
                    icon: Icon(Icons.clear,
                        color:
                            _themeStore.darkMode ? Colors.white : Colors.amber),
                  ),
                ),
                cursorColor: _themeStore.darkMode ? Colors.white : Colors.amber,
                controller: _TileController,
                validator: (value) {
                  if (value == null || value.isEmpty || value.length > 50) {
                    return 'Vui lòng điền lại tiêu đề';
                  }
                  return null;
                },
              ),
            ]));
      },
    );
  }

  Widget _buildTypeField() {
    List<Postcategory> type = [];
    if (_postStore.postCategoryList.categorys.length == 0)
      return Container(
        height: 0,
      );
    var _formKey;
    for (var i = 0; i < _postStore.postCategoryList.categorys.length; i++)
      if (_postStore.postCategoryList.categorys[i].danhMucCha ==
          null) if (_postStore.postCategoryList.categorys[i] != null)
        type.add(_postStore.postCategoryList.categorys[i]);
    return Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: DropdownButtonFormField<Postcategory>(
          hint: Text("Chọn phương thức "),
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
          decoration: InputDecoration(
              suffixIcon: IconButton(
            onPressed: () => setState(() {
              selectedType = null;
            }),
            icon: Icon(Icons.clear),
          )),
          validator: (value) =>
              value == null ? 'Vui lòng chọn phương thức' : null,
          items: type.map((Postcategory type) {
            if (type.danhMucCha == null)
              return DropdownMenuItem<Postcategory>(
                value: type,
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
                      type.tenDanhMuc,
                      style: TextStyle(),
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
        ));
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
              child: DropdownButtonFormField<Postcategory>(
                hint: Text("Chọn hình thức nhà đất"),
                autovalidateMode: AutovalidateMode.always,
                validator: (value) =>
                    value == null ? 'Vui lòng chọn hình thức nhà đất' : null,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    selectedTypeType = null;
                  }),
                  icon: Icon(Icons.clear),
                )),
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
              child: DropdownButtonFormField<Postcategory>(
                hint: Text("Chọn hình thức bổ sung"),
                value: selectedTypeTypeType,
                //icon:Icons.attach_file ,
                onChanged: (Postcategory Value) {
                  setState(() {
                    selectedTypeTypeType = Value;
                  });
                },
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                  onPressed: () => setState(() {
                    selectedTypeTypeType = null;
                  }),
                  icon: Icon(Icons.clear),
                )),
                items: typetypetype.map((Postcategory type) {
                  return DropdownMenuItem<Postcategory>(
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
        selectedTypeTypeType = selectedTypeType;
        return Container(height: 0, width: 0);
      }
    } else
      return Container(height: 0, width: 0);
  }

  Widget _buildCityField() {
    return Observer(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(left: 0.0, right: 0.0),
          child: DropdownSearch<String>(
            autoValidateMode: AutovalidateMode.always,
            validator: (value) =>
                value == null ? 'Vui lòng chọn tỉnh/thành' : null,
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
            showClearButton: true,
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
              labelText: "Tìm tỉnh/thành phố",
            ),
            popupTitle: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
                // borderRadius: BorderRadius.only(
                //   topLeft: Radius.circular(20),
                //   topRight: Radius.circular(20),
                // ),
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
        padding: const EdgeInsets.only(left: 20.0, right: 0.0, bottom: 24.0),
        child: DropdownButtonFormField<Town>(
          hint: Text("Chọn quận/huyện"),
          value: selectedTown,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) =>
              value == null ? 'Vui lòng chọn quận huyện' : null,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            onPressed: () => setState(() {
              selectedTown = null;
            }),
            icon: Icon(Icons.clear),
          )),
          //icon:Icons.attach_file ,
          onChanged: (Town Value) {
            setState(() {
              selectedTown = Value;
              selectedCommune = null;
              commune = [];
              for (var i = 0; i < _townStore.communeList.communes.length; i++)
                if (_townStore.communeList.communes[i].huyenId ==
                    selectedTown.id)
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
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    type.tenHuyen,
                    style: TextStyle(),
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
        padding: const EdgeInsets.only(left: 39.0, right: 0.0, bottom: 24.0),
        child: DropdownButtonFormField<Commune>(
          hint: Text("Chọn xã/phường"),
          autovalidateMode: AutovalidateMode.always,
          validator: (value) =>
              value == null ? 'Vui lòng chọn xã/phường' : null,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            onPressed: () => setState(() {
              selectedCommune = null;
            }),
            icon: Icon(Icons.clear),
          )),
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
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    type.tenXa.length <= 22
                        ? type.tenXa
                        : type.tenXa = type.tenXa.substring(0, 20) + "..",
                    style: TextStyle(),
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

  Widget _buildLocateField() {
    return Observer(
      builder: (context) {
        var _formKey;
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.home,
                          color: _themeStore.darkMode
                              ? Colors.white
                              : Colors.amber),
                      labelStyle: TextStyle(
                        color: (_themeStore.darkMode)
                            ? Colors.white
                            : Colors.black,
                      ),
                      hintText: 'Số nhà/tên khu phố',
                      suffixIcon: IconButton(
                        onPressed: () => _LocateController.clear(),
                        icon: Icon(Icons.clear),
                      ),
                      labelText: ('Địa chỉ'),
                    ),
                    onSaved: (value) {
                      // //  FormState.save();
                      //   print(value);
                      //   // code when the user saves the form.
                    },
                    controller: _LocateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập địa chỉ';
                      }
                      return null;
                    },
                  ),
                ]));
      },
    );
  }

  Widget _buildListView() {
    return Observer(builder: (context) {
      return !_postStore.loadingThuocTinh
          ? SingleChildScrollView(
              child: ExpansionTile(
                  title: Text(
                    "Một số thông tin thêm(nếu có)",
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  tilePadding: EdgeInsets.only(top: 0.0),
                  //.all(0),
                  children: <Widget>[
                  Container(
                    height: 200,
                    child: ListView.builder(
                      itemCount: _postStore.thuocTinhList.thuocTinhs.length - 2,
                      itemBuilder: (context, i) {
                        //_ThuocTinhController.add(new TextEditingController());
                        return _buildThuocTinh(
                            _postStore.thuocTinhList.thuocTinhs[i + 2], i);
                      },
                    ),
                  )
                ]))
          : Container(
              height: 0,
              width: 0,
            );
      //       :  Text(
      //             "Không có thuộc tính thêm hiển thị",
      //         );
    });
  }

  Widget _buildThuocTinh(ThuocTinh thuocTinh, int index) {
    return thuocTinh != null
        ? Observer(builder: (context) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  thuocTinh.tenThuocTinh != "Hướng nhà" &&
                          thuocTinh.tenThuocTinh != "Hướng ban công"
                      ? TextFormField(
                          autofocus: false,
                          decoration: InputDecoration(
                            icon: Icon(Icons.home_work,
                                color: _themeStore.darkMode
                                    ? Colors.white
                                    : Colors.amber),
                            labelStyle: TextStyle(
                              color: (_themeStore.darkMode)
                                  ? Colors.white
                                  : Colors.black,
                            ),
                            fillColor: Colors.white,
                            labelText: '${thuocTinh.tenThuocTinh}',
                            suffixIcon: IconButton(
                              onPressed: () =>
                                  _ThuocTinhController[index].clear(),
                              icon: Icon(Icons.clear),
                            ),
                            //hintText: "${thuocTinh.kieuDuLieu}",
                          ),
                          onSaved: (value) {},
                          keyboardType: thuocTinh.kieuDuLieu == "double" ||
                                  thuocTinh.kieuDuLieu == "int"
                              ? TextInputType.numberWithOptions(
                                  decimal: false, signed: false)
                              : TextInputType.text,
                          controller: _ThuocTinhController[index],
                          onChanged: (value) {
                            _ThuocTinhController[index] =
                                new TextEditingController(text: value);
                          },
                        )
                      : DropdownButtonFormField<String>(
                          hint: thuocTinh.tenThuocTinh == "Hướng nhà"
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.directions,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Chọn hướng nhà"),
                                  ],
                                )
                              : Row(children: [
                                  Icon(
                                    Icons.directions,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Chọn hướng ban công")
                                ]),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                            onPressed: () => setState(() {
                              _ThuocTinhController[index] =
                                  new TextEditingController();
                              thuocTinh.tenThuocTinh == "Hướng nhà"
                                  ? selectedhuongnha = null
                                  : selectedhuongbancong = null;
                            }),
                            icon: Icon(Icons.clear),
                          )),
                          value: thuocTinh.tenThuocTinh == "Hướng nhà"
                              ? selectedhuongnha
                              : selectedhuongbancong,
                          onChanged: (String value) {
                            setState(() {
                              thuocTinh.tenThuocTinh == "Hướng nhà"
                                  ? selectedhuongnha = value
                                  : selectedhuongbancong = value;
                              _ThuocTinhController[index] =
                                  TextEditingController(text: value);
                            });
                          },
                          items: Huong.map((String type) {
                            return DropdownMenuItem<String>(
                                value: type,
                                child: Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.directions,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      type,
                                      style: TextStyle(),
                                    ),
                                  ],
                                ));
                          }).toList(),
                        ),
                  SizedBox(height: 24.0),
                ]);
          })
        : Container(
            height: 0,
          );
  }

  Widget _buildAcreageField() {
    return Observer(
      builder: (context) {
        var _formKey;
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                        icon: Icon(Icons.api,
                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.amber),
                        labelStyle: TextStyle(
                          color: (_themeStore.darkMode)
                              ? Colors.white
                              : Colors.black,
                        ),
                        labelText: 'Diện tích',
                        suffixIcon: IconButton(
                          onPressed: () => _AcreageController.clear(),
                          icon: Icon(Icons.clear),
                        ),
                        hintText: "mxm"),
                    onSaved: (value) {},
                    keyboardType: TextInputType.number,
                    controller: _AcreageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền diện tích';
                      }
                      return null;
                    },
                  ),
                ]));
      },
    );
  }

  Widget _buildPriceField() {
    return Observer(
      builder: (context) {
        var _formKey;
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    autofocus: false,
                    decoration: InputDecoration(
                      icon: Icon(Icons.money,
                          color: _themeStore.darkMode
                              ? Colors.white
                              : Colors.amber),
                      labelStyle: TextStyle(
                        color: (_themeStore.darkMode)
                            ? Colors.white
                            : Colors.black,
                      ),
                      labelText: 'Giá bán',
                      suffixIcon: IconButton(
                        onPressed: () => _PriceController.clear(),
                        icon: Icon(Icons.clear),
                      ),
                      hintText: "VND",
                    ),
                    onSaved: (value) {},
                    keyboardType: TextInputType.number,
                    controller: _PriceController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng điền giá bán';
                      }
                      return null;
                    },
                  ),
                ]));
      },
    );
  }

  Widget _buildTileField2() {
    return Observer(
      builder: (context) {
        var _formKey;
        return Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
                    Widget>[
              TextFormField(
                autofocus: false,
                decoration: InputDecoration(
                  icon: Icon(Icons.textsms_rounded,
                      color:
                          _themeStore.darkMode ? Colors.white : Colors.amber),
                  labelStyle: TextStyle(
                    color: (_themeStore.darkMode) ? Colors.white : Colors.black,
                  ),
                  labelText: 'Mô tả',
                  hintText: "Mô tả thêm về bài đăng",
                  suffixIcon: IconButton(
                    onPressed: () => _keyEditor2.clear(),
                    icon: Icon(
                      Icons.clear,
                      color: _themeStore.darkMode ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                onSaved: (value) {},
                //keyboardType: TextInputType.number,
                controller: _keyEditor2,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập mô tả';
                  }
                  if (value.length > 1000) return null;
                  return null;
                },
              ),
            ]));
      },
    );
  }

  Widget _buildPackField() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 10.0),
      child: DropdownButtonFormField<Pack>(
        hint: Text("Chọn gói bài đăng"),
        value: selectedPack,
        autovalidateMode: AutovalidateMode.always,
        validator: (value) => value == null ? 'Vui lòng gói bài đăng' : null,
        decoration: InputDecoration(
            suffixIcon: IconButton(
          onPressed: () => setState(() {
            selectedPack = null;
          }),
          icon: Icon(Icons.clear),
        )),
        onChanged: (Pack Value) {
          setState(() {
            selectedPack = Value;
            songay = selectedPack.thoiGianToiThieu;
            selectedDatefl = DateTime.now()
                .add(Duration(days: selectedPack.thoiGianToiThieu));
          });
        },
        items: _postStore.packList.packs.map((Pack type) {
          return DropdownMenuItem<Pack>(
            value: type,
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.account_circle,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  type.tenGoi + ", phí: " + priceFormat(type.phi),
                  style: TextStyle(),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildPackinfoField() {
    return selectedPack != null
        ? Text(
            "Mô tả: ${selectedPack.moTa}",
            textAlign: TextAlign.left,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          )
        : Container(
            width: 0,
            height: 0,
          );
  }

  Widget _buildEnddateField() {
    return selectedPack != null
        ? Observer(
            builder: (context) {
              return Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RoundedButtonWidget(
                      onPressed: () => _selectDatefl(context),
                      buttonColor: Colors.amber,
                      textColor: Colors.white,
                      buttonText: ('Chọn ngày kết thúc'),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "Ngày kết thúc:" +
                          "${selectedDatefl.toLocal()}".split(' ')[0],
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Text(
                      "Phí bài đăng:" +
                          "${priceFormat(selectedPack.phi * songay)}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                  ],
                ),
              );
            },
          )
        : Container(
            height: 0,
          );
  }

  List<File> _image = [];
  final picker = ImagePicker();
  Future getImage(bool gallery) async {
    ImagePicker picker = ImagePicker();
    PickedFile pickedFile;
    // Let user select photo from gallery
    if (gallery) {
      pickedFile = await picker.getImage(
        source: ImageSource.gallery,
      );
    }
    // Otherwise open camera to get new photo
    else {
      pickedFile = await picker.getImage(
        source: ImageSource.camera,
      );
    }

    setState(() {
      if (pickedFile != null) {
        _image.add(File(pickedFile.path));
        _imageStore.postImages(pickedFile.path,
            "Dangtinbdstieude-${_TileController.text}-_${_image.length}");
      } else {
        print('No image selected.');
      }
    });
  }

  Future clearimage(i) async {
    {
      setState(() {
        _image.removeAt(i);
        _imageStore.imageListpost.removeAt(i);
      });
    }
  }

  Widget _buildImagepick2() {
    return Observer(
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(4),
          child: _image.length == 0
              ? Center(
                  child: IconButton(
                  icon: Icon(
                    Icons.add_photo_alternate_rounded,
                    color: !_themeStore.darkMode
                        ? Colors.amber
                        : Color.fromRGBO(30, 32, 38, 1),
                  ),
                  iconSize: 150,
                  onPressed: () => getImage(true),
                ))
              : GridView.builder(
                  itemCount: _image.length + 1,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return index == _image.length
                        ? _image.length < 6
                            ? Center(
                                child: IconButton(
                                icon: Icon(Icons.add_photo_alternate_rounded),
                                onPressed: () => getImage(true),
                              ))
                            : Container(
                                height: 0,
                              )
                        : Container(
                            margin: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: FileImage(_image[index]),
                                    fit: BoxFit.cover)),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: FlatButton(
                                padding:
                                    EdgeInsets.only(left: 70.0, bottom: 70.0),
                                onPressed: () => {clearimage(index)},
                                child: Icon(
                                  Icons.dangerous,
                                  color: Colors.white,
                                  size: 20.0,
                                ),
                              ),
                            ));
                  }),
        );
      },
    );
  }

  showAlertDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Cảnh báo"),
      content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _TileController.value.text.isEmpty
                ? Text('Vui lòng nhập tiêu đề')
                : Container(
                    height: 0,
                  ),
            _PriceController.value.text.isEmpty
                ? Text('Vui lòng nhập giá')
                : Container(
                    height: 0,
                  ),
            _AcreageController.value.text.isEmpty
                ? Text('Vui lòng nhập diện tích')
                : Container(
                    height: 0,
                  ),
            selectedCommune == null
                ? Text('Vui lòng chọn địa chỉ')
                : Container(
                    height: 0,
                  ),
            selectedPack == null
                ? Text('Vui lòng chọn gói bài đăng')
                : Container(
                    height: 0,
                  ),
            selectedTypeTypeType == null
                ? Text('Vui lòng chọn hình thức nhà/đất')
                : Container(
                    height: 0,
                  ),
            _image.length == 0
                ? Text('Vui lòng thêm hình ảnh cho bài đăng')
                : Container(
                    height: 0,
                  ),
          ]),
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  var _newpost = new Newpost();
  var sc = false;
  Widget _buildUpButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
        buttonText: ('Đăng tin'),
        buttonColor:
            !_imageStore.imageLoadingpost ? Colors.amber[700] : Colors.grey,
        textColor: Colors.white,
        onPressed: () async {
          {
            if (_TileController.value.text.isEmpty ||
                _PriceController.value.text.isEmpty ||
                _AcreageController.value.text.isEmpty ||
                selectedCommune == null ||
                selectedPack == null ||
                selectedTypeTypeType == null ||
                _image.length == 0)
              showAlertDialog(context);
            else {
              var post = new Post();
              post.tenXa = selectedCommune.tenXa;
              post.xaId = selectedCommune.id;
              post.danhMuc = selectedTypeTypeType.tenDanhMuc;
              post.danhMucId = selectedTypeTypeType.id;
              post.dienTich = double.parse(_AcreageController.text);
              post.gia = double.parse(_PriceController.text);
              post.tieuDe = _TileController.text;
              post.thoiDiemDang = DateTime.now().toIso8601String().toString();
              post.thoiHan = DateTime.parse(post.thoiDiemDang)
                  .add(Duration(days: songay))
                  .toIso8601String()
                  .toString();
              post.diemBaiDang = 0;
              post.luotXem = 0;
              post.luotYeuThich = 0;
              if (selectedType.tenDanhMuc == "Nhà đất cho thuê")
                post.tagLoaiBaidang = "Cho thuê";
              else
                post.tagLoaiBaidang = "Bán";
              post.tagTimKiem = selectedTypeTypeType.tag;
              post.diaChi = _LocateController.text;
              post.userName = _userStore.userCurrent.userName;
              post.toaDoX = "10.87042965917961";
              post.toaDoY = "106.80213344451961";
              post.trangThai = "On";
              post.userId = _userStore.userCurrent.UserID;
              _newpost.post = post;
              _newpost.post.moTa = _keyEditor2.text;
              _newpost.post.featuredImage = _imageStore.imageListpost.first;
              lichsugiaodich lichsu = new lichsugiaodich();
              lichsu.ghiChu =
                  "${_userStore.userCurrent.UserID} ${selectedPack.tenGoi}";
              lichsu.soTien = songay * selectedPack.phi;
              if (_userStore.userCurrent.UserID != null)
                lichsu.userId = _userStore.userCurrent.UserID;
              else
                lichsu.userId = 2;
              lichsu.thoiDiem = _newpost.post.thoiDiemDang;
              _newpost.lichsugiaodichs = lichsu;
              Hoadonbaidang hoadon = new Hoadonbaidang();
              hoadon.thoiDiem = _newpost.post.thoiDiemDang;
              hoadon.giaGoi = selectedPack.phi;
              hoadon.soNgayMua = songay;
              hoadon.userId = _userStore.userCurrent.UserID;
              print(_userStore.userCurrent.wallet.toString());
              hoadon.ghiChu = lichsu.ghiChu;
              hoadon.tongTien = lichsu.soTien;
              hoadon.goiBaiDangId = selectedPack.id;
              _newpost.hoadonbaidang = hoadon;
              _newpost.properties = new List<Property>();
              if (_ThuocTinhController != null)
                for (int i = 0; i < _ThuocTinhController.length; i++)
                  if (_ThuocTinhController[i].text.isNotEmpty) {
                    Property value = new Property();
                    value.giaTri = _ThuocTinhController[i].text;
                    value.thuocTinhId =
                        _postStore.thuocTinhList.thuocTinhs[i + 2].id;
                    _newpost.properties.add(value);
                  }
              _newpost.images = new List<AppImage>();
              for (var item in _imageStore.imageListpost) {
                AppImage u = new AppImage();
                u.duongDan = item;
                _newpost.images.add(u);
              }
              if (songay * selectedPack.phi > _userStore.userCurrent.wallet) {
                var futureValue = showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Bạn không đủ số dư để thực hiện giao dịch?",
                          style: TextStyle(fontSize: 24, fontFamily: 'intel'),
                        ),
                        content: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedButtonWidget(
                              buttonText: "Nạp thêm tiền",
                              buttonColor: Colors.green,
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                            RoundedButtonWidget(
                              buttonColor: Colors.grey,
                              buttonText: "Hủy",
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            )
                          ],
                        ),
                      );
                    });
                futureValue.then((value) {
                  Route route = MaterialPageRoute(
                      builder: (context) => NapTienPage(
                            userID: _userStore.userCurrent.UserID,
                          ));
                  Navigator.push(context, route);
                });
              } else {
                var futureValue = showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "Đăng tin và thực hiện thanh toán?",
                          style: TextStyle(fontSize: 24, fontFamily: 'intel'),
                        ),
                        content: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            RoundedButtonWidget(
                              buttonText: "Đồng ý",
                              buttonColor: Colors.green,
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              },
                            ),
                            RoundedButtonWidget(
                              buttonColor: Colors.grey,
                              buttonText: "Hủy",
                              onPressed: () {
                                Navigator.of(context).pop(false);
                              },
                            )
                          ],
                        ),
                      );
                    });
                futureValue.then((value) {
                  _postStore.postPost(_newpost);
                  // true/false
                });
              }
            }
          }
        },
      );
    });
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
}
