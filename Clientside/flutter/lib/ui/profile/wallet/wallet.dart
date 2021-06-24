import 'package:boilerplate/constants/colors.dart';
import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/lichsugiaodich/lichsugiadich.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/stores/user/user_store.dart';
import 'package:boilerplate/ui/home/detail.dart';
import 'package:boilerplate/utils/locale/app_localization.dart';
import 'package:boilerplate/widgets/FilterLSGD.dart';
import 'package:boilerplate/widgets/card_item_widget.dart';
import 'package:boilerplate/widgets/generalMethods.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
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
  final ScrollController _scrollController =
  ScrollController(keepScrollOffset: true);
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  GlobalKey _contentKey = GlobalKey();
  GlobalKey _refresherKey = GlobalKey();
  bool isRefreshing = false;
  String dropdownValue = 'Tất cả';
  ThemeStore _themeStore;
  UserStore _userStore;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();


    _userStore = Provider.of<UserStore>(context);
    _lsgdStore = Provider.of<LSGDStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);
    //_authTokenStore = Provider.of<AuthTokenStore>(context);
    // check to see if already called api
    _lsgdStore.setLoaiLSGD("value");

    if (!_lsgdStore.loading) {
      _lsgdStore.getLSGD(false,"","","");
    }

  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Ví tiền",),
          bottom: TabBar(
            labelColor: Colors.white,
            tabs: [
              Tab(child: Text("Nạp tiền",style: TextStyle(fontSize: 16),)),
              Tab(child: Text("Lịch sử giao dịch",style: TextStyle(fontSize: 16),)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            buildWallet(),
            Observer(
                builder: (context) {
                  return !_lsgdStore.loading ? buildLSGD():CustomProgressIndicatorWidget();
                }
            )
          ],
        ),
      ),
    );
  }

  Widget buildWallet(){
    return Container(
      child: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.network('https://cdn.vietnambiz.vn/171464876016439296/2020/9/18/what-is-momo-wallet-thumb-hqna4qbgf-16004154205421224807436.jpg'),
          ),
          SizedBox(height: 20,),
          Center(
            child: Text("Nội dung chuyển tiền:\nNT <userName> <số tiền> \nGửi 0368421694\n\nVí dụ: \nNT ${_userStore.userCurrent.userName} 15000\nGửi 0368421694",
              style: TextStyle(fontSize: 24,),),
          ),
          CardItem(text: "Nạp tiền",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
            isFunction: false,
            press: (){
            setState(() {
              Route route = MaterialPageRoute(builder: (context) => NapTienPage(userID: userID,));
              Navigator.push(context, route);
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
                                color: _lsgdStore.FilterDataLSGD.LoaiLSGD != "Tất cả" ||
                                    _lsgdStore.FilterDataLSGD.MinThoiDiem !=DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: -1000))) ||
                                    _lsgdStore.FilterDataLSGD.MaxThoiDiem != DateFormat('yyyy-MM-dd').format(DateTime.now().add(Duration(days: 1)))
                                    ? Colors.red : Colors.grey,
                              ),
                            ),
                            Icon(
                              Icons.arrow_drop_down,
                              // color: Colors.black26,
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
          _lsgdStore.listlsgd!=null ? Expanded(
            // height: 460, // give it a fixed height constraint
            // color: Colors.teal,
            // child ListView
            child: SmartRefresher(
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
                _lsgdStore.getLSGD(true,_lsgdStore.FilterDataLSGD.LoaiLSGD,_lsgdStore.FilterDataLSGD.MinThoiDiem,_lsgdStore.FilterDataLSGD.MaxThoiDiem);
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
                _lsgdStore.getLSGD(false,_lsgdStore.FilterDataLSGD.LoaiLSGD,_lsgdStore.FilterDataLSGD.MinThoiDiem,_lsgdStore.FilterDataLSGD.MaxThoiDiem);
                await Future.delayed(Duration(milliseconds: 2000));
                if (mounted) setState(() {});
                isRefreshing = true;
                _refreshController.refreshCompleted();
              },
              primary: false,
              child: ListView.builder(
                  key: _contentKey,
                  controller: _scrollController,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true, // 1st add
                  // physics: ClampingScrollPhysics(), // 2nd add
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: _lsgdStore.listlsgd.listLSGDs.length,
                  itemBuilder: (_, i) => ListTile(
                      title: buildCardTransactionHistory(_lsgdStore.listlsgd.listLSGDs[i])
                  )
              ),

            ),
          ):Container(),
          // _buildListView(),
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
  Future<void> _showMyDialog(String name,String date) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chi tiết lịch sử giao dịch'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(date),
                Text(name),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  Widget buildCardTransactionHistory(lichsugiaodich lsgd){
    String datetime;
    bool naptien;

    if(lsgd.kiemDuyetVienId==null){ datetime = "Đang chờ";}
    else{     datetime = DatetimeToString(lsgd.thoiDiem);    }
    if(lsgd.chiTietHoaDonBaiDangId!=null){  naptien = false;  datetime = DatetimeToString(lsgd.thoiDiem); }
    else{     naptien = true;   }
    return GestureDetector(
      onTap: () {
        if(naptien!=true)
          _showMyDialog(lsgd.chiTietHoaDonBaiDangName +"\n"+priceFormat(lsgd.soTien),datetime);
        else{
          _showMyDialog("Nạp tiền \n"+priceFormat(lsgd.soTien),datetime);
        }
      },
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            // side: BorderSide(color: Colors.white),

        ),
        color: _themeStore.darkMode==true? AppColors.darkBlueForCardDarkTheme:AppColors.greyForCardLightTheme,
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
                    child: Icon(Icons.arrow_downward,color: Colors.amber,size: 30,)
                ),
              ),
              naptien==true? Align(
                alignment: Alignment.topLeft,
                child:
                  // Icon(Icons.add_circle_outline,color: Colors.blue,),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: buildText("Nạp tiền", _themeStore.darkMode==true? Colors.white: Color.fromRGBO(18, 22, 28, 1),),
                  ),
              ):Align(
                alignment: Alignment.topLeft,
                child:
                //Icon(Icons.add_shopping_cart,color: Colors.orange,),
                  Padding(
                    padding: const EdgeInsets.only(left: 55),
                    child: SizedBox(width:280,child: buildText("Thanh toán ${lsgd.chiTietHoaDonBaiDangName}", _themeStore.darkMode==true? Colors.white: Color.fromRGBO(18, 22, 28, 1))),
                  ),
              ),
              naptien==true?Align(
                alignment: Alignment.bottomRight,
                child: buildText("+${priceFormat(lsgd.soTien)}", _themeStore.darkMode==true? Colors.white: Color.fromRGBO(18, 22, 28, 1),),
              ):Align(
                alignment: Alignment.bottomRight,
                child: buildText("-${priceFormat(lsgd.soTien)}", _themeStore.darkMode==true? Colors.white: Color.fromRGBO(18, 22, 28, 1),),
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
                  Icon(Icons.swap_horizontal_circle,color: Colors.amberAccent,size: 20,),
              ),
              SizedBox(height: 5,),
              Align(alignment: Alignment.topLeft,child: Padding(
                padding: const EdgeInsets.only(top: 25,left: 55),
                child: buildDateConfirm(datetime,naptien),
              )),
            ],
          ),
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
            Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey),),
          ],
        );
      }
      else{
        return Row(
          children: [
            // Icon(Icons.access_time,color: Colors.deepOrange,size: 16,),
            // buildText("Ngày xác nhận: ",Colors.grey),
            Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.amberAccent),),
          ],
        );
      }
    }
    else{
      return Row(
        children: [
          // Icon(Icons.access_time,color: Colors.grey,size: 16,),
          // buildText("Ngày thanh toán: ",Colors.grey),
          Text(date, style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.grey),),
        ],
      );
    }
  }

  Widget buildText(String text,Color c){
    return Text(text,style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400,color: c),overflow: TextOverflow.ellipsis,);
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
          return _buildLSGDPoster(_lsgdStore.listlsgd.listLSGDs[_lsgdStore.listlsgd.listLSGDs.length - position],_lsgdStore.listlsgd.listLSGDs.length -position);
          //_buildListItem(position);
        },
      ),
    )
        : Center(
      child: Text(
        "Không có dữ liệu",
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




class NapTienPage extends StatefulWidget {
  NapTienPage({
    Key key,
    this.userID,
    this.title,
  }) : super(key: key);
  final int userID;
  final String title;
  @override
  _NapTienPageState createState() => _NapTienPageState(userID: userID);
}

class _NapTienPageState extends State<NapTienPage> {
  _NapTienPageState({
    Key key,
    this.userID,
  }) : super();
  final int userID;
  String moneysend = "15 000";
  String datetimesend = DateFormat('yyyy-MM-ddThh:mm:ss').format(
      DateTime.now());
  bool naptien = true;
  final Ctlmoneysend = TextEditingController();
  LSGDStore _lsgdStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _lsgdStore = Provider.of<LSGDStore>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
          appBar: AppBar(title: Text("Nạp tiền"),
            // leading: IconButton(icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
            //     onPressed: (){setState(() {
            //       Navigator.pop(context);
            //     });}),
          ),
            body: buildCreateTransactionHistory()
        )
    );
  }
  Widget buildCreateTransactionHistory(){
    return Stack(
      children: [
        Observer(
          builder: (context) {
            print("DuongDebug ${_lsgdStore.naptien_success}");
            if (_lsgdStore.naptien_success) {
              Future.delayed(Duration(milliseconds: 0), () {
                Navigator.pop(context);
              });
              // _lsgdStore.setKiemDuyenVienID(UserID, i);
              showSuccssfullMesssage("Nạp tiền thành công",context);
              _lsgdStore.naptien_success = false;
              return Container(width: 0, height: 0);
            } else {
              return showErrorMessage(_lsgdStore.errorStore.errorMessage,context);
            }
          },
        ),
        Container(
          child: Center(
            child: Wrap(
              children: [
                SizedBox(height: 20,),
                createTransactionHistory(),
                CardItem(text: "Nạp tiền",icon: Icons.create_outlined,coloricon: Colors.white,colorbackgroud: Colors.green,colortext: Colors.white,
                  isFunction: false,
                  press: (){
                    setState(() {
                      if(Ctlmoneysend.text.length>3)
                      _showMyDialog();
                      else(
                      showErrorMessage("Số tiền tối thiểu là 1000 VND",context)
                      );
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
  Widget createTransactionHistory(){
    return Container(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        children: [
          Image.network('https://cdn.vietnambiz.vn/171464876016439296/2020/9/18/what-is-momo-wallet-thumb-hqna4qbgf-16004154205421224807436.jpg'),
          Text('Số tiền',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w400),),
          TextFormField(
              controller: Ctlmoneysend,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  hintText: "1500000",
                  icon: Icon(Icons.attach_money,color: Colors.amber,),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.amber),
                ),
                border:  UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                ),
              )
          ),
          // Observer(builder: (context)=> Ctlmoneysend.text.length<4?Text("Số tiền tối thiểu là 1000",style: TextStyle(fontFamily: FontFamily.roboto,color: Colors.redAccent),):Container())

        ],
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
              child: Text('Xác nhận'),
              onPressed: () async {
                update();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Hủy'),
              onPressed: () {
                setState(() {
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }


  update() async {
    _lsgdStore.Naptien("${datetimesend}",double.parse(Ctlmoneysend.text), userID);
    // Route route = MaterialPageRoute(builder: (context) => WalletPage(userID: userID,));
    // Navigator.push(context, route);
    // _showSuccssfullMesssage("Nạp tiền thành công");
  }
}

class FilterData{
   String LoaiLSGD;
   String MinThoiDiem;
   String MaxThoiDiem;

  FilterData(
      this.LoaiLSGD,
      this.MinThoiDiem,
      this.MaxThoiDiem,
      );
}