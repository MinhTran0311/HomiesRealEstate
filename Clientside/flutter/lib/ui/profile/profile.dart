import 'dart:convert';
import 'dart:io';

import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/data/sharedpref/constants/preferences.dart';
import 'package:boilerplate/di/permissions/permission.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/kiemduyet/kiemduyet.dart';
import 'package:boilerplate/ui/profile/favopost/favopost.dart';
import 'package:boilerplate/ui/profile/help/help.dart';
import 'package:boilerplate/ui/profile/report/report.dart';
import 'package:boilerplate/ui/profile/setting/setting.dart';
import 'package:boilerplate/ui/profile/wallet/wallet.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:marquee/marquee.dart';
import 'package:provider/provider.dart';

import 'account/account.dart';
import 'mypost/mypost.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();

  // @override
  // _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String role=" Khách";
  String pathAvatar = "assets/images/img_login.jpg";
  File image;
  final picker = ImagePicker();
  int selected = 0;
  UserStore _userstore;
  PostStore _postStore;
  int sobaidang;
  ThemeStore _themeStore;
  final oCcy = new NumberFormat("#,##0", "en_US");
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        final bytes = File(pickedFile.path).readAsBytesSync();
        _userstore.userCurrent.picture = (base64Encode(bytes).toString());
      } else {
        // print('No image selected.');
      }
    });
  }

  @override
  Future<void> didChangeDependencies()  {
    super.didChangeDependencies();
    _userstore = Provider.of<UserStore>(context);
    _postStore = Provider.of<PostStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    if(Preferences.userRoleRank >= 1){
      if (!_userstore.loadingCurrentUser) {
        _userstore.getCurrentUser();
      }
      // if (!_userstore.loadingCurrentUserWallet) {
      //   _userstore.getCurrentWalletUser();
      // }
      // if (!_userstore.loadingCurrentUserPicture) {
      //   _userstore.getCurrentPictureUser();
      // }
     if (!_postStore.loadingPostForCur) _postStore.getPostForCurs(false,"",0);
      if (!_postStore.loadingsobaidang) _postStore.getsobaidang();
    }
    if (!_postStore.loadingsobaidang) _postStore.getsobaidang();

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
    return WillPopScope(
      onWillPop: (){
        return;
      },
      child: Scaffold(
          appBar: _buildAppBar(),
          body: Observer(builder: (context) {
            return
              !_userstore.loadingCurrentUser &&
                    !_userstore.loadingCurrentUserWallet &&
                    !_userstore.loadingCurrentUserPicture
                ? _buildBody()
                : CustomProgressIndicatorWidget();
          })),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      // leading: _selectedIndex != 0
      //     ? IconButton(
      //         icon: Icon(Icons.arrow_back_ios),
      //         onPressed: () {
      //           setState(() {
      //             _selectedIndex = 0;
      //           });
      //         })
      //     : Container(),
      title: Text("Cá nhân"),
    );
  }

  int _selectedIndex = 0;
  Widget _buildBody() {
    Size size =  MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomRight,
              colors: [Colors.orange, Colors.amber])),
      width: size.width,
      height: size.height,
      child: RefreshIndicator(
        onRefresh: () async {
          _userstore.getCurrentUser();
          _userstore.getCurrentWalletUser();
          _userstore.getCurrentPictureUser();
          _postStore.getPostForCurs(false,"",0);
          _postStore.getsobaidang();
          return true;
        },
        child:!_userstore.loadingCurrentUser ||
            !_userstore.loadingCurrentUserWallet ||
            !_userstore.loadingCurrentUserPicture?
        ListView(
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
            ])
        : CustomProgressIndicatorWidget(),
      ),
    );
  }

  Widget MenuItem() {
    return Wrap(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            border: Border.all(color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(18, 22, 28, 1), width: 10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
        ),
        Container(
          color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(18, 22, 28, 1),
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.only(
          //       topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          //   border: Border.all(color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(18, 22, 28, 1), width: 10.0),
          //   boxShadow: [
          //     BoxShadow(
          //       color: Colors.black26,
          //       spreadRadius: 5,
          //       blurRadius: 7,
          //       offset: Offset(0, 3), // changes position of shadow
          //     ),
          //   ],
          // ),
          child: Wrap(
            children: <Widget>[
              CardItem(
                text: "Tài khoản của tôi",
                icon: Icons.account_circle_outlined,
                // colorbackgroud: Colors.grey[200],
                // colortext: Colors.black,
                coloricon: Colors.amber,
                isFunction: false,
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
                              UserID:  _userstore.userCurrent.UserID,
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
                // colorbackgroud: Colors.grey[200],
                // colortext: Colors.black,
                coloricon: Colors.amber,
                isFunction: false,
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
                text: "Bài đăng yêu thích",
                icon: Icons.article_outlined,
                // colorbackgroud: Colors.grey[200],
                // colortext: Colors.black,
                coloricon: Colors.amber,
                isFunction: false,
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
              CardItem(
                text: "Báo cáo thống kê",
                icon: Icons.article_outlined,
                // colorbackgroud: Colors.grey[200],
                // colortext: Colors.black,
                coloricon: Colors.amber,
                isFunction: false,
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
                  // colorbackgroud: Colors.grey[200],
                  // colortext: Colors.black,
                  coloricon: Colors.amber,
                  isFunction: false,
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
                  // colorbackgroud: Colors.grey[200],
                  // colortext: Colors.black,
                  coloricon: Colors.amber,
                  isFunction: false,
                  press: () {
                    setState(() {
                      Route route =
                          MaterialPageRoute(builder: (context) => HelpScreen());
                      Navigator.push(context, route);
                    });
                  }),

            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUserInformation() {
    Size size =  MediaQuery.of(context).size;
    return Container(
      height: size.height*0.29,
      width:  size.width,
      child: Wrap(
        children: [
          Observer(builder: (context) {
            return Container(
                height: size.height,
                width:  size.width,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                        colors: [Colors.orange, Colors.amber])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: size.height*0.01,left: size.width*0.04),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Column(
                                children: [
                                  SizedBox(
                                    width: size.width*0.2,
                                    height:  size.width*0.2,
                                    child: Stack(
                                        fit: StackFit.expand,
                                        overflow: Overflow.visible,
                                        children: [
                                          Observer(builder: (context) {
                                            // if(_userstore.userCurrent != null){
                                              return !_userstore.loadingCurrentUserPicture && _userstore.userCurrent.picture != null
                                                  ? CircleAvatar(
                                                  radius: (52),
                                                  backgroundColor: Colors.white,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                    child: Image.memory(Base64Decoder()
                                                        .convert(_userstore
                                                        .userCurrent.picture)),
                                                  )): CircleAvatar(
                                                  radius: (52),
                                                  backgroundColor: Colors.white,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                    BorderRadius.circular(50),
                                                    child: Image.network("https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg"),
                                                  ));
                                            // }
                                            // else{
                                            //   return CircleAvatar(
                                            //       radius: (52),
                                            //       backgroundColor: Colors.white,
                                            //       child: ClipRRect(
                                            //         borderRadius:
                                            //         BorderRadius.circular(50),
                                            //         child: Image.network("https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg"),
                                            //       ));
                                            // }

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
                                            ? Container(
                                              width: size.width*0.65,
                                              child: "${_userstore.userCurrent.surname} ${_userstore.userCurrent.name}".length < 16 ? SelectableText(
                                              _userstore.userCurrent.surname + " " + _userstore.userCurrent.name ,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                        fontSize: 30.0,
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                            ):
                                              SelectableText(
                                                _userstore.userCurrent.surname + " " + _userstore.userCurrent.name ,
                                                maxLines: 2,
                                                textAlign: TextAlign.start,
                                                style: TextStyle(
                                                  fontSize: 30.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            //   child: Text(
                                            //       _userstore.userCurrent.surname +
                                            //       " " +
                                            //       _userstore.userCurrent.name,
                                            //       style: TextStyle(
                                            //         fontSize: 30.0,
                                            //         fontWeight: FontWeight.bold,
                                            //         color: Colors.white,
                                            //       ),
                                            //       overflow: TextOverflow.clip,
                                            //   ),
                                            )
                                            : Text("Người dùng ",
                                            style: TextStyle(
                                                fontSize: 30.0,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                ));

                                    }),
                                  Observer(builder: (context) {
                                    if(_userstore.userCurrent != null){
                                      if(_userstore.userCurrent.listRole != null){
                                        role=" ${_userstore.userCurrent.listRole[0].roleDisplayName}";
                                        // print("debug ${_userstore.userCurrent.listRole.length}");
                                        for(int i=1,ii=_userstore.userCurrent.listRole.length;i<ii;i++){
                                          role += ", ${_userstore.userCurrent.listRole[i].roleDisplayName}";
                                        }
                                      }
                                    }


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
                                          Container(
                                            width: size.width*0.5,
                                            height: 20,
                                            child:
                                            SelectableText(
                                              role ,
                                              maxLines: 1,
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                              fontSize: 17.0,
                                              // fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          // Text(role,
                                          //     style: TextStyle(
                                          //         fontSize: 17.0,
                                          //         // fontWeight: FontWeight.bold,
                                          //         color: Colors.white,
                                          //         )),
                                        ],
                                      ) : Container();
                                    }
                                  ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: size.height*0.15,left: size.width*0.07),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                top: 25,
                                // left: 20,
                              ),
                              child: MaterialButton(
                                child: Column(
                                  children: [
                                    Observer(builder: (context) {
                                      return !_userstore.loadingCurrentUserWallet
                                          ? Text(
                                          "${oCcy.format(_userstore.userCurrent.wallet)} Đ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                            )
                                          : Text(
                                              "0",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  ),
                                            );
                                    }),
                                    Text(
                                      "Số dư",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                          ),
                                    )
                                  ],
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => WalletPage(userID: _userstore.userCurrent.UserID,)),
                                  );
                                },
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
                                              ),
                                        ),
                                        Text(
                                          "Bài đã đăng",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.white,
                                              ),
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
                        ),
                      )
                    ],
                  ),
                )
            );
          }),
        ],
      ),
    );
  }
}

