import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';



class KiemDuyetPage extends StatefulWidget {
  KiemDuyetPage({Key key, this.title,this.UserID}) : super(key: key);

  final String title;
  final int UserID;

  @override
  _KiemDuyetPageState createState() => _KiemDuyetPageState(UserID: UserID);
}

class _KiemDuyetPageState extends State<KiemDuyetPage>{
  _KiemDuyetPageState({
    Key key,this.UserID
  }) : super();
  LSGDStore _lsgdStore;final int UserID;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _lsgdStore = Provider.of<LSGDStore>(context);

    if (!_lsgdStore.Allloading) {
      _lsgdStore.getAllLSGD();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: Observer(
            builder: (context){
              return!_lsgdStore.Allloading?_buildBody():CustomProgressIndicatorWidget();
            }
        )
      ),
    );
  }
  Widget _buildAppBar() {
    return AppBar(
      // leading: IconButton(icon: Icon(Icons.arrow_back_ios),
      //     onPressed: (){setState(() {
      //       Navigator.pop(context);
      //     });}),
      centerTitle: true,
      backgroundColor: Colors.white,
      // leading: _selectedIndex !=0 ? IconButton(icon: Icon(Icons.arrow_back_ios),
      //     onPressed: (){setState(() {
      //       _selectedIndex =0;
      //     });}):Container(),
      title:  Center(child: Text("Kiểm Duyêt")),

    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[200],
      child: RefreshIndicator(
        child: ListView.builder(
            shrinkWrap: true, // 1st add
               physics: ClampingScrollPhysics(), // 2nd add
               itemCount: _lsgdStore.listlsgdAll.listLSGDs.length,
               itemBuilder: (_, i) => ListTile(
                   title: _buildCardKiemDuyet(_lsgdStore.listlsgdAll.listLSGDs[_lsgdStore.listlsgdAll.listLSGDs.length- 1- i])
               )
        ),
        onRefresh: (){
          setState(() {
            _lsgdStore.getAllLSGD();
          });
        },
      ),
    );
  }

  Widget _buildCardKiemDuyet(lichsugiaodich lsgd){
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.white)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  lsgd.chiTietHoaDonBaiDangId ==null ?
                  Row(children: [
                      Icon(Icons.arrow_upward,color: Colors.blue,),
                      Text("Nạp tiền",style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                    ],
                  ):
                  Row(children: [
                    Icon(Icons.arrow_upward,color: Colors.orangeAccent,),
                    Text("Thanh Toán",style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                  ],
                  ),
                  Row(children: [
                    Text(" "),
                    Icon(Icons.access_time,color: Colors.grey,size: 16,),
                    Text(" "+DatetimeToString(lsgd.thoiDiem),style: TextStyle(fontSize: 16,fontFamily: FontFamily.roboto,color: Colors.grey),)
                  ],
                  ),
                  Row(children: [
                    Icon(Icons.attach_money,color: Colors.black,),
                    Text(lsgd.soTien.toString(),style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                  ],
                  ),


                  lsgd.UserName.isNotEmpty?Row(children: [
                    Icon(Icons.account_circle_outlined,color: Colors.black,),
                    Text(" "+lsgd.UserName,style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                  ],
                  ):Container(),
                  lsgd.UserNameKiemDuyet.isNotEmpty && lsgd.chiTietHoaDonBaiDangId ==null ?Row(children: [
                    Icon(Icons.account_circle_outlined,color: Colors.black,),
                    Text(" "+lsgd.UserNameKiemDuyet,style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                  ],
                  ):Container(),
                  Row(children: [
                    Text(" "),
                    Icon(Icons.edit_outlined,color: Colors.black,size: 16,),
                    Text(" "+lsgd.ghiChu,style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),)
                  ],
                  ),

                  lsgd.chiTietHoaDonBaiDangName.isNotEmpty ? Row(children: [
                    Icon(Icons.article_outlined,color: Colors.black,),
                    Container(width:300,child: Text(" "+lsgd.chiTietHoaDonBaiDangName,style: TextStyle(fontSize: 18,fontFamily: FontFamily.roboto,color: Colors.black),overflow: TextOverflow.fade,))
                  ],
                  ):Container(),

                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  lsgd.chiTietHoaDonBaiDangId ==null ? CupertinoSwitch(
                    value:  !checkKiemDuyet(lsgd.kiemDuyetVienId),
                    onChanged: (bool value) { setState(() {_showMyDialog(lsgd, UserID);  });},
                  ):Container(),

                ],
              ),
            ),
          ],
           ),
      ),
    );
  }
  String DatetimeToString(String datetime){
    return "${datetime.substring(8,10)}/${datetime.substring(5,7)}/${datetime.substring(0,4)}";
  }


  bool checkKiemDuyet(int id){
    if(id==null)return true;
    else return false;
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
  Future<void> _showMyDialog(lichsugiaodich lsgd,int UserID) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Nạp tiền'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Bạn có chắc chắn xác nhận giao dịch không?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
            ),
            TextButton(
              child: Text('Cập nhật'),
              onPressed: () {
                setState(() {
                  lsgd.kiemDuyetVienId = UserID;
                  print("Duongdebug: ${_lsgdStore.KiemDuyetGiaoDich(lsgd.id)}");
                  // _showSuccssfullMesssage("Cập nhật thành công");
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

