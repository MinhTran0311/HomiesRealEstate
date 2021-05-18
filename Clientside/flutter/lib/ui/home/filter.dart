import 'package:boilerplate/models/post/filter_model.dart';
import 'package:boilerplate/stores/post/filter_store.dart';
import 'package:boilerplate/widgets/rounded_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class Filter extends StatefulWidget {
  @required filter_Model filterModel;
  Filter({@required this.filterModel});
  @override
  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  FilterStore _filterStore;

  TextEditingController _giaMinValueController = TextEditingController();
  TextEditingController _giaMaxValueController = TextEditingController();
  TextEditingController _dienTichMinValueController = TextEditingController();
  TextEditingController _dienTichMaxValueController = TextEditingController();
  TextEditingController _diaChiController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  FocusNode _minGiaFocus;
  FocusNode _minDienTichFocus;

  @override
  void initState() {
    super.initState();
    _minGiaFocus = new FocusNode();
    _minDienTichFocus = new FocusNode();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _filterStore = Provider.of<FilterStore>(context);

    _diaChiController.text = _filterStore.filter_model.diaChi;
    _usernameController.text = _filterStore.filter_model.username;
    _giaMinValueController.text=_filterStore.filter_model.giaMin;
    _giaMaxValueController.text=_filterStore.filter_model.giaMax;
    _dienTichMinValueController.text = _filterStore.filter_model.dienTichMin;
    _dienTichMaxValueController.text = _filterStore.filter_model.dienTichMax;
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){
        Navigator.pop(context, _filterStore.validateSearchContent());
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
                  buildLoaiBaiDang(),
                  buildGiaFilter(),
                  // _filterStore.suDungGiaFilter ? Observer(
                  //   builder: (context){
                  //     return RangeSlider(
                  //       values: _filterStore.seletedRange,
                  //       labels: RangeLabels(
                  //         _filterStore.seletedRange.start.toString(),
                  //         _filterStore.seletedRange.end.toString(),
                  //       ),
                  //       onChanged: (RangeValues newRange){
                  //         setState(() {
                  //           _filterStore.seletedRange = newRange;
                  //           _giaMinValueController.text=_filterStore.seletedRange.start.toString();
                  //           _giaMaxValueController.text=_filterStore.seletedRange.end.toString();
                  //         });
                  //       },
                  //       min: 0,
                  //       max: 20000,
                  //       activeColor: Colors.blue[900],
                  //       inactiveColor: Colors.grey[300],
                  //
                  //     );
                  //   })
                  //   :Container(width: 0,height: 0,),

                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       r"$70k",
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //       ),
                  //     ),
                  //     Text(
                  //       r"$1000k",
                  //       style: TextStyle(
                  //         fontSize: 14,
                  //       ),
                  //     )
                  //   ],
                  // ),
                  buiDienTichFilter(),
                  buildDiaChiFilter(),
                  buildUsernameFilter(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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

  Widget buildLoaiBaiDang(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Loại bài",
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
                      width: 160,
                      height: 60,
                      child: Observer(
                        builder: (context){
                          return DropdownButton<String>(
                            isExpanded: true,
                            value: _filterStore.loaiBaiDangDropDownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                                _filterStore.loaiBaiDangDropDownValue = newValue;
                            },
                            items: <String>['Bất kì', 'Cho thuê', 'Bán']
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

  Widget buildGiaFilter(){
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Giá tiền",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(width: 12,),
          Observer(
            builder: (context){
              return Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _filterStore.suDungGiaFilter ? SizedBox(
                        width: 75,
                        child: TextField(
                          focusNode: _minGiaFocus,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context).nextFocus(),
                          keyboardType: TextInputType.number,
                          controller: _giaMinValueController,
                          onChanged: (value){
                            _filterStore.setGiaMin(value);
                            // _filterStore.setMinGiaSlider(double.parse(value),value.isEmpty);
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "Min",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[400]),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[400]),
                            ),
                            border:  UnderlineInputBorder(
                                borderSide:  BorderSide(color: Colors.black)
                            ),
                          ),
                        ),
                      )
                          : Container(width: 0,height: 0,),
                      _filterStore.suDungGiaFilter ? Text("-",style: TextStyle(fontSize: 18),): Container(width: 0,height: 0,),
                      _filterStore.suDungGiaFilter ? SizedBox(
                        width: 75,
                        child: TextField(
                          autofocus: false,

                          textInputAction: TextInputAction.done,
                          onSubmitted: (_) => FocusScope.of(context).unfocus(),
                          keyboardType: TextInputType.number,
                          controller: _giaMaxValueController,
                          onChanged: (value){
                            _filterStore.setGiaMax(value);
                          },
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          decoration: InputDecoration(
                            hintText: "Max",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[400],
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[400]),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange[400]),
                            ),
                            border:  UnderlineInputBorder(
                                borderSide:  BorderSide(color: Colors.black)
                            ),
                          ),
                        ),
                      ): Container(width: 0,height: 0,),
                      SizedBox(width: 6,),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: SizedBox(
                          width: 75,
                          height: 60,
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _filterStore.giaDropDownValue,
                            icon: const Icon(Icons.arrow_downward),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.black),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              _filterStore.giaDropDownValue = newValue;
                            },
                            items: <String>['Bất kì', 'triệu', 'tỷ']
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
                          ),
                        ),
                      ),
                    ],
                  )
              );
            },

          ),
        ],
      ),
    );
  }
  Widget buiDienTichFilter(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Diện tích",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Observer(
            builder: (context)
            {
              return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _filterStore.suDungDienTichFilter ? SizedBox(
                      width: 75,
                      child: TextField(
                        focusNode: _minDienTichFocus,
                        textInputAction: TextInputAction.next,
                        onEditingComplete: () => FocusScope.of(context).nextFocus(),
                        keyboardType: TextInputType.number,
                        controller: _dienTichMinValueController,
                        onChanged: (value){
                          _filterStore.setDienTichMin(value);
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Min",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[400]),
                          ),
                          border:  UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black)
                          ),
                        ),
                      ),
                    ) : Container(width: 0,height: 0,),
                    _filterStore.suDungDienTichFilter ? Text("-",style: TextStyle(fontSize: 18),): Container(width: 0,height: 0,),
                    _filterStore.suDungDienTichFilter ? SizedBox(
                      width: 75,
                      child: TextField(
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => FocusScope.of(context).unfocus(),
                        keyboardType: TextInputType.number,
                        autofocus: false,
                        controller: _dienTichMaxValueController,
                        onChanged: (value){
                          _filterStore.setDienTichMax(value);
                        },
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                        decoration: InputDecoration(
                          hintText: "Max",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[400],
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red[400]),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange[400]),
                          ),
                          border:  UnderlineInputBorder(
                              borderSide:  BorderSide(color: Colors.black)
                          ),
                        ),
                      ),
                    ): Container(width: 0,height: 0,),
                    SizedBox(width: 6,),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: SizedBox(
                        width: 75,
                        height: 60,
                        child: DropdownButton<String>(
                          isExpanded: true,
                          value: _filterStore.dienTichDropDownValue,
                          icon: const Icon(Icons.arrow_downward),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black),
                          underline: Container(
                            height: 2,
                            color: Colors.black,
                          ),
                          onChanged: (String newValue) {
                              _filterStore.dienTichDropDownValue = newValue;
                          },
                          items: <String>['Bất kì', 'm2']
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
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ),
    );
  }
  Widget buildDiaChiFilter(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Địa chỉ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextField(
              autofocus: false,
              keyboardType: TextInputType.text,
              controller: _diaChiController,
              onChanged: (value){
                _filterStore.setDiaChiContent(value);
                // _filterStore.setMinGiaSlider(double.parse(value),value.isEmpty);
              },
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Địa chỉ bất kì",
                suffixIcon: IconButton(
                  onPressed: () => _diaChiController.clear(),
                  icon: Icon(Icons.clear),
                ),
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border:  UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildUsernameFilter(){
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 110,
            child: Text("Username",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
              textAlign: TextAlign.start,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Expanded(
            child: TextField(
              autofocus: false,
              keyboardType: TextInputType.text,
              controller: _usernameController,
              onChanged: (value){
                _filterStore.setUsernameContent(value);
              },
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                hintText: "Username",
                suffixIcon: IconButton(
                  onPressed: () => _usernameController.clear(),
                  icon: Icon(Icons.clear),
                ),
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[400],
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red[400]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange[400]),
                ),
                border:  UnderlineInputBorder(
                    borderSide:  BorderSide(color: Colors.black)
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildApplyButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: RoundedButtonWidget(
        buttonText: "Sử dụng bộ lọc",
        textSize: 20,
        buttonColor: Colors.amber,
        textColor: Colors.white,
        onPressed: (){
          Navigator.pop(context, _filterStore.validateSearchContent());
        },
      ),
    );
  }

  Widget buildClearButton(){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: RoundedButtonWidget(
        buttonText: "Đặt lại giá trị",
        textSize: 20,
        buttonColor: Colors.amber,
        textColor: Colors.white,
        onPressed: (){
          if (_filterStore.suDungDienTichFilter){
            _dienTichMinValueController.clear();
            _dienTichMaxValueController.clear();
          }
          if (_filterStore.suDungGiaFilter){
            _giaMaxValueController.clear();
            _giaMinValueController.clear();
          }
          _diaChiController.clear();
          _usernameController.clear();
          _filterStore.resetValue();
        },
      ),
    );
  }
  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    _giaMinValueController.dispose();
    _giaMaxValueController.dispose();
    _dienTichMaxValueController.dispose();
    _dienTichMinValueController.dispose();
    _diaChiController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
