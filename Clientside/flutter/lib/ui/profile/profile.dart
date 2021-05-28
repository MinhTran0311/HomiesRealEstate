import 'dart:convert';
import 'dart:io';

import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/kiemduyet/kiemduyet.dart';
import 'package:boilerplate/ui/profile/favopost/favopost.dart';
import 'package:boilerplate/ui/profile/help/help.dart';
import 'package:boilerplate/ui/profile/report/report.dart';
import 'package:boilerplate/ui/profile/setting/setting.dart';
import 'package:boilerplate/ui/profile/wallet/wallet.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'account/account.dart';
import 'mypost/mypost.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key key,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  // @override
  // _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  _ProfileScreenState({
    Key key,
  }) : super();
  String role=" Admin";
  String pathAvatar = "assets/images/img_login.jpg";
  File image;
  final picker = ImagePicker();
  int selected = 0;
  UserStore _userstore;
  PostStore _postStore;
  int sobaidang;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        _userstore.userCurrent.picture = (base64Encode(bytes).toString());
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Future<void> didChangeDependencies()  {
    super.didChangeDependencies();

    _userstore = Provider.of<UserStore>(context);
    _postStore = Provider.of<PostStore>(context);
    if (!_userstore.loading) {
      _userstore.getCurrentUser();
    }
    if (!_userstore.loadingCurrentUserWallet) {
      _userstore.getCurrentWalletUser();
    }
    if (!_userstore.loadingCurrentUserPicture) {
      _userstore.getCurrentPictureUser();
    }
    if (!_postStore.loadingPostForCur) _postStore.getPostForCurs(false);
    if (!_postStore.loadingsobaidang) _postStore.getsobaidang();
    //sobaidang = await _postStore.getsobaidang();
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

  String DatetimeToString(String datetime) {
    return "${datetime.substring(11, 13)}:${datetime.substring(14, 16)} - ${datetime.substring(8, 10)}/${datetime.substring(5, 7)}/${datetime.substring(0, 4)}";
  }
  // Future getImage() async{
  //   var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  //   setState(() {
  //     _image = _image;
  //     print('image: $_image');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Observer(builder: (context) {
          return !_userstore.loadingCurrentUser &&
                  !_userstore.loadingCurrentUserWallet &&
                  !_userstore.loadingCurrentUserPicture
              ? _buildBody()
              : CustomProgressIndicatorWidget();
        }));
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: _selectedIndex != 0
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios),
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              })
          : Container(),
      title: Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Text("Cá nhân"),
      ),
    );
  }

  bool _first = true;
  int _selectedIndex = 0;
  Widget _buildBody() {
    return Container(
      color: Colors.orange,
      width: double.infinity,
      height: double.infinity,
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            _buildUserInformation(),
            MenuItem(),
            // IndexedStack(
            //   children: [
            //     MenuItem(),
            //     _userstore.user!=null?AccountPage(Phone: _userstore.user.phoneNumber,Email: _userstore.user.emailAddress,Address: "Address",SurName: _userstore.user.surname,Name: _userstore.user.name,creationTime: _userstore.user.creationTime,):Container(),
            //     WalletPage(),
            //     ReportPage(title: "Doanh Thu",)
            //   ],
            //   index: _selectedIndex,
            // ),
          ]),
    );
  }

  Widget MenuItem() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        border: Border.all(color: Colors.white, width: 10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            color: Colors.white,
          ),
          CardItem(
            text: "Tài Khoản của tôi",
            icon: Icons.account_circle_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: () {
              setState(() {
                // _first=!_first;
                // selected = 0;
                // _selectedIndex =1;
                Route route = MaterialPageRoute(
                    builder: (context) => AccountPage(
                          UserName: _userstore.userCurrent.userName,
                          Phone: _userstore.userCurrent.phoneNumber,
                          Email: _userstore.userCurrent.emailAddress,
                          Address: "Address",
                          SurName: _userstore.userCurrent.surname,
                          Name: _userstore.userCurrent.name,
                          creationTime: DatetimeToString(
                              _userstore.userCurrent.creationTime),
                        ));
                Navigator.push(context, route);
              });
            },
          ),
          CardItem(
            text: "Ví tiền của tôi",
            icon: Icons.account_balance_wallet_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: () {
              setState(() {
                // _first=!_first;
                // selected = 1;
                // _selectedIndex =2;
                Route route = MaterialPageRoute(
                    builder: (context) => WalletPage(
                          userID: _userstore.userCurrent.UserID,
                        ));
                Navigator.push(context, route);
              });
            },
          ),
          CardItem(
            text: "Báo cáo thống kê",
            icon: Icons.article_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: () {
              setState(() {
                // _first=!_first;
                // selected = 1;
                // _selectedIndex =3;
                Route route =
                    MaterialPageRoute(builder: (context) => ReportPage());
                Navigator.push(context, route);
              });
            },
          ),
          CardItem(
              text: "Cài đặt",
              icon: Icons.settings_outlined,
              colorbackgroud: Colors.grey[200],
              colortext: Colors.black,
              coloricon: Colors.orange,
              press: () {
                setState(() {
                  Route route = MaterialPageRoute(
                      builder: (context) => SettingPage());
                  Navigator.push(context, route);
                });
              }),
          CardItem(
              text: "Trợ giúp",
              icon: Icons.info_outline,
              colorbackgroud: Colors.grey[200],
              colortext: Colors.black,
              coloricon: Colors.orange,
              press: () {
                setState(() {
                  Route route =
                      MaterialPageRoute(builder: (context) => HelpPage());
                  Navigator.push(context, route);
                });
              }),
          CardItem(
            text: "Danh sách bài ghim",
            icon: Icons.article_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FavoPostScreen(
                          userid: _userstore.userCurrent.UserID,
                        )),
              );
            },
          ),
          Container(
            height: 20,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget _buildUserInformation() {
    return Observer(builder: (context) {
      return Container(
          height: 189,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.yellow, Colors.orange])),
          child: Container(
            padding: const EdgeInsets.only(top: 30, left: 30),
            child: Column(
              children: [
                Row(
                  children: <Widget>[
                    Column(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 80,
                          child: Stack(
                              fit: StackFit.expand,
                              overflow: Overflow.visible,
                              children: [
                                Observer(builder: (context) {
                                  return _userstore.userCurrent.picture != null
                                      ? CircleAvatar(
                                          radius: (52),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.memory(Base64Decoder()
                                                .convert(_userstore
                                                    .userCurrent.picture)),
                                          ))
                                      : CircleAvatar(
                                          radius: (52),
                                          backgroundColor: Colors.white,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Image.network("https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg"),
                                          ));
                                }),
                                // CircularProfileAvatar(
                                //   _pathAvatar,
                                //   borderWidth: 4.0,
                                // ),
                                Positioned(
                                  right: -6,
                                  bottom: 0,
                                  child: SizedBox(
                                    width: 25,
                                    height: 25,
                                    child: FlatButton(
                                      padding: EdgeInsets.zero,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          side:
                                              BorderSide(color: Colors.white)),
                                      color: Color(0xFFF5F6F9),
                                      onPressed: getImage,
                                      child: Icon(
                                        Icons.add_a_photo,
                                        color: Colors.grey[700],
                                        size: 12.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Observer(builder: (context) {
                            return
                              _userstore.userCurrent != null
                                  ? Text(
                                  _userstore.userCurrent.surname +
                                      " " +
                                      _userstore.userCurrent.name,
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: FontFamily.roboto))
                                  : Text("Người dùng ",
                                  style: TextStyle(
                                      fontSize: 30.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontFamily: FontFamily.roboto));

                          }),
                        Observer(builder: (context) {
                          return
                            _userstore.userCurrent != null ? Row(
                              children: [
                                Icon(
                                  Icons.people,
                                  color: Colors.white,
                                  size: 24.0,
                                  semanticLabel:
                                  'Text to announce in accessibility modes',
                                ),
                                Text(_userstore.userCurrent.listRole[0].roleName,
                                    style: TextStyle(
                                        fontSize: 17.0,
                                        // fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontFamily: FontFamily.roboto)),
                              ],
                            ) : Container();
                          }
                        ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                        top: 25,
                        left: 40,
                      ),
                      child: Column(
                        children: [
                          Observer(builder: (context) {
                            return _userstore.userCurrent != null
                                ? Text(
                                priceFormat(_userstore.userCurrent.wallet),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontFamily.roboto),
                                  )
                                : Text(
                                    "0",
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: FontFamily.roboto),
                                  );
                          }),
                          Text(
                            "Số dư",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: FontFamily.roboto),
                          )
                        ],
                      ),
                    ),
                    //SizedBox(width: 70,),
                    !_postStore.loadingsobaidang
                        ? MaterialButton(
                            padding: const EdgeInsets.only(top: 25, right: 50),
                            child: Column(
                              children: [
                                Text(
                                  _postStore.sobaidang.toString(),
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: FontFamily.roboto),
                                ),
                                Text(
                                  "Bài đã đăng",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: FontFamily.roboto),
                                )
                              ],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyPostScreen(
                                          userStore: _userstore,
                                          postStore: _postStore,
                                        )),
                              );
                            },
                          )
                        : Container(
                            height: 0,
                          ),
                  ],
                )
              ],
            ),
          ));
    });
  }
}

class CardItem extends StatelessWidget {
  const CardItem({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press,
    @required this.colorbackgroud,
    @required this.colortext,
    @required this.coloricon,
  }) : super(key: key);

  final String text;
  final IconData icon;
  final VoidCallback press;
  final Color colorbackgroud;
  final Color colortext;
  final Color coloricon;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: press,
            color: colorbackgroud,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  icon,
                  size: 30,
                  color: coloricon,
                ),
                SizedBox(
                  width: 40,
                ),
                Expanded(
                  child: Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: FontFamily.roboto,
                          color: colortext)),
                ),
                Icon(
                  Icons.arrow_forward_ios,
                  color: colortext,
                )
              ],
            )),
      ),
    );
  }
}
