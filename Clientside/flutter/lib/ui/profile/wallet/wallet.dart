import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:intl/intl.dart';

import '../profile.dart';

class WalletPage extends StatefulWidget {
  WalletPage({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;


  @override
  _WalletPageState createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage>{
  _WalletPageState({
    Key key
  }) : super();
  String Sender = "Phạm Quốc Đạt";
  String Receiver = "Nguyễn Văn Dương";
  String pathAvatarsender = "assets/images/img_login.jpg";
  String pathAvatarreceiver= "assets/images/img_login.jpg";
  String moneysend = "15 000";
  String datetimesend =DateFormat('dd/MM/yyyy').format(DateTime.now());
  int _selectedIndex=0;
  bool naptien = true;
  final Ctlmoneysend = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        // border: Border.all(color: Colors.white,width: 250.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Container(

                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                //   // border: Border.all(color: Colors.white,width: 1.0),
                //   boxShadow: [
                //     BoxShadow(
                //       color: Colors.black26,
                //       spreadRadius: 5,
                //       blurRadius: 7,
                //       offset: Offset(0, 3), // changes position of shadow
                //     ),
                //   ],
                // ),
        padding: const EdgeInsets.all(20),
        child: IndexedStack(
          children: [
            buildWallet(),
            buildCreateTransactionHistory()
          ],
          index: _selectedIndex,
        ),
      )
    );
  }

  Widget buildCreateTransactionHistory(){
    return Container(
      child: Center(
        child: Column(
          children: [
            createTransactionHistory(),
            CardItem(text: "Tạo giao dịch",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
              press: (){
                setState(() {
                  _showMyDialog();

                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget createTransactionHistory(){
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
          children:[
            Container(
              width: double.infinity,
              child: Column(
                children: [
                  Image.network('https://cdn.vietnambiz.vn/171464876016439296/2020/9/18/what-is-momo-wallet-thumb-hqna4qbgf-16004154205421224807436.jpg'),
                  Text('Số tiền',style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,fontWeight: FontWeight.w400),),
                  TextFormField(
                      controller: Ctlmoneysend,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        WhitelistingTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          hintText: "1500000",
                          icon: Icon(Icons.attach_money,color: Colors.amber,)
                      )
                  ),

                ],
              ),
            ),
            // CardItem(text: "Cập nhật", icon: Icons.save,colorbackgroud: Colors.green,colortext: Colors.white,coloricon: Colors.white,
            //   press: (){
            //     setState(() {
            //       _showMyDialog();
            //     });
            //   },
            // ),
          ]
      ),
    );
  }
  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Tạo giao dịch'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn tạo lịch sử giao dịch không?'),
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
                  // update();
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
  Widget buildWallet(){
    return Container(
      child: ListView(
        children: [
          Image.network('https://cdn.vietnambiz.vn/171464876016439296/2020/9/18/what-is-momo-wallet-thumb-hqna4qbgf-16004154205421224807436.jpg'),
          SizedBox(height: 20,),
          Text("Nội dung chuyển tiền:\nNT <userName> <số tiền> \nGửi 0368421694\n\nVí dụ: \nNT admin 15000\nGửi 0368421694",
            style: TextStyle(fontSize: 24,fontFamily: FontFamily.roboto),),
          SizedBox(height: 20,),
          CardItem(text: "Tạo giao dịch",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
          press: (){
            setState(() {
              _selectedIndex = 1;
            });
          },
          ),
          // final VoidCallback press;
          // final Color colorbackgroud;
          // final Color colortext;
          // final Color coloricon;),
          Center(
            child: Text("Lịch sử giao dịch",
              style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: FontFamily.roboto),),
          ),
          Column(
            children: [
              buildCardTransactionHistory(),
              buildCardTransactionHistory(),
              buildCardTransactionHistory(),
              buildCardTransactionHistory(),
              buildCardTransactionHistory(),
            ],
          ),

          SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget buildCardTransactionHistory(){
    return Container(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 75,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          border: Border.all(color: Colors.grey[300],width: 1.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[300],
              spreadRadius: 5,
              blurRadius: 0,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.attach_money,color: Colors.green,),
                buildText("Số tiền: "+moneysend+" VND"),
              ],
            ),
            SizedBox(height: 5,),
            buildDateConfirm(datetimesend),
          ],
        ),
      ),
    );
  }
  Widget buildDateConfirm(String date){
    if(date!="Đang chờ"){
      return Row(
        children: [
          Icon(Icons.access_time,color: Colors.green,),
          buildText("Ngày xác nhận: "),
          Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,fontSize: 18,color: Colors.green),),
        ],
      );
    }
    else{
      return Row(
        children: [
          Icon(Icons.access_time,color: Colors.amber,),
          buildText("Ngày xác nhận: "),
          Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,fontSize: 18,color: Colors.amber),),
        ],
      );
    }
  }

  Widget buildText(String text){
    return Text(text,style: TextStyle(fontFamily: FontFamily.roboto,fontSize: 18, fontWeight: FontWeight.w400),);
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
}