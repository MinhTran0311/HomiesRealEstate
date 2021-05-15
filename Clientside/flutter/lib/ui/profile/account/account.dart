import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/widgets/textfield_widget.dart';
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
  }) : super(key: key);

  final String Phone,Email,Address,SurName,Name,creationTime;

  @override
  _AccountPageState createState() => _AccountPageState(Phone: Phone,Email: Email,Address: Address,SurName: SurName,Name: Name,creationTime: creationTime);
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
  }) : super();

  String Phone,Email,Address,SurName,Name,creationTime;

  final CtlPhone = TextEditingController();
  final CtlEmail = TextEditingController();
  final CtlAddress = TextEditingController();
  final CtlSurName = TextEditingController();
  final CtlName = TextEditingController();

  int _selectedIndex=0;
  UserStore _userstore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _userstore = Provider.of<UserStore>(context);


  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        border: Border.all(color: Colors.white,width: 10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      // child:Information(),
      child:IndexedStack(
        children: [
          Information(),
          EditInformation()
        ],
        index: _selectedIndex,
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

                child:
                Padding(
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
          press: (){
            setState(() {
              _selectedIndex =1;
              CtlSurName.text = SurName;
              CtlName.text = Name;
              // CtlAddress.text = Address;
              CtlEmail.text = Email;
              CtlPhone.text = Phone;
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


  Widget EditInformation(){
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children:[
          Container(
            width: double.infinity,
            height: 380,
            child: ListView(
              children: [
                SizedBox(height: 20,),
                Text('Họ',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                buildSurnameField(SurName,CtlSurName),
                Text('Tên',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                buildSurnameField(Name,CtlName),
                Text('Email',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                buildSurnameField(Email,CtlEmail),
                Text('SĐT',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                buildSurnameField(Phone,CtlPhone),
                // Text('Đại chỉ',style: TextStyle(fontFamily:FontFamily.roboto,fontSize: 18),),
                // buildSurnameField(Address,CtlAddress),

              ],
            ),
          ),
          CardItem(text: "Cập nhật", icon: Icons.save,colorbackgroud: Colors.green,colortext: Colors.white,coloricon: Colors.white,
            press: (){
              setState(() {
                _showMyDialog();
              });
            },
          ),
        ]
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
    Address = CtlAddress.text;
    if(_userstore.updateCurrentUser(Name, SurName, Phone, Email,_userstore.user.userName,_userstore.user.id)==true){
      _userstore.getCurrentUser();
    };

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

