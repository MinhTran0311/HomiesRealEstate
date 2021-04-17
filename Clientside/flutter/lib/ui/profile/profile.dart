

import 'dart:io';

import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

import 'account/account.dart';

class ProfileScreen extends StatefulWidget{
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>{
  String _pathAvatar= "http://i.pravatar.cc/300";
  String _FullName="Phạm Quốc Đạt";
  String _profession="Nhà môi giới";
  String _Sodu = "1.000.000";
  String _Baidadang = "125";
  String _Phone = "0352565635";
  String _Email = "datpham1610@gmail.com";
  String _Address = "KTX Khu A, ĐHQG-HCM";

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        _pathAvatar = _image.path;
      } else {
        print('No image selected.');
      }
    });
  }


  @override
  void initState() {
    super.initState();
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
          // appBar: _buildAppBar(),
          body: _buildBody()
      );
    }


  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: Center(
          child: Text("Cá nhân")),

    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.orange,
      width: double.infinity,
      height:  double.infinity,
      child: ListView(
          children: <Widget>[
            _buildUserInformation(),
            // Account(Phone: _Phone,Email: _Email,Address: _Address,),
            MenuItem(),
          ]
      ),
    );
  }

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
        CardItem(text: "Tài Khoản của tôi",
            icon: Icons.account_circle_outlined,
            press: (){


          },
        ),
        CardItem(text: "Ví tiền của tôi", icon: Icons.account_balance_wallet_outlined, press: (){}),
        CardItem(text: "Báo cáo thống kê", icon: Icons.article_outlined, press: (){}),
        CardItem(text: "Cài đặt", icon: Icons.settings_outlined, press: (){}),
        CardItem(text: "Trợ giúp", icon: Icons.info_outline, press: (){}),
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
                                child: Image.asset(_pathAvatar),
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
                      Text(
                        _FullName,
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
                              " "+_profession,
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
                        _Sodu,
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
                        _Baidadang,
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


    Widget _buildCardItem(IconData i, String t){
    return   Container(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              onPressed: (){},
              color: Colors.grey[200],
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(i,size: 30,color: Colors.orange,),
                  SizedBox(width: 40,),
                  Expanded(
                    child: Text(t,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20
                      )
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
          ),
        ),
    );
    }
}
class CardItem extends StatelessWidget{
  const CardItem({
    Key key,
    @required this.text,
    @required this.icon,
    @required this.press
  }) : super(key: key);

    final String text;
    final IconData icon;
    final VoidCallback press;


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: FlatButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            onPressed: press,
            color: Colors.grey[200],
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(icon,size: 30,color: Colors.orange,),
                SizedBox(width: 40,),
                Expanded(
                  child: Text(text,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 20,
                          fontFamily: FontFamily.roboto
                      )
                  ),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            )
        ),
      ),
    );
  }}