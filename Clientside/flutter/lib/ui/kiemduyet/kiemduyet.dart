import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/models/user/user.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/FilterLSGD.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



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
  List<bool> isexpanded = [];
  UserStore _userStore;
  final ScrollController _scrollController =
  ScrollController(keepScrollOffset: true);
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();
  bool isRefreshing = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _lsgdStore = Provider.of<LSGDStore>(context);
    _userStore = Provider.of<UserStore>(context);
    _lsgdStore.setLoaiLSGD("value");

    if (!_lsgdStore.Allloading) {
      _lsgdStore.getAllLSGD(false,"","","");
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
        ),
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
      title:  Text("Kiểm Duyêt"),

    );
  }

  Widget _buildBody() {
    return Container(
      color: Colors.grey[200],
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 50,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(top: 24),
                    child: GestureDetector(
                      onTap: () {
                        _showBottomSheet();
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 16, right: 24),
                        child: Row(
                          children: [
                            Text(
                              'Hiển thị bộ lọc nâng cao',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              color: Colors.black26,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child:
            SmartRefresher(
              key: _refresherKey,
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

                _lsgdStore.getAllLSGD(true,_lsgdStore.FilterDataLSGD.LoaiLSGD,_lsgdStore.FilterDataLSGD.MinThoiDiem,_lsgdStore.FilterDataLSGD.MaxThoiDiem);
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

                _lsgdStore.getAllLSGD(false,_lsgdStore.FilterDataLSGD.LoaiLSGD,_lsgdStore.FilterDataLSGD.MinThoiDiem,_lsgdStore.FilterDataLSGD.MaxThoiDiem);
                await Future.delayed(Duration(milliseconds: 2000));
                if (mounted) setState(() {});
                isRefreshing = true;
                _refreshController.refreshCompleted();
              },
              //scrollController: _scrollController,
              primary: false,
              child:
              Observer(builder: (context) {
                return
                  _lsgdStore.listlsgdAll.listLSGDs.length != 0 ? ListView.builder(
                      key: _contentKey,
                      controller: _scrollController,
                      shrinkWrap: true, // 1st add
                      physics: ClampingScrollPhysics(), // 2d add
                           itemCount: _lsgdStore.listlsgdAll.listLSGDs.length,
                           itemBuilder: (_, i) => ListTile(
                               title: buildExpansionKiemDuyet(_lsgdStore.listlsgdAll.listLSGDs[i])
                           )
                    ) :
                  Container(
                      child:
                        Center(child:
                          Text("Không có dữ liệu")
                        )
                  );
                }
              ),
              // ListView.builder(
              //     shrinkWrap: true, // 1st add
              //        physics: ClampingScrollPhysics(), // 2nd add
              //        itemCount: _lsgdStore.listlsgdAll.listLSGDs.length,
              //        itemBuilder: (_, i) => ListTile(
              //            title: buildExpansionKiemDuyet(_lsgdStore.listlsgdAll.listLSGDs[_lsgdStore.listlsgdAll.listLSGDs.length- 1- i],isexpanded[i],i)
              //        )
              // ),
              // onRefresh: (){
              //   setState(() {
              //     _lsgdStore.getAllLSGD();
              //   });
              // },

            ),
          ),
        ],
      ),
    );
  }
  void _showBottomSheet() {
    showModalBottomSheet<String>(
        context: context,
        enableDrag: false,
        isDismissible: false,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            )),
        builder: (BuildContext context) {
          return Wrap(
            children: [
              Filter(),
            ],
          );
        });
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
                  if(_userStore.userCurrent.UserID==lsgd.userId)
                    _userStore.userCurrent.wallet += lsgd.soTien;
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
  Widget buildExpansionKiemDuyet(lichsugiaodich lsgd){
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: ExpansionTile(
          title:  buildCardKiemDuyetheaderBuilder(lsgd),
          children: [
            buildCardKiemDuyetBody(lsgd)
          ],
      ),
    );
    // return  ExpansionPanelList(
    //         animationDuration: Duration(seconds: 2),
    //         dividerColor: Colors.grey[400],
    //         elevation: 1,
    //         expandedHeaderPadding: EdgeInsets.all(0),
    //       children: [
    //         ExpansionPanel(
    //             headerBuilder: (BuildContext context,bool isexpanded){
    //              return buildCardKiemDuyetheaderBuilder(lsgd);
    //             },
    //             body: buildCardKiemDuyetBody(lsgd),
    //           isExpanded:isexpand
    //         )
    //       ],
    //     expansionCallback: (int i,bool e){setState(() {
    //       isexpanded[i] =! isexpanded[i];
    //     });} ,
    //     // ),
    //   // ),
    // );
  }
  Widget buildCardKiemDuyetBody(lichsugiaodich lsgd){
    bool naptien;
    final ButtonStyle styleActive =
    ElevatedButton.styleFrom(primary: Colors.lightGreen);
    final ButtonStyle style =
    ElevatedButton.styleFrom(onPrimary: Colors.redAccent);
    if(lsgd.chiTietHoaDonBaiDangId!=null){
      return Container(
        width: double.infinity,
        height: 100,
        padding: const EdgeInsets.all(5),
        child:
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child:
                  Stack(
                    children: [
                      //top
                      Align(
                        alignment: Alignment.topLeft,
                        child: buildText("Số tiền",Colors.black),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: buildText("-${priceFormat(lsgd.soTien)}",Colors.grey),
                      ),
                      //center
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildText("Người dùng",Colors.black),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildText("${lsgd.UserName}",Colors.grey),
                      ),
                      // bottom
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: buildText("Bài đăng",Colors.black),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(width:200,child: buildText("${lsgd.chiTietHoaDonBaiDangName}",Colors.grey)),
                      ),
                    ],
                  )
              ),
            ),
          ],
        )
    );
    }
    else{ //true
      return Container(
        width: double.infinity,
        height: 160,
        padding: const EdgeInsets.all(5),
        child:
        Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(10),
                  child:
                  Stack(
                    children: [
                      //top
                      Align(
                        alignment: Alignment.topLeft,
                        child: buildText("Số tiền",Colors.black),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: buildText("+${priceFormat(lsgd.soTien)}",Colors.grey),
                      ),
                      //center
                      Align(
                        alignment: Alignment.centerLeft,
                        child: buildText("Người dùng",Colors.black),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: buildText("${lsgd.UserName}",Colors.grey),
                      ),
                      // bottom
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: buildText("Kiểm Duyệt viên",Colors.black),
                      ),
                      lsgd.kiemDuyetVienId!=null?Align(
                        alignment: Alignment.bottomRight,
                        child: buildText("${lsgd.UserNameKiemDuyet}",Colors.grey),
                      ): Align(
                        alignment: Alignment.bottomRight,
                        child: buildText("...",Colors.grey),
                      ),
                    ],
                  )
              ),
            ),
            lsgd.kiemDuyetVienId!=null?
            Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Container(
                    width: 300,
                    height: 30,
                    child: Center(
                      child: Text(
                          "Đã kiểm duyệt",
                          style: TextStyle(fontFamily: FontFamily.roboto,fontSize: 18, fontWeight: FontWeight.w400,color: Colors.white)
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.lightGreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            side: BorderSide(color: Colors.red),
                          )
                      )
                  ),
                  onPressed:null,
                )
            ):
            Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  child: Container(
                    width: 300,
                    height: 30,
                    child: Center(
                      child: Text(
                          "Chưa kiểm duyệt",
                          style: TextStyle(fontFamily: FontFamily.roboto,fontSize: 18, fontWeight: FontWeight.w400,color: Colors.white)
                      ),
                    ),
                  ),
                  style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.redAccent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(18)),
                            side: BorderSide(color: Colors.red),
                          )
                      )
                  ),
                  onPressed:(){
                    setState(() {_showMyDialog(lsgd, UserID);  });
                  },
                )
            )
          ],
        )
    );
    }

  }
  Widget buildCardKiemDuyetheaderBuilder(lichsugiaodich lsgd){
    String datetime;
    bool naptien;

    if(lsgd.kiemDuyetVienId==null){ datetime = "Đang chờ";}
    else{     datetime = DatetimeToString(lsgd.thoiDiem);    }
    if(lsgd.chiTietHoaDonBaiDangId!=null){  naptien = false;  datetime = DatetimeToString(lsgd.thoiDiem); }
    else{     naptien = true;   }
    return
      // Card(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     side: BorderSide(color: Colors.white)
      // ),
      // child:
      Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.all(5),
        child:

        Stack(
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
            Align(
              alignment: Alignment.topLeft,
              child:
              // Icon(Icons.add_circle_outline,color: Colors.blue,),
              Padding(
                padding: const EdgeInsets.only(left: 55),
                child: buildText(lsgd.UserName,Colors.black),
              ),
            ),

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
      // ),
    );
  }
  Widget buildText(String text,Color c){
    return Text(text,style: TextStyle(fontFamily: FontFamily.roboto,fontSize: 18, fontWeight: FontWeight.w400,color: c),overflow: TextOverflow.ellipsis,);
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
}

