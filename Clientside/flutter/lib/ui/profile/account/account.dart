import 'dart:convert';

import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../profile.dart';

class AccountPage extends StatefulWidget {
  AccountPage({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.Address,
    @required this.SurName,
    @required this.Name,
    @required this.creationTime,
    @required this.UserName,
    @required this.UserID,
  }) : super(key: key);

  final String Phone,Email,Address,SurName,Name,creationTime,UserName;
  final int UserID;
  @override
  _AccountPageState createState() => _AccountPageState(Phone: Phone,Email: Email,Address: Address,SurName: SurName,Name: Name,UserName: UserName,creationTime: creationTime,UserID: UserID);
}


class _AccountPageState extends State<AccountPage>{
  _AccountPageState({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.Address,
    @required this.SurName,
    @required this.Name,
    @required this.creationTime,
    @required this.UserName,
    @required this.UserID,
  }) : super();

  String Phone,Email,Address,SurName,Name,creationTime,UserName;
  final int UserID;

  final CtlPhone = TextEditingController();
  final CtlEmail = TextEditingController();
  final CtlAddress = TextEditingController();
  final CtlSurName = TextEditingController();
  final CtlName = TextEditingController();
  String role =" Khách";
  int _selectedIndex=0;
  UserStore _userstore;
  String pathAvatar = "assets/images/img_login.jpg";
  ThemeStore _themeStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userstore = Provider.of<UserStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("Tài khoản của tôi"),
        // backgroundColor: Colors.white,
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        //   onPressed: (){setState(() {
        //     Navigator.pop(context);
        //   });}),
      ),
      body: Container(
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   // topLeft: Radius.circular(25),
          //   // topRight: Radius.circular(25),
          // ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                // Colors.blue,
                // Colors.red,
                Colors.orange.shade700,
                Colors.amberAccent.shade100,
              ],
            )
        ),
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        //   border: Border.all(color: Colors.white,width: 10.0),
        //   boxShadow: [
        //     BoxShadow(
        //       color: Colors.white,
        //       spreadRadius: 5,
        //       blurRadius: 0,
        //       offset: Offset(0, 3), // changes position of shadow
        //     ),
        //   ],
        // ),
        // child:Information(),
        child: Observer(
        builder: (context) {return _userstore.userCurrent!=null? _showSimpleModalDialog():CustomProgressIndicatorWidget();}
        )
      ),
    );
  }

  Widget Information(){
    return Column(
      children: [
        Container(
          width: double.infinity,
          color: Colors.white,
          height: 200,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
            child: Container(
                width: 200,
                height: 200,
                // color: Colors.grey[400],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  border: Border.all(color: Colors.grey[300],width: 0.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[200],
                      spreadRadius: 5,
                      blurRadius: 0,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),

                child: Padding(
                  padding: const EdgeInsets.only(left: 15.0,top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Giới thiệu",
                        style: TextStyle(
                            fontFamily: FontFamily.roboto,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 24
                        ),
                      ),
                      TextIcon(icon: Icons.phone, text: Phone),
                      TextIcon(icon: Icons.mail, text: Email),
                      // TextIcon(icon: Icons.location_on, text: Address)
                    ],
                  ),
                )
            ),
          ),
        ),
        CardItem(text: "Cập nhật", icon: Icons.save,colorbackgroud: Colors.green,colortext: Colors.white,coloricon: Colors.white,
          isFunction: false,
          press: (){
            setState(() {
              Route route = MaterialPageRoute(builder: (context) => AccountEditPage(Phone: Phone,Email: Email,SurName: SurName,Name: Name,creationTime: creationTime));
              Navigator.push(context, route);
            });
          },
        ),
        Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: TextIcon(icon: Icons.access_time_outlined, text: "Đã tham gia "+creationTime)
        ),

      ],
    );
  }

  Widget _showSimpleModalDialog(){
          return Wrap(
            children: [
              Container(
                decoration: BoxDecoration(
                    // borderRadius: BorderRadius.only(
                    //   // topLeft: Radius.circular(25),
                    //   // topRight: Radius.circular(25),
                    // ),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        // Colors.blue,
                        // Colors.red,
                        Colors.orange.shade700,
                        Colors.amberAccent.shade100,
                      ],
                    )
                ),
                // padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children:[
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              // mainAxisSize: MainAxisSize.max,
                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Observer(builder: (context) {
                                  return _userstore.userCurrent.picture != null
                                      ? CircleAvatar(radius: (52),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.memory(Base64Decoder().convert(_userstore.userCurrent.picture)),
                                      )
                                      )
                                      : CircleAvatar(
                                      radius: (52),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.circular(50),
                                        child: Image.network("https://st.quantrimang.com/photos/image/2017/04/08/anh-dai-dien-FB-200.jpg"),
                                      ));
                                }),

                                // SizedBox(height: 10,),
                                Text(
                                  "${SurName} " + "${Name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 5,),
                                Row(
                                  children: [
                                    _userstore.userCurrent.listRole.length<=1?Icon(
                                      Icons.person_pin,
                                      color: Colors.white,
                                      size: 20,
                                    ):
                                    Icon(
                                      Icons.people,
                                      color: Colors.white,
                                      size: 20.0,
                                      semanticLabel:
                                      'Text to announce in accessibility modes',
                                    ),
                                    SizedBox(width: 10,),
                                    Observer(builder: (context) {
                                      if(_userstore.userCurrent != null){
                                        if(_userstore.userCurrent.listRole != null){
                                          role="${_userstore.userCurrent.listRole[0].roleName}";
                                          print("debug ${_userstore.userCurrent.listRole.length}");
                                          for(int i=1,ii=_userstore.userCurrent.listRole.length;i<ii;i++){
                                            role += ", ${_userstore.userCurrent.listRole[i].roleName}";
                                          }
                                        }
                                      }
                                      return
                                        _userstore.userCurrent != null ? Row(
                                          children: [

                                            Text(role,
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    )),
                                          ],
                                        ) : Container();
                                    }
                                    ),
                                    // Text(
                                    //   _userstore.userCurrent.listRole[0].roleName,
                                    //   style: TextStyle(
                                    //     color: Colors.white,
                                    //     fontSize: 20,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                            margin: EdgeInsets.all(20),
                          ),
                        ]
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25),
                        ),
                        // gradient: LinearGradient(
                        //   begin: Alignment.topRight,
                        //   end: Alignment.bottomLeft,
                        //   colors: [
                        //     // Colors.blue,
                        //     // Colors.red,
                        //     Colors.orange.shade700,
                        //     Colors.amberAccent.shade100,
                        //   ],
                        // )
                        color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(18, 22, 28, 1),
                      ),
                      width: MediaQuery.of(context).size.width,
                      // margin: EdgeInsets.only(bottom: 10),
                      // padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                      // color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                            decoration: BoxDecoration(
                              // borderRadius: BorderRadius.only(
                              //   topLeft: Radius.circular(25),
                              //   topRight: Radius.circular(25),
                              // ),
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.amber,
                                  width: 1.0,
                                ),
                                // top: BorderSide( //                    <--- top side
                                //   color: Colors.amber,
                                //   width: 1.0,
                                // ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Tài khoản",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // alignment: Alignment.centerRight,
                                  "${UserName}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.mail,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Email",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // alignment: Alignment.centerRight,
                                  "${Email}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only( left: 15, right: 15),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.amber,
                                  width: 1.0,
                                ),
                                // top: BorderSide( //                    <--- top side
                                //   color: Colors.amber,
                                //   width: 1.0,
                                // ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                // SizedBox(width: 10,),
                                // user.isEmailConfirmed == false ? Icon(
                                //   Icons.warning_rounded,
                                //   color: Colors.red,
                                //   size: 24,
                                // ) : Icon (
                                //   Icons.check_circle,
                                //   color: Colors.green,
                                //   size: 24,
                                // ),
                              ],
                            ),
                          ),
                          // SizedBox(height: 30,),
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.amber,
                                  width: 1.0,
                                ),
                                // top: BorderSide( //                    <--- top side
                                //   color: Colors.amber,
                                //   width: 1.0,
                                // ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Điện thoại",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                (Phone == null || Phone.isEmpty) ?
                                Text(
                                  // alignment: Alignment.centerRight,
                                  "****",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                                    :Text(
                                  // alignment: Alignment.centerRight,
                                  "${Phone}",
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide( //                   <--- left side
                                  color: Colors.amber,
                                  width: 1.0,
                                ),
                                // top: BorderSide( //                    <--- top side
                                //   color: Colors.amber,
                                //   width: 1.0,
                                // ),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.timelapse,
                                        color: Colors.amber,
                                        size: 28,
                                      ),
                                      SizedBox(width: 10,),
                                      Text(
                                        "Ngày tham gia",
                                        style: TextStyle(
                                          color: Colors.amber,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // alignment: Alignment.centerRight,
                                  "${creationTime}",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 20),
                              // decoration: BoxDecoration(
                              //   border: Border(
                              //     bottom: BorderSide( //                   <--- left side
                              //       color: Colors.amber,
                              //       width: 1.0,
                              //     ),
                              //     // top: BorderSide( //                    <--- top side
                              //     //   color: Colors.amber,
                              //     //   width: 1.0,
                              //     // ),
                              //   ),
                              // ),
                              child: ElevatedButton(
                                child: Text(
                                  "Chỉnh sửa thông tin",
                                  style: TextStyle(fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                style: ButtonStyle(
                                    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                    backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(18)),
                                          side: BorderSide(color: Colors.red),
                                        )
                                    )
                                ),
                                onPressed: () {_navigateAndDisplaySelection(context);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(builder: (context) => AccountEditPage(Phone: Phone,Email: Email,SurName: SurName,Name: Name,creationTime: creationTime)),
                                  // );
                                },
                              )
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );

  }
  void _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>AccountEditPage(Phone: Phone,Email: Email,SurName: SurName,Name: Name,creationTime: creationTime)),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
  }

}



class TextIcon extends StatelessWidget{
  const TextIcon({
    Key key,
    @required this.icon,
    @required this.text,
  }) : super(key: key);
  final String text;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,top: 10),
      child: Row(
        children: [
          Icon(icon,color: Colors.orange),
          Text(" "+text,
            style: TextStyle(
                fontSize: 20,
                fontFamily: FontFamily.roboto,
                color: Colors.black
            ),
          )
        ],
      ),
    );
  }

}


class AccountEditPage extends StatefulWidget {
  AccountEditPage({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.SurName,
    @required this.Name,
    @required this.creationTime,
    @required this.UserID,
  }) : super(key: key);

  final String Phone,Email,SurName,Name,creationTime;
  final int UserID;
  @override
  _AccountEditPageState createState() => _AccountEditPageState(Phone: Phone,Email: Email,SurName: SurName,Name: Name,creationTime: creationTime,UserID: UserID);
}


class _AccountEditPageState extends State<AccountEditPage> {
  _AccountEditPageState({
    Key key,
    @required this.Phone,
    @required this.Email,
    @required this.SurName,
    @required this.Name,
    @required this.creationTime,
    @required this.UserID,
  }) : super();

  String Phone, Email,  SurName, Name, creationTime;
  final int UserID;
  final CtlPhone = TextEditingController();
  final CtlEmail = TextEditingController();
  final CtlAddress = TextEditingController();
  final CtlSurName = TextEditingController();
  final CtlName = TextEditingController();

  int _selectedIndex = 0;
  UserStore _userstore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userstore = Provider.of<UserStore>(context);
    CtlSurName.text = SurName;
    CtlName.text = Name;
    CtlEmail.text = Email;
    CtlPhone.text = Phone;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // centerTitle: true,
        title: Text("Chỉnh sửa thông tin cá nhân"),
        // backgroundColor: Colors.white,
        // leading: IconButton(icon: Icon(Icons.arrow_back_ios),
        //     onPressed: (){setState(() {
        //       Navigator.pop(context);
        //     });}),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.only(
          //   // topLeft: Radius.circular(25),
          //   // topRight: Radius.circular(25),
          // ),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                // Colors.blue,
                // Colors.red,
                Colors.orange.shade700,
                Colors.amberAccent.shade100,
              ],
            )
        ),
        child: Wrap(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Column(
                  children:[
                    Container(
                      width: double.infinity,
                      height: 380,
                      child: ListView(
                        children: [
                          SizedBox(height: 20,),
                          Text('Họ',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18,color: Colors.white),),
                          buildSurnameField(SurName,CtlSurName),
                          Text('Tên',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18,color: Colors.white),),
                          buildSurnameField(Name,CtlName),
                          Text('Email',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18,color: Colors.white),),
                          buildSurnameField(Email,CtlEmail),
                          Text('SĐT',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18,color: Colors.white),),
                          buildSurnameField(Phone,CtlPhone),
                          // Text('Đại chỉ',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                          // buildSurnameField(Address,CtlAddress),

                        ],
                      ),
                    ),
                    SizedBox(height:10),
                    ElevatedButton(
                      child: Text(
                        "Chỉnh sửa thông tin",
                        style: TextStyle(fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.amber),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(18)),
                                side: BorderSide(color: Colors.red),
                              )
                          )
                      ),
                      onPressed: () {
                        _showMyDialog();
                      },
                    )
                    // CardItem(text: "Cập nhật", icon: Icons.save,colorbackgroud: Colors.green,colortext: Colors.white,coloricon: Colors.white,
                    //   press: (){
                    //     setState(() {
                    //       _showMyDialog();
                    //     });
                    //   },
                    // ),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget buildSurnameField(String title,TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20,bottom: 20),
      child: TextField(
        controller: controller,

        // obscureText: true,

        // decoration: InputDecoration(
        //   // border: OutlineInputBorder(),
        //   labelText: title,
        //
        // ),
      ),
    );
  }

  void update(){
    SurName = CtlSurName.text;
    Name = CtlName.text;
    Email = CtlEmail.text;
    Phone = CtlPhone.text;
    setState(() {
      _userstore.updateCurrentUser(Name, SurName, Phone, Email,_userstore.userCurrent.userName,UserID);
      _showSuccssfullMesssage("Cập nhật thành công");
    });

  }
  _showSuccssfullMesssage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: "Thông báo",
          duration: Duration(seconds: 5),
        )
            .show(context);
      }
      return SizedBox.shrink();
    });
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Cập nhật thông tin'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn cập nhật thông tin?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                setState(() {
                  _selectedIndex =1;
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: Text('Cập nhật'),
              onPressed: () {
                setState(() {
                  update();
                  _selectedIndex =0;
                  Navigator.of(context).pop();

                });
              },
            ),
          ],
        );
      },
    );
  }

}