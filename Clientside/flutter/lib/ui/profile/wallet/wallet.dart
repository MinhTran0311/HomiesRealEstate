import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../profile.dart';

class WalletPage extends StatefulWidget {
  WalletPage({
    Key key,
    this.userID,
    this.title,
  }) : super(key: key);
  final int userID;
  final String title;


  @override
  _WalletPageState createState() => _WalletPageState(userID: userID);
}

class _WalletPageState extends State<WalletPage>{
  _WalletPageState({
    Key key,
    this.userID,
  }) : super();
  final int userID;
  String moneysend = "15 000";
  String datetimesend =DateFormat('yyyy-MM-ddThh:mm:ss').format(DateTime.now());
  int _selectedIndex=0;
  bool naptien = true;
  final Ctlmoneysend = TextEditingController();
  LSGDStore _lsgdStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    _lsgdStore = Provider.of<LSGDStore>(context);
    //_authTokenStore = Provider.of<AuthTokenStore>(context);
    // check to see if already called api

    if (!_lsgdStore.loading) {
      _lsgdStore.getLSGD();
    }


  }

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
        child: DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                labelColor: Colors.white,
                tabs: [
                  Tab(text: "Nạp tiền",),
                  Tab(text: "Lịch sử giao dịch",),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                IndexedStack(
                  children: [
                    // _buildListView(),
                    buildWallet(),
                    buildCreateTransactionHistory()
                  ],
                  index: _selectedIndex,
                ),
                buildLSGD()
              ],
            ),
          ),
        )

      )
    );
  }

  Widget buildCreateTransactionHistory(){
    return Container(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20,),
            createTransactionHistory(),
            CardItem(text: "Nạp tiền",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
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
          title: Text('Nạp tiền'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn nạp tiền không?'),
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
  _showErrorMessage( String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message != null && message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 5),
        )..show(context);
      }
    });

    return SizedBox.shrink();
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
  update(){
    _showSuccssfullMesssage("cập nhật ${ _lsgdStore.Naptien("${datetimesend}",double.parse(Ctlmoneysend.text), userID)}");

  }
  Widget buildWallet(){
    return Container(
      child: ListView(
        children: <Widget>[
          Image.network('https://cdn.vietnambiz.vn/171464876016439296/2020/9/18/what-is-momo-wallet-thumb-hqna4qbgf-16004154205421224807436.jpg'),
          SizedBox(height: 20,),
          Text("Nội dung chuyển tiền:\nNT <userName> <số tiền> \nGửi 0368421694\n\nVí dụ: \nNT admin 15000\nGửi 0368421694",
            style: TextStyle(fontSize: 24,fontFamily: FontFamily.roboto),),
          SizedBox(height: 20,),
          CardItem(text: "Nạp tiền",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
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
          // Divider(
          //   color: Colors.grey,
          // ),
          //
          //
          // SizedBox(height: 20,),
        ],
      ),
    );
  }

  Widget buildLSGD(){
    return  Container(
      // color: Colors.grey[200],
      child: Column(
        children: [
          // SizedBox(height: 20,),
          // Center(
          //   child: Text("Lịch sử giao dịch",
          //     style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold,fontFamily: FontFamily.roboto),),
          // ),
          SizedBox(height: 10,),
          _lsgdStore.listlsgd!=null?Container(
            height: 370, // give it a fixed height constraint
            // color: Colors.teal,
            // child ListView
            child: ListView.builder(shrinkWrap: true, // 1st add
                physics: ClampingScrollPhysics(), // 2nd add
                itemCount: _lsgdStore.listlsgd.listLSGDs.length,
                itemBuilder: (_, i) => ListTile(
                    title: buildCardTransactionHistory(_lsgdStore.listlsgd.listLSGDs[i])
                )
            ),
          ):Container(),
          // _buildListView(),
        ],
      ),
    );

  }
  Widget buildCardTransactionHistory(lichsugiaodich lsgd){
    String datetime;
    bool naptien;

    if(lsgd.kiemDuyetVienId==null){ datetime = "Đang chờ";}
    else{     datetime = DatetimeToString(lsgd.thoiDiem);    }
    if(lsgd.chiTietHoaDonBaiDangId!=null){  naptien = false;  datetime = DatetimeToString(lsgd.thoiDiem); }
    else{     naptien = true;   }
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white)
      ),
      child: Container(
        height: 60,
        padding: const EdgeInsets.all(5),
        child: Stack(
          children: [
            naptien==true?Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all( Radius.circular(50)),
                    border: Border.all(color: Colors.grey[400],width: 1.0),
                  ),
                  child: Icon(Icons.arrow_upward,color: Colors.blue,size: 30,)
              ),
            ):Align(
              alignment: Alignment.centerLeft,
              child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all( Radius.circular(50)),
                    border: Border.all(color: Colors.grey[400],width: 1.0),
                  ),
                  child: Icon(Icons.arrow_downward,color: Colors.orange,size: 30,)
              ),
            ),
            naptien==true? Align(
              alignment: Alignment.topLeft,
              child:
                // Icon(Icons.add_circle_outline,color: Colors.blue,),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: buildText("Nạp tiền",Colors.black),
                ),
            ):Align(
              alignment: Alignment.topLeft,
              child:
              //Icon(Icons.add_shopping_cart,color: Colors.orange,),
                Padding(
                  padding: const EdgeInsets.only(left: 55),
                  child: SizedBox(width:280,child: buildText("Thanh toán ${lsgd.chiTietHoaDonBaiDangName}",Colors.black)),
                ),
            ),
            naptien==true ? Align(
              alignment: Alignment.bottomRight,
                child: buildText("+${lsgd.soTien.toString()}",Colors.black),
            ): Align(
              alignment: Alignment.bottomRight,
              child: buildText("-${lsgd.soTien.toString()}",Colors.black),
            ),
            // Row(
            //   children: [
            //     Icon(Icons.attach_money,color: Colors.redAccent,),
            //     buildText("Số tiền: "+moneysend+" VND",Colors.black),
            //   ],
            // ),
            Positioned(
              top: 30,
                left: 30,
                child: datetime!="Đang chờ"?Icon(Icons.check_circle,color: Colors.greenAccent,size: 20,):
                Icon(Icons.swap_horizontal_circle,color: Colors.orangeAccent,size: 20,),
            ),
            SizedBox(height: 5,),
            Align(alignment: Alignment.topLeft,child: Padding(
              padding: const EdgeInsets.only(top: 25,left: 55),
              child: buildDateConfirm(datetime,naptien),
            )),
          ],
        ),
      ),
    );
  }
  Widget buildDateConfirm(String date,bool naptien){
    if(naptien == true){
      if(date!="Đang chờ"){
        return Row(
          children: [
            // Icon(Icons.access_time,color: Colors.grey,size: 16,),
            // buildText("Ngày xác nhận: ",Colors.grey),
            Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,fontSize: 16,color: Colors.grey),),
          ],
        );
      }
      else{
        return Row(
          children: [
            // Icon(Icons.access_time,color: Colors.deepOrange,size: 16,),
            // buildText("Ngày xác nhận: ",Colors.grey),
            Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,fontSize: 16,color: Colors.deepOrange),),
          ],
        );
      }
    }
    else{
      return Row(
        children: [
          // Icon(Icons.access_time,color: Colors.grey,size: 16,),
          // buildText("Ngày thanh toán: ",Colors.grey),
          Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontFamily: FontFamily.roboto,fontSize: 16,color: Colors.grey),),
        ],
      );
    }
  }

  Widget buildText(String text,Color c){
    return Text(text,style: TextStyle(fontFamily: FontFamily.roboto,fontSize: 18, fontWeight: FontWeight.w400,color: c),overflow: TextOverflow.ellipsis,);
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

  Widget _buildListView() {
    return _lsgdStore.listlsgd != null
        ? Expanded(
      child: ListView.separated(
        itemCount: _lsgdStore.listlsgd.listLSGDs.length,
        separatorBuilder: (context, position) {
          return Divider();
        },
        itemBuilder: (context, position) {
          return _buildLSGDPoster(_lsgdStore.listlsgd.listLSGDs[position],position);
          //_buildListItem(position);
        },
      ),
    )
        : Center(
      child: Text(
        "Không có bài đăng",
      ),
    );
  }
  Widget _buildLSGDPoster(lichsugiaodich lsgd, int index){
    return Card(
      margin: EdgeInsets.only(bottom: 24, right: 10, left: 10),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildText(lsgd.soTien.toString(), Colors.black)

        ],
      ),
    );
  }
  String DatetimeToString(String datetime){
    return "${datetime.substring(11,13)}:${datetime.substring(14,16)} - ${ datetime.substring(8,10)}/${datetime.substring(5,7)}/${datetime.substring(0,4)}";
  }
}