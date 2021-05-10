

import 'dart:io';

import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/data/repository.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/post/post_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/profile/report/report.dart';
import 'package:boilerplate/ui/profile/wallet/wallet.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'account/account.dart';

class ProfileScreen extends StatefulWidget{
  ProfileScreen({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.Address,
    @required this.SurName,
    @required this.Name,
  }) : super(key: key);

  final String Phone,Email,Address,SurName,Name;

  @override
  _ProfileScreenState createState() => _ProfileScreenState(Phone: Phone,Email: Email,Address: Address,SurName: SurName,Name: Name);


  // @override
  // _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  _ProfileScreenState({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.Address,
    @required this.SurName,
    @required this.Name,
  }) : super();


  String pathAvatar= "assets/images/img_login.jpg";
  String SurName ="Người";
  String Name ="Dùng";
  String FullName="Người Dùng";
  String profession="Nhà môi giới";
  String Sodu = "0";
  String Baidadang = "0";
  String Phone = "Chưa đăng ký";
  String Email = "Chưa đăng ký";
  String Address = "KTX Khu A, ĐHQG-HCM";
  String creationTime =DateFormat('dd/MM/yyyy').format(DateTime.now());
  File image;
  final picker = ImagePicker();
  int selected = 0;
  UserStore _userstore;
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
        pathAvatar = image.path;
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userstore = Provider.of<UserStore>(context);

    if (!_userstore.loading) {
      _userstore.getCurrentUser();
      _userstore.getCurrentWalletUser();
      if(_userstore.user!=null){
        print("Duong"+_userstore.user.name);
        setState(() {
          SurName = _userstore.user.surname;
          Name = _userstore.user.name;
          FullName = SurName + " " +Name;
          if(_userstore.user.emailAddress!=null)Email = _userstore.user.emailAddress;
          if(_userstore.user.phoneNumber!=null)Phone = _userstore.user.phoneNumber;
          if(_userstore.user.wallet!=null)Sodu = _userstore.user.wallet.toString();
          else Sodu = "0";
          if(_userstore.user.creationTime!=null)creationTime = _userstore.user.creationTime.substring(8,10)+"/"+ _userstore.user.creationTime.substring(5,7)+"/"+_userstore.user.creationTime.substring(0,4);

        });
       }

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
          body: _buildBody()
      );
    }


  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      leading: _selectedIndex !=0 ? IconButton(icon: Icon(Icons.arrow_back_ios),
          onPressed: (){setState(() {
            _selectedIndex =0;
          });}):Container(),
      title:  Padding(
        padding: const EdgeInsets.only(left: 100),
        child: Text("Cá nhân"),
      ),

    );
  }
  bool _first =true;
  int _selectedIndex=0;
  Widget _buildBody() {
    return Container(
      color: Colors.orange,
      width: double.infinity,
      height:  double.infinity,
      child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: <Widget>[
            _buildUserInformation(),
            // Account(Phone: _Phone,Email: _Email,Address: _Address,),
            // MenuItem(),
            // ExpansionPanelList(
            //   animationDuration: Duration(seconds: 1),
            //   dividerColor: Colors.white,
            //   elevation: 1,
            //   expandedHeaderPadding: EdgeInsets.all(8),
            //   children: [
            //     ExpansionPanel(
            //         headerBuilder: (context,isopen){
            //           return CardItem(text: "Tài khoản của tôi",
            //               icon: Icons.account_circle_outlined,
            //               press: (){});
            //         },
            //         body: Text("hello"),
            //       canTapOnHeader: true,
            //
            //     )
            //   ],
            // )

            IndexedStack(
              children: [
                MenuItem(),
                AccountPage(Phone: Phone,Email: Email,Address: Address,SurName: SurName,Name: Name,creationTime: creationTime,),
                WalletPage(),
                ReportPage(title: "Doanh Thu",)
              ],
              index: _selectedIndex,
            ),
            // AnimatedCrossFade(
            //     secondChild: SelectItem(selected),
            //     firstChild: MenuItem(),
            //     crossFadeState: _first ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            //     duration: const Duration(seconds: 1),
            // )
          ]
      ),
    );
  }

  // Widget SelectItem(int selected){
  //   switch(selected) {
  //     case 0: {
  //       return Account(Phone: _Phone,Email: _Email,Address: _Address,);
  //     }
  //     break;
  //
  //     case 1: {
  //       return ReportPage(title: "Doanh Thu",);
  //     }
  //     break;
  //
  //     default: {
  //       return ReportPage();
  //     }
  //     break;
  //   }
  // }

  Widget MenuItem(){
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        border: Border.all(color: Colors.white,width: 10.0),
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
          Container(height: 10,color: Colors.white,),
        CardItem(
            text: "Tài Khoản của tôi",
            icon: Icons.account_circle_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: (){
              setState(() {
              // _first=!_first;
              // selected = 0;
              _selectedIndex =1;
              });
          },
        ),
        CardItem(
            text: "Ví tiền của tôi",
            icon: Icons.account_balance_wallet_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
          coloricon: Colors.orange,
            press: (){
              setState(() {
                // _first=!_first;
                // selected = 1;
                _selectedIndex =2;
              });
            },
        ),
        CardItem(
            text: "Báo cáo thống kê",
            icon: Icons.article_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
          coloricon: Colors.orange,
            press: (){
              setState(() {
                // _first=!_first;
                // selected = 1;
                _selectedIndex =3;
              });
            },
        ),
        CardItem(
            text: "Cài đặt",
            icon: Icons.settings_outlined,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
            coloricon: Colors.orange,
            press: (){
              setState(() {
                _userstore.getCurrentUser();
              });
            }
            ),
        CardItem(
            text: "Trợ giúp",
            icon: Icons.info_outline,
            colorbackgroud: Colors.grey[200],
            colortext: Colors.black,
          coloricon: Colors.orange,
            press: (){},
        ),
          // Container(height: 20,color: Colors.white,),
        ],
      ),
    );
  }

  Widget _buildUserInformation() {
    return Container(
      height: 189,

      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.yellow,
                Colors.orange
              ]
          )
      ),
      child: Container(
        padding: const EdgeInsets.only(top: 30,left: 30),
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
                        children:[
                          CircleAvatar(radius: (52),
                              backgroundColor: Colors.white,
                              child: ClipRRect(
                                borderRadius:BorderRadius.circular(50),
                                child: Image.asset(pathAvatar),
                              )
                          ),
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
                                      borderRadius: BorderRadius.circular(50),
                                      side: BorderSide(color: Colors.white)
                                    ),
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

                        ]
                      ),
                    ),
                  ],
                ),

                Container(
                  padding: const EdgeInsets.only(left: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _userstore.user!=null ? Text(
                        _userstore.user.surname+" "+_userstore.user.name,
                        style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: FontFamily.roboto
                        )
                      ):Text(
                          SurName+" "+ Name,
                          style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontFamily: FontFamily.roboto
                          )
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.people,
                            color: Colors.white,
                            size: 24.0,
                            semanticLabel: 'Text to announce in accessibility modes',
                          ),
                          Text(
                              " "+profession,
                              style: TextStyle(
                                  fontSize: 17.0,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: FontFamily.roboto
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),


              ],
            ),
            Row(

              children: [
                Container(
                  padding: const EdgeInsets.only(top: 25,left: 40,),
                  child: Column(
                    children: [
                      Text(
                        Sodu,
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: FontFamily.roboto
                      ),
                      ),
                      Text("Sô dư",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: FontFamily.roboto
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 70,),
                Container(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Text(
                        Baidadang,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontFamily: FontFamily.roboto
                        ),),
                      Text("Bài đã đăng",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: FontFamily.roboto
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }


    // Widget _buildCardItem(IconData i, String t){
    // return   Container(
    //   child: Padding(
    //       padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
    //       child: FlatButton(
    //         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    //           onPressed: (){},
    //           color: Colors.grey[200],
    //           padding: EdgeInsets.all(20),
    //           child: Row(
    //             children: [
    //               Icon(i,size: 30,color: Colors.orange,),
    //               SizedBox(width: 40,),
    //               Expanded(
    //                 child: Text(t,
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 20
    //                   )
    //                 ),
    //               ),
    //               Icon(Icons.arrow_forward_ios)
    //             ],
    //           )
    //       ),
    //     ),
    // );
    // }
}
class CardItem extends StatelessWidget{
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
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: press,
            color: colorbackgroud,
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon,size: 30,color: coloricon,),
                SizedBox(width: 40,),
                Expanded(
                  child: Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: FontFamily.roboto,
                          color: colortext
                      )
                  ),
                ),
                Icon(Icons.arrow_forward_ios,color: colortext,)
              ],
            )
        ),
      ),
    );
  }


}



