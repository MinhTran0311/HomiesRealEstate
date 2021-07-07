import 'dart:async';
import 'dart:io';
import 'package:boilerplate/blocs/application_bloc.dart';
import 'package:boilerplate/constants/strings.dart';
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
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/ui/maps/maps.dart';
import 'package:boilerplate/widgets/dropdownsearch/dropdown_search.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:dio/dio.dart';
import 'package:boilerplate/models/town/town.dart';
import 'package:boilerplate/stores/image/image_store.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/town/town_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/postDetail/build_properties.dart';

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

class EditpostScreen extends StatefulWidget {
  final Post post;
  final PostStore postStore;
  final TownStore townStore;
  final UserStore userStore;
  EditpostScreen(
      {@required this.post, this.postStore, this.townStore, this.userStore});
  @override
  _EditpostScreenState createState() => _EditpostScreenState(
      post: post,
      postStore: postStore,
      townStore: townStore,
      userStore: userStore);
}

class _EditpostScreenState extends State<EditpostScreen> {
  final Post post;
  final PostStore postStore;
  final TownStore townStore;
  final UserStore userStore;
  ThemeStore _themeStore;
  _EditpostScreenState(
      {@required this.post, this.postStore, this.townStore, this.userStore});

  ImageStore _imageStore;
  UserStore _userStore;
  TextEditingController _TileController = TextEditingController();
  TextEditingController _PriceController = TextEditingController();
  TextEditingController _AcreageController = TextEditingController();
  var _ThuocTinhController = new List<TextEditingController>();
  TextEditingController _LocateController = TextEditingController();
  TextEditingController _keyEditor2 = new TextEditingController();
  final FormStore _store = new FormStore();
  Postcategory selectedType;
  Postcategory selectedTypeType;
  Postcategory selectedTypeTypeType;
  ApplicationBloc _applicationBloc;
  int songay;
  String pointx = '';
  String pointy = '';
  Town selectedTown = null;
  Commune selectedCommune = null;
  String selectedCity = null;
  String selectedhuongnha = null;
  String selectedhuongbancong = null;
  List<String> Huong = new List<String>();
  String result = "";
  bool loading = null;
  List<Commune> commune = [];
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _imageStore = Provider.of<ImageStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    _applicationBloc = Provider.of<ApplicationBloc>(context);
    if (!_imageStore.imageLoading) {
      _imageStore.getImagesForDetail(post.id.toString());
    }
    if (!postStore.propertiesLoading)
      postStore.getPostProperties(post.id.toString());
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
    loading = true;
    _TileController = TextEditingController(text: post.tieuDe.toString());
    _PriceController = TextEditingController(text: post.gia.toString());
    _AcreageController = TextEditingController(text: post.dienTich.toString());
    _ThuocTinhController =
        List<TextEditingController>(postStore.thuocTinhList.thuocTinhs.length);
    _LocateController = TextEditingController(text: post.diaChi.toString());
    _keyEditor2 = TextEditingController(text: post.moTa.toString());
    selectedTypeTypeType =
        postStore.postCategoryList.categorys[post.danhMucId - 2];
    selectedTypeType = postStore
        .postCategoryList.categorys[selectedTypeTypeType.danhMucCha - 2];
    if (selectedTypeType.danhMucCha != null)
      selectedType =
          postStore.postCategoryList.categorys[selectedTypeType.danhMucCha - 2];
    else {
      selectedType = selectedTypeType;
      selectedTypeType = selectedTypeTypeType;
    }
    ;
    pointx = post.toaDoX;
    pointy = post.toaDoY;
    selectedCommune = townStore.communeList.communes[post.xaId - 14468];
    selectedTown = townStore.townList.towns[selectedCommune.huyenId - 896];
    selectedCity = selectedTown.tinhTenTinh;
    for (var i = 0; i < townStore.communeList.communes.length; i++)
      if (townStore.communeList.communes[i].huyenId == selectedTown.id)
        commune.add(townStore.communeList.communes[i]);
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
          title: Text("Chỉnh sửa thông tin"),
          //actions: _buildActions(context),
          centerTitle: true,
        ),
        body: WillPopScope(
            onWillPop: () {
              {
                var future = showSimpleModalDialog(context,
                    "Bạn chưa lưu thông tin, bạn thật sự có muốn thoát?");
                future.then((value) {
                  if (value)
                    Navigator.of(context).pop();
                  else
                    return;
                });
              }
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
        if (postStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(postStore.errorStore.errorMessage, context);
        }
        if (postStore.successeditpost) {
          showSuccssfullMesssage("Chỉnh sửa thông tin thành công", context);
          //dispose();.
          postStore.successeditpost = false;
          postStore.getPostForCurs(false, "", 0);
          Future.delayed(Duration(milliseconds: 1000), () {
            Navigator.pop(context);
            Navigator.pop(context);
          });
        }
        return SizedBox.shrink();
      },
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return !postStore.propertiesLoading && !_imageStore.imageLoading
            ? _buildBody()
            //;
            : CustomProgressIndicatorWidget();
      },
    );
  }

  Widget _buildBody() {
    if (loading) {
      loading = false;
      _imageStore.imageListpost = new List<String>();
      if (postStore.propertyList != null)
        for (var item in postStore.propertyList.properties) {
          _ThuocTinhController[item.thuocTinhId - 3] =
              TextEditingController(text: item.giaTri);
          if (item.thuocTinhTenThuocTinh == "Hướng nhà")
            selectedhuongnha = item.giaTri;
          if (item.thuocTinhTenThuocTinh == "Hướng ban công")
            selectedhuongbancong = item.giaTri;
        }
      for (var i in _imageStore.imageList.images) {
        _imageStore.imageListpost.add(i.duongDan);
        _image.add(null);
      }
    }
    var _formKey;
    return Material(
        child: Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Stack(
        children: <Widget>[
          Container(),
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
                  : showErrorMessage(_store.errorStore.errorMessage, context);
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
            _buildAcreageField(),
            SizedBox(height: 24.0),
            _buildPriceField(),
            SizedBox(height: 24.0),
            _buildLocateField(),
            SizedBox(height: 24.0),
            _buildCityField(),
            SizedBox(height: 24.0),
            _buildTownField(),
            _buildCommuneField(),
            _buildCommuneField2(),
            _buildTypeField(),
            SizedBox(height: 24.0),
            _buildTypeTypeField(),
            _buildTypeTypeTypeField(),
            _buildListView(),
            SizedBox(height: 24.0),
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
                        icon: Icon(Icons.textsms_rounded,

                            color: _themeStore.darkMode
                                ? Colors.white
                                : Colors.amber),
                        labelStyle: TextStyle(
                          color: (_themeStore.darkMode)
                              ? Colors.white
                              : Colors.black,
                        ),
                        hintText: 'Tối đa 50 kí tự',
                        labelText: 'Tiêu đề',
                        suffixIcon: IconButton(
                          onPressed: () => _TileController.clear(),
                          icon: Icon(Icons.clear),
                        )),
                    onSaved: (value) {
                      // //  FormState.save();
                      //   print(value);
                      //   // code when the user saves the form.
                    },
                    controller: _TileController,
                    validator: (value) {
                      if (value == null || value.isEmpty || value.length > 50) {
                        return 'Vui lòng nhập lại tiêu đề';
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
    var _formKey;
    for (var i = 0; i < postStore.postCategoryList.categorys.length; i++)
      if (postStore.postCategoryList.categorys[i].danhMucCha ==
          null) if (postStore.postCategoryList.categorys[i] != null)
        type.add(postStore.postCategoryList.categorys[i]);
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
              value == null ? 'vui lòng chọn phương thức' : null,
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
      for (var i = 0; i < postStore.postCategoryList.categorys.length; i++)
        if (postStore.postCategoryList.categorys[i].danhMucCha ==
            selectedType
                .id) if (postStore.postCategoryList.categorys[i] != null)
          typetype.add(postStore.postCategoryList.categorys[i]);

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
                    value == null ? 'vui lòng chọn hình thức nhà đất' : null,
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
      for (var i = 0; i < postStore.postCategoryList.categorys.length; i++)
        if (postStore.postCategoryList.categorys[i].danhMucCha ==
            selectedTypeType
                .id) if (postStore.postCategoryList.categorys[i] != null)
          typetypetype.add(postStore.postCategoryList.categorys[i]);
      if (typetypetype.length != 0)
        return Observer(
          builder: (context) {
            return Padding(
              padding:
                  const EdgeInsets.only(left: 40.0, right: 10.0, bottom: 24.0),
              child: DropdownButtonFormField<Postcategory>(
                hint: Text("Chọn hình thức bổ sung"),
                value: selectedTypeTypeType,
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
                value == null ? 'vui lòng chọn tỉnh/thành' : null,
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
            selectedItem: selectedCity,
            showSearchBox: true,
            searchBoxDecoration: InputDecoration(
              //border: OutlineInputBorder(),
              labelText: "Tìm tỉnh/thành phố",
            ),
            popupTitle: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColorDark,
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
      for (var i = 0; i < townStore.townList.towns.length; i++)
        if (townStore.townList.towns[i].tinhTenTinh == selectedCity)
          town.add(townStore.townList.towns[i]);
      return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 0.0, bottom: 24.0),
        child: DropdownButtonFormField<Town>(
          hint: Text("Chọn quận/huyện"),
          value: selectedTown,
          autovalidateMode: AutovalidateMode.always,
          validator: (value) =>
              value == null ? 'vui lòng chọn quận huyện' : null,
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
              for (var i = 0; i < townStore.communeList.communes.length; i++)
                if (townStore.communeList.communes[i].huyenId ==
                    selectedTown.id)
                  commune.add(townStore.communeList.communes[i]);
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
        padding: const EdgeInsets.only(left: 40.0, right: 0.0, bottom: 24.0),
        child: DropdownButtonFormField<Commune>(
          hint: Text("Chọn xã/phường"),
          autovalidateMode: AutovalidateMode.always,
          validator: (value) =>
              value == null ? 'vui lòng chọn xã/phường' : null,
          decoration: InputDecoration(
              suffixIcon: IconButton(
            onPressed: () => setState(() {
              selectedCommune = null;
            }),
            icon: Icon(Icons.clear),
          )),
          value: selectedCommune,
          //icon:Icons.attach_file ,
            onChanged: (Commune Value) async {
              setState(() {
                selectedCommune = Value;
              });
              await _applicationBloc
                  .searchFromPlace(selectedCommune.tenXa + selectedTown.tenHuyen);
              Future.delayed(Duration(milliseconds: 0), () async {
                final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapsScreen(type: "Đăng bài"),
                    ));
                setState(() {
                  pointx = result.split(',')[0];
                  pointy = result.split(',')[1];
                });
                print(pointx);
                print(pointy);
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
                    type.tenXa.length <= 21
                        ? type.tenXa
                        : type.tenXa = type.tenXa.substring(0, 19) + "..",
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

  Widget _buildCommuneField2() {
    if (selectedCommune != null) {
      return Padding(
          padding: const EdgeInsets.only(left: 39.0, right: 0.0, bottom: 24.0),
          child: Text(
            pointx + ',' + pointy,
            style: TextStyle(),
          ));
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
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
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
                      labelText: 'Địa chỉ',
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
      return !postStore.loadingThuocTinh
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
                      itemCount: postStore.thuocTinhList.thuocTinhs.length - 2,
                      itemBuilder: (context, i) {
                        //_ThuocTinhController.add(new TextEditingController());
                        return _buildThuocTinh(
                            postStore.thuocTinhList.thuocTinhs[i + 2], i);
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
                          decoration: InputDecoration(
                            icon: Icon(
                                thuocTinh.id == 3
                                    ? Icons.house_outlined
                                    : thuocTinh.id == 4
                                        ? Icons.add_road_outlined
                                        : thuocTinh.id == 5
                                            ? Icons.sensor_door_outlined
                                            : thuocTinh.id == 6
                                                ? Icons.streetview_outlined
                                                : thuocTinh.id == 7
                                                    ? Icons.king_bed_outlined
                                                    : thuocTinh.id == 8
                                                        ? Icons.bathtub_outlined
                                                        : thuocTinh.id == 9
                                                            ? Icons
                                                                .policy_outlined
                                                            : thuocTinh.id == 10
                                                                ? Icons
                                                                    .weekend_outlined
                                                                : thuocTinh.id ==
                                                                        11
                                                                    ? Icons
                                                                        .apartment_outlined
                                                                    : thuocTinh.id ==
                                                                            12
                                                                        ? Icons
                                                                            .confirmation_number_outlined
                                                                        : Icons
                                                                            .category_outlined,
                                color: _themeStore.darkMode
                                    ? Colors.white
                                    : Colors.amber),
                            labelStyle: TextStyle(
                              color: (_themeStore.darkMode)
                                  ? Colors.white
                                  : Colors.black,
                            ),
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
                                    Icon(Icons.sensor_door_outlined),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text("Chọn hướng nhà"),
                                  ],
                                )
                              : Row(children: [
                                  Icon(
                                    Icons.streetview_outlined,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Chọn hướng ban công")
                                ]),
                          decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
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
                    decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber),
                        ),
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
                    autofocus: false,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập diện tích';
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
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      icon: Icon(Icons.money,
                          color: _themeStore.darkMode
                              ? Colors.white
                              : Colors.amber),
                      labelStyle: TextStyle(
                        color: (_themeStore.darkMode)
                            ? Colors.white
                            : Colors.black,
                      ),
                      labelText: 'Giá bán/thuê',
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
                        return 'Vui lòng nhập giá bán';
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
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.amber),
                      ),
                      icon: Icon(Icons.textsms_rounded,
                          color: _themeStore.darkMode
                              ? Colors.white
                              : Colors.amber),
                      labelStyle: TextStyle(
                        color: (_themeStore.darkMode)
                            ? Colors.white
                            : Colors.black,
                      ),
                      labelText: 'Mô tả',
                      hintText: "Mô tả thêm về bài đăng",
                      suffixIcon: IconButton(
                        onPressed: () => _keyEditor2.clear(),
                        icon: Icon(Icons.clear),
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
                                    image: _image[index] != null
                                        ? FileImage(_image[index])
                                        : NetworkImage(
                                            _imageStore.imageListpost[index]),
                                    fit: BoxFit.cover)),
                            child: SizedBox(
                              width: 80,
                              height: 80,
                              child: FlatButton(
                                padding:
                                    EdgeInsets.only(left: 70.0, bottom: 70.0),
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20),
                                //     side: BorderSide(color: Colors.white)),
                                // color: Color(0xFFF5F6F9),
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

  // Dangtin(BuildContext context) {
  //   AlertDialog alert = AlertDialog(
  //     title: Text("Thông báo"),
  //     content: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //         ]),
  //   );
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  var _newpost = new Newpost();
  Widget _buildUpButton() {
    return Observer(builder: (context) {
      return RoundedButtonWidget(
        buttonText: ('Chỉnh sửa'),
        buttonColor:
            !_imageStore.imageLoadingpost ? Colors.amber : Colors.grey,
        textColor: Colors.white,
        onPressed: () async {
          {
            if (_TileController.value.text.isEmpty ||
                _PriceController.value.text.isEmpty ||
                _AcreageController.value.text.isEmpty ||
                selectedCommune == null ||
                selectedTypeTypeType == null ||
                _image.length == 0 ||
                _keyEditor2.value.text.isEmpty)
              showAlertDialog(context);
            else {
              var post = new Post();
              post = this.post;
              post.tenXa = selectedCommune.tenXa;
              post.xaId = selectedCommune.id;
              post.danhMuc = selectedTypeTypeType.tenDanhMuc;
              post.danhMucId = selectedTypeTypeType.id;
              post.dienTich = double.parse(_AcreageController.text);
              post.gia = double.parse(_PriceController.text);
              post.tieuDe = _TileController.text;
              if (selectedType.tenDanhMuc == "Nhà đất cho thuê")
                post.tagLoaiBaidang = "Cho thuê";
              else
                post.tagLoaiBaidang = "Bán";
              post.tagTimKiem = selectedTypeTypeType.tag;
              post.diaChi = _LocateController.text;
              post.toaDoX = pointx;
              post.toaDoY = pointy;
              post.trangThai = "On";
              post.moTa = _keyEditor2.text;
              post.featuredImage = _imageStore.imageListpost.first;
              _newpost.post = post;
              _newpost.properties = new List<Property>();
              var j = 0;
              if (_ThuocTinhController != null)
                for (int i = 0; i < _ThuocTinhController.length; i++)
                  if (_ThuocTinhController[i] !=
                      null) if (_ThuocTinhController[i].text.isNotEmpty) {
                    //j++;
                    Property value = new Property();
                    if (j < postStore.propertyList.properties.length)
                      value.id = postStore.propertyList.properties[j].id;
                    value.giaTri = _ThuocTinhController[i].text;
                    value.thuocTinhId =
                        postStore.thuocTinhList.thuocTinhs[i + 2].id;
                    value.baiDangId = this.post.id;
                    j++;
                    value.thuocTinhTenThuocTinh =
                        postStore.thuocTinhList.thuocTinhs[i + 2].tenThuocTinh;
                    _newpost.properties.add(value);
                  }
              _newpost.images = new List<AppImage>();
              j = 0;
              var future = showSimpleModalDialog(context,
                  "Chỉnh sửa thông tin bài đăng?");
              future.then((value) {
                if (value) {
                  for (var item in _imageStore.imageListpost) {
                    AppImage u = new AppImage();
                    if (j < _imageStore.imageList.images.length)
                      u.id = _imageStore.imageList.images[j].id;
                    j++;
                    u.baiDangId = this.post.id.toString();
                    u.duongDan = item;
                    _newpost.images.add(u);
                  }
                  postStore.editpost(_newpost);
                }
              });
            }
          }
        },
      );
    });
  }
//endregion

  Widget navigate(BuildContext context) {
    Future.delayed(Duration(milliseconds: 0), () {
      Navigator.of(context).pop();
    });

    return Container();
  }
}
