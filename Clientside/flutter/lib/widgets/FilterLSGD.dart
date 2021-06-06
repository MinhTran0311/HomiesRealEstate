import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/models/town/province.dart';
import 'package:boilerplate/models/town/province_list.dart';
import 'package:boilerplate/stores/lichsugiaodich/LSGD_store.dart';
import 'package:boilerplate/stores/post/filter_store.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
class Filter extends StatefulWidget {
  Filter({
    @required this.LoaiLSGD,
    @required this.ThoiDiem
  }) : super();
  String LoaiLSGD,ThoiDiem;

  @override
  _FilterState createState() => _FilterState(LoaiLSGD: LoaiLSGD,ThoiDiem: ThoiDiem);
}

class _FilterState extends State<Filter> {
  _FilterState({
    @required this.LoaiLSGD,
    @required this.ThoiDiem
  }) : super();
  String LoaiLSGD,ThoiDiem;
  LSGDStore _lsgdStore;
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _lsgdStore = Provider.of<LSGDStore>(context);
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){

        Navigator.pop(context);
        return;
      },
      child: SizedBox(
        height: size.height*0.75,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
              padding: EdgeInsets.only(right: 24,left: 24,top: 32,bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 24),
                    child: Text("Tạo bộ lọc tìm kiếm",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  buildLoaiLSGD(),
                  buildThoiDiem(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      buildApplyButton(),
                      buildClearButton(),
                    ],
                  ),
                ],
              )
          ),
        ),
      ),
    );
  }
  Widget buildApplyButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: RoundedButtonWidget(
        buttonText: "Sử dụng bộ lọc",
        textSize: 20,
        buttonColor: Colors.amber,
        textColor: Colors.white,
        onPressed: (){
          _lsgdStore.getLSGD(false,_lsgdStore.FilterDataLSGD.LoaiLSGD,_lsgdStore.FilterDataLSGD.MinThoiDiem,_lsgdStore.FilterDataLSGD.MaxThoiDiem);
          Navigator.pop(context,LoaiLSGD);
        },
      ),
    );
  }

  Widget buildClearButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3),
      child: RoundedButtonWidget(
        buttonText: "Đặt lại giá trị",
        textSize: 20,
        buttonColor: Colors.amber,
        textColor: Colors.white,
        onPressed: (){
          _lsgdStore.setLoaiLSGD("value");
        },
      ),
    );
  }
  Widget buildLoaiLSGD(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Loại LSGD",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 12,),
          Container(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 115,
                      height: 60,
                      child: Observer(
                          builder: (context){
                            return DropdownButton<String>(
                              value: _lsgdStore.FilterDataLSGD.LoaiLSGD,
                              icon: const Icon(Icons.arrow_drop_down),
                              iconSize: 24,
                              elevation: 16,
                              style: const TextStyle(color: Colors.black),
                              underline: Container(
                                height: 2,
                                color: Colors.black,
                              ),
                              onChanged: (String newValue) {
                                setState(() {
                                  _lsgdStore.FilterDataLSGD.LoaiLSGD = newValue;
                                });
                              },
                              items: <String>['Tất cả','Nạp tiền', 'Thanh toán']
                                  .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          }),

                    ),
                  ),

                ],
              )
          ),
        ],
      ),
    );
  }
  Widget buildThoiDiem(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Thời gian",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 12,),
          Container(
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: SizedBox(
                      width: 115,
                      height: 60,
                      child: Observer(
                          builder: (context){
                            return IconButton(
                              icon: Icon(Icons.date_range),
                              color: Colors.black,
                              onPressed: () async {
                                final List<DateTime> picked = await DateRangePicker.showDatePicker(
                                    context: context,
                                    initialFirstDate: DateFormat("yyyy-MM-dd").parse(_lsgdStore.FilterDataLSGD.MinThoiDiem),
                                    initialLastDate: DateFormat("yyyy-MM-dd").parse(_lsgdStore.FilterDataLSGD.MaxThoiDiem),
                                    firstDate: new DateTime(2015),
                                    lastDate: new DateTime(DateTime.now().year + 2)
                                );
                                if (picked != null && picked.length == 2) {
                                  _lsgdStore.FilterDataLSGD.MinThoiDiem = DateFormat("yyyy-MM-dd").format(picked[0]);
                                  _lsgdStore.FilterDataLSGD.MaxThoiDiem = DateFormat("yyyy-MM-dd").format(picked[1]);
                                }
                              },

                            );
                          }),

                    ),
                  ),

                ],
              )
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree

    super.dispose();
  }
}
