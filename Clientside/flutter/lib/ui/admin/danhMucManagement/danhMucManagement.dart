import 'dart:developer';
import 'dart:math';

import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/routes.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
// import 'package:boilerplate/stores/language/language_store.dart';
// import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:material_dialog/material_dialog.dart';
import 'package:provider/provider.dart';
import 'package:boilerplate/ui/home/filter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:boilerplate/stores/admin/danhMucManagement/danhMucManagement_store.dart';
import 'package:boilerplate/models/danhMuc/danhMuc.dart';
import 'package:boilerplate/models/danhMuc/danhMuc_list.dart';

import '../management.dart';
import 'createOrEditDanhMuc.dart';

class DanhMucManagementScreen extends StatefulWidget {
  @override
  _DanhMucManagementScreenState createState() => _DanhMucManagementScreenState();
}

class _DanhMucManagementScreenState extends State<DanhMucManagementScreen> {
  DanhMucManagementStore _danhMucManagementStore;
  ThemeStore _themeStore;

  var _selectedValue;
  TextEditingController _searchController = new TextEditingController();
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  final ScrollController _scrollController =
  ScrollController(keepScrollOffset: true);
  bool isRefreshing = false;
  // var _permissions;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // initializing stores
    _danhMucManagementStore = Provider.of<DanhMucManagementStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    if (!_danhMucManagementStore.loading) {
      _danhMucManagementStore.isIntialLoading = true;
      _danhMucManagementStore.setStringFilter('');
      _danhMucManagementStore.getDanhMucs(false);
    }
  }

  _clickButtonApDung() {

  }

  _isActiveDanhMuc(DanhMuc danhMuc, int position) async {
    if(danhMuc.trangThai == "On")
      {
        danhMuc.trangThai = "Off";
        _danhMucManagementStore.danhMucList.danhMucs[position].trangThai = "Off";

      }
    else {
      danhMuc.trangThai = "On";
      _danhMucManagementStore.danhMucList.danhMucs[position].trangThai = "On";

    }
      await _danhMucManagementStore.IsActiveDanhMuc(danhMuc);
      Navigator.of(context).pop();
      setState(() {});
    showSuccssfullMesssage(_danhMucManagementStore.danhMucList.danhMucs[position].trangThai == "Off" ? "Ngừng kích hoạt thành công": "Kích hoạt thành công",context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      primary: true,
      appBar: AppBar(
        leading: IconButton(
          icon : Icon(Icons.arrow_back_ios_outlined,),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        title: Text("Quản lý danh mục",),
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 10),
            icon: Icon(
              Icons.add,
              // size: 28,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateOrEditDanhMucScreen()),
              );
            },
          ),
        ],
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(),
    );
  }

  // body methods:--------------------------------------------------------------
  Widget _buildBody() {
    return Stack(
      children: <Widget>[
        _handleErrorMessage(),
        _buildMainContent(),
      ],
    );
  }

  Widget _buildMainContent() {
    return Observer(
      builder: (context) {
        return _danhMucManagementStore.loading
            ? CustomProgressIndicatorWidget()
            : _buildDanhMucsList();
      },
    );
  }

  Widget _buildDanhMucsList()
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(padding: EdgeInsets.only(top: 20,left: 24,right: 24, bottom: 16),
          child: TextField(
            style: TextStyle(
              fontSize: 28,
              height: 1,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            controller: _searchController,
            onChanged: (value) => _danhMucManagementStore.setStringFilter(_searchController.text),
            onSubmitted: (value) {
              _danhMucManagementStore.isIntialLoading = true;
              _danhMucManagementStore.getDanhMucs(false);
            },
            decoration: InputDecoration(
                hintText: "Tìm kiếm",
                hintStyle: TextStyle(
                  fontSize: 25,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border:  UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                ),
                suffixIcon: Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 28,),
                    onPressed: () {
                      _danhMucManagementStore.isIntialLoading = true;
                      _danhMucManagementStore.getDanhMucs(false);
                    },
                  ),
                )
            ),
          ),
        ),
        Expanded(child: _buildListView()),
      ],
    );
  }

  Widget _buildListView() {
    return _danhMucManagementStore.danhMucList != null
        ? SmartRefresher(
        //key: _refresherKey,
        controller: _refreshController,
        enablePullUp: true,
        enablePullDown: true,
        header: WaterDropHeader(
          refresh: SizedBox(
            width: 25.0,
            height: 25.0,
            child: Icon(
              Icons.flight_takeoff_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
          idleIcon: SizedBox(
            width: 25.0,
            height: 25.0,
            child: Icon(
              Icons.flight_takeoff_outlined,
              color: Colors.amber,
              size: 20,
            ),
          ),
          waterDropColor: Colors.amber,
        ),
        physics: BouncingScrollPhysics(),
        footer: ClassicFooter(
          loadStyle: LoadStyle.ShowWhenLoading,
          completeDuration: Duration(milliseconds: 500),
        ),
        onLoading: () async {
          print("loading");

          _danhMucManagementStore.getDanhMucs(true);
          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) {
            setState(() {});
          }
          _scrollController.jumpTo(
            _scrollController.position.maxScrollExtent,
          );
          _refreshController.loadComplete();
        },
        onRefresh: () async {
          print("refresh");
          _danhMucManagementStore.getDanhMucs(false);

          await Future.delayed(Duration(milliseconds: 2000));
          if (mounted) setState(() {});
          isRefreshing = true;
          _refreshController.refreshCompleted();
        },
        //scrollController: _scrollController,
        primary: false,
        child:  ListView.builder(
              //key: _contentKey,
              controller: _scrollController,
              itemCount: _danhMucManagementStore.danhMucList.danhMucs.length,
              // separatorBuilder: (context, position) {
              //   return Divider();
              // },
              itemBuilder: (context, position) {
                  return _buildListItem(
                      _danhMucManagementStore.danhMucList.danhMucs[position],
                      position);
                  //_buildListItem(position);
                },
              ),

      )
        : Center(
      child: Text(
        // AppLocalizations.of(context).translate('home_tv_no_post_found'),
        "Không tìm thấy danh mục nào!",
      ),
    );
  }

  Widget _buildListItem(DanhMuc danhMuc, int position) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Container(
        decoration: !_themeStore.darkMode ? new BoxDecoration(
          boxShadow: [
            // color: Colors.white, //background color of box
            BoxShadow(
              color: Color.fromRGBO(198, 199, 202, 1),
              blurRadius: 10, // soften the shadow
              spreadRadius: 0.01, //extend the shadow
              offset: Offset(
                8.0, // Move to right 10  horizontally
                12.0, // Move to bottom 10 Vertically
              ),
            )
          ],
        ) : new BoxDecoration(),
        child: Card(
          margin: EdgeInsets.only(top: 8, right: 10, left: 10),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          child: Container(
            padding: EdgeInsets.all(20),
            // height: 130,
            // color: Color.fromRGBO(242, 242, 242, 1),
            // color: Colors.white,
            // AppColors.lightDarkThemeColor
            color: _themeStore.darkMode ? AppColors.darkBlueForCardDarkTheme : AppColors.greyForCardLightTheme,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        '${danhMuc.tenDanhMuc}',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          // color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        _showBottomSheetPopMenu(danhMuc, position);
                      },
                      child: Icon(
                        Icons.menu_outlined,
                        size: 25,
                        color: _themeStore.darkMode ? Colors.white : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6,),
                Container(
                  // padding: EdgeInsets.only(top: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Icon(
                              Icons.note,
                              color: Colors.amber,
                              size: 28,
                            ),
                            SizedBox(width: 10,),
                            Text(
                              "Nhãn:",
                              style: TextStyle(
                                // color: Colors.amber,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5,),
                          ],
                        ),
                      ),
                      Flexible(
                        child:
                        Text(
                          // alignment: Alignment.centerRight,
                          "${danhMuc.tag}",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications_active,
                          color: Colors.amber,
                          size: 28,
                        ),
                        SizedBox(width: 10.0,),
                        Text(
                          "Trạng thái:",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 12,),
                    Row(
                      children: [
                        Text(
                          _danhMucManagementStore.danhMucList.danhMucs[position].trangThai=="On" ? "On" : "Off",
                          style: TextStyle(fontSize: 20,),
                        ),
                        SizedBox(width: 10.0,),
                        _danhMucManagementStore.danhMucList.danhMucs[position].trangThai=="On" ? Icon(
                          Icons.check_circle_outline,
                          color: Colors.green,
                          size: 24,
                        ) : Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                          size: 24,
                        ),
                      ],
                    ),

                    // danhMuc.trangThai == "On" ? Row(
                    //   children: [
                    //     Text(
                    //       "On",
                    //       style: TextStyle(
                    //         // fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //       ),
                    //     ),
                    //     SizedBox(width: 10.0,),
                    //     Icon(
                    //       Icons.check_circle,
                    //       color: Colors.green,
                    //       size: 24,
                    //     ),
                    //   ],
                    // ) :  Row(
                    //   children: [
                    //     Text(
                    //       "Off",
                    //       style: TextStyle(
                    //         // fontWeight: FontWeight.bold,
                    //         fontSize: 20,
                    //       ),
                    //     ),
                    //     SizedBox(width: 10.0,),
                    //     Icon(
                    //       Icons.check_circle,
                    //       color: Colors.red,
                    //       size: 24,
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  Widget _handleErrorMessage() {
    return Observer(
      builder: (context) {
        if (_danhMucManagementStore.errorStore.errorMessage.isNotEmpty) {
          return showErrorMessage(_danhMucManagementStore.errorStore.errorMessage,context);
        }

        return SizedBox.shrink();
      },
    );
  }


  void _showBottomSheet() async {
    // await _loadRoleList();
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              buildFilterAdvance(),
            ],
          );
        }
    );
  }

  void _showBottomSheetPopMenu(DanhMuc danhMuc, int position) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )
        ),
        builder: (BuildContext context){
          return Wrap(
            children: [
              buildPopMenuBottom(danhMuc, position),
            ],
          );
        }
    );
  }

  Widget buildPopMenuBottom(DanhMuc danhMuc, int position) {
    return Container(
        padding: EdgeInsets.only(right: 24,left: 24,top: 32,bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Icon(
                  Icons.edit_sharp,
                  color: Colors.grey,
                  size: 28,
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  child: Text(
                    "Chỉnh sửa",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CreateOrEditDanhMucScreen(danhMuc: danhMuc,)),
                    );
                  },
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              children: [
                danhMuc.trangThai == "On" ? Icon(
                  Icons.cancel,
                  color: Colors.grey,
                  size: 28,
                ) : Icon(
                  Icons.check_circle,
                  color: Colors.grey,
                  size: 28,
                ),
                SizedBox(width: 20,),
                GestureDetector(
                  child: Text(
                    danhMuc.trangThai == "On" ? "Ngừng kích hoạt" : "Kích hoạt",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () {
                    _isActiveDanhMuc(danhMuc, position);
                  },
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget buildFilterAdvance() {
    return Container(
        padding: EdgeInsets.only(right: 24,left: 24,top: 32,bottom: 24),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Bộ lọc vai trò",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4,),
              ],
            ),
            SizedBox(
              height: 32,
            ),
            Row(
              children: [
                Text(
                  "Quyền",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 4,),
              ],
            ),
            _buildListDropdownItem(),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildSignUpButton(),
                SizedBox(
                  height: 20,
                  // width: double.infinity,
                ),
              ],
            ),
          ],
        )
    );
  }

  Widget _buildSignUpButton() {
    return RoundedButtonWidget(
      buttonText: ('Áp dụng'),
      buttonColor: Colors.orangeAccent,
      textColor: Colors.white,
      onPressed: () {
        _clickButtonApDung();
      },
    );
  }

  Widget _buildListDropdownItem() {
    return DropdownButtonFormField(
      value: _selectedValue,
      // items: _permissions,
      hint: Text("Chọn quyền"),
      // onChanged: (value) {
      //   setState(() {
      //     _selectedValue = value;
      //   });
      // },
    );
  }


  _showDialog<T>({BuildContext context, Widget child}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
    });
  }

  // dispose:-------------------------------------------------------------------
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _searchController.dispose();
    _scrollController.dispose();
    _refreshController.dispose();
    super.dispose();
  }

}