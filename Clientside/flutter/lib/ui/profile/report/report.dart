import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/converter/local_converter.dart';
import 'package:boilerplate/models/report/ListReport.dart';
import 'package:boilerplate/stores/reportData/reportData_store.dart';
import 'package:boilerplate/stores/theme/theme_store.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
class ReportPage extends StatefulWidget {
  ReportPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{
  bool showAvg = false;
  ReportDataStore _reportDataStore;
  String dropdownValue = 'Tất cả';
  ThemeStore _themeStore;
  List<String> type = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reportDataStore = Provider.of<ReportDataStore>(context);
    _themeStore = Provider.of<ThemeStore>(context);

    if (!_reportDataStore.loading) {
      _reportDataStore.getReportData();
    }

  }
  List<Color> gradientColors = [
    Colors.yellow,
    Colors.orange,
  ];
  final Color dark = const Color(0xff3b8c75);
  final Color normal = const Color(0xff64caad);
  final Color light = const Color(0xff73e8c9);
  int touchedIndex = -1;
  @override
  Widget build(BuildContext context) {
    Size size =  MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Thống kê",),
          bottom:  TabBar(
            tabs: <Widget>[
              // Tab(
              //   icon: Icon(Icons.stacked_line_chart,color: Colors.white,),
              // ),
              Tab(
                icon: Icon(Icons.bar_chart,color: Colors.white,),
              ),
              Tab(
                icon: Icon(Icons.pie_chart,color: Colors.white,),
              ),
            ],
          ),
        ),
        body:
        TabBarView(
          children: <Widget>[
            // Center(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: [
            //         // SizedBox(height: 10,),
            //         // Text("Thống kê",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
            //         SizedBox(height: 10,),
            //         Stack(
            //           children: [
            //             Align(
            //               alignment: Alignment.topCenter,
            //               child: Text("Thống kê Tổng ${dropdownValue}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
            //             ),
            //             Align(
            //               alignment: Alignment.topLeft,
            //               child: Padding(
            //                 padding: const EdgeInsets.only(top: 10),
            //                 child: DropdownButton<String>(
            //                   value: dropdownValue,
            //                   icon: const Icon(Icons.arrow_drop_down),
            //                   iconSize: 24,
            //                   elevation: 16,
            //                   style:  TextStyle(color: this._themeStore.darkMode ==true? Colors.white: Color.fromRGBO(18, 22, 28, 1),),
            //                   underline: Container(
            //                     height: 2,
            //                     color: Colors.black,
            //                   ),
            //                   onChanged: (String newValue) {
            //                     setState(() {
            //                       dropdownValue = newValue;
            //                     });
            //                   },
            //                   items: <String>['Tất cả','Số bài đăng', 'Số tiền nạp', 'Số tiền thanh toán']
            //                       .map<DropdownMenuItem<String>>((String value) {
            //                     return DropdownMenuItem<String>(
            //                       value: value,
            //                       child: Text(value),
            //                     );
            //                   }).toList(),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //         Observer(builder: (context) {
            //           return !_reportDataStore.loading? Card(
            //               color: Colors.grey[200],
            //               child: SizedBox(
            //                   width: 400,
            //                   height: 400,
            //                   child:ListView(
            //                     physics: BouncingScrollPhysics(),
            //                     scrollDirection: Axis.horizontal,
            //                     shrinkWrap: true,
            //                     children:<Widget>[
            //                       StackedAreaLineChart()
            //                     ] ,
            //                   )
            //
            //               )
            //           )
            //               :CustomProgressIndicatorWidget();
            //         }
            //         ),
            //       ],
            //     ),
            //   )
            // ),
            Container(
              width: size.width,
              height: size.height,
              child: Wrap(
                children: [
                  SizedBox(height: 10,),
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text("Thống kê Tổng ${dropdownValue}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,),),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style:  TextStyle(color: _themeStore.darkMode==true? Colors.white: Color.fromRGBO(18, 22, 28, 1),),
                            underline: Container(
                              height: 2,
                              color: Colors.black,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Tất cả','Số bài đăng', 'Số tiền nạp', 'Số tiền thanh toán']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Text("Thống kê",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                  // SizedBox(height: 10,),
                  Observer(builder: (context) {
                    return _reportDataStore.listitemReports !=null?
                    Card(
                        color: Colors.grey[200],
                        child:
                        SizedBox(
                            width: size.width,
                            height: size.height*0.58,
                            child:ListView(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              children:<Widget>[
                                HorizontalPatternForwardHatchBarChart()
                              ] ,
                            )
                            )
                    ):Container(child: Center(child: Text("Không có dữ liệu"),),);
                  }
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                  height: 400,
                  child: Wrap(
                    children: [
                      Observer(builder: (context) {
                        return _reportDataStore.listitemReports !=null? buildPieChart():CustomProgressIndicatorWidget();
                      }
                      ),
                    ],
                  )
              ),
            ),
          ],
        )


      ),
    );
  }
  Widget buildPieChart(){
    double sumTienNap=0,sumTienChi=0,sumBaiDang=0;double sum=0;
    for(int i=0,ii=11;i<ii;i++){
      sumTienNap+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienNap;
      sumTienChi+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienChi;
      sumBaiDang+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soBaiDang;
    }
    sum = sumTienChi+sumTienNap;
    double nap =double.parse ((sumTienNap/(sum)*100).toStringAsFixed(2));
    double chi = double.parse((100-nap).toStringAsFixed(2));
    return Observer(builder: (context){
      return _reportDataStore.listitemReports!=null?Container(
        height: 360,
        child: Stack(
          children: [

            Align(
              alignment: Alignment.topCenter,
              child: Card(
                color: _themeStore.darkMode !=true? Colors.white: Color.fromRGBO(30, 32, 38, 1),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  width: double.infinity,
                  height: 240,
                  child: Stack(
                    children: <Widget>[
                      Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                              width: double.infinity,
                              height: 40,
                              padding:const EdgeInsets.only(top: 10),
                              child: Center(
                                  child:
                                  Text(
                                    "Thống kê dòng tiền",
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  )
                              )
                          )
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: 200,
                          height: 200,
                          child: Expanded(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: PieChart(
                                PieChartData(
                                  pieTouchData: PieTouchData(touchCallback: (pieTouchResponse){
                                    setState(() {
                                      final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent &&
                                          pieTouchResponse.touchInput is! PointerUpEvent;
                                      if (desiredTouch && pieTouchResponse.touchedSection != null) {
                                        touchedIndex = pieTouchResponse.touchedSectionIndex;
                                      } else {
                                        touchedIndex = -1;
                                      }
                                    });
                                  }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(nap,chi)),
                                ),
                              ),
                            ),
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:  <Widget>[
                            Row(
                              children: [
                                SizedBox(width: 20,height: 20, child: CircleAvatar(backgroundColor: Color(0xfff8b250),)),
                                Text(" Đã thanh toán",style: TextStyle(fontSize: 18 ))
                              ],
                            ),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                SizedBox(width: 20,height: 20, child: CircleAvatar(backgroundColor: Color(0xff0293ee),)),
                                Text(" Đã nạp",style: TextStyle(fontSize: 18))
                              ],
                            )
                            // Text("Đã nạp: ${priceFormat(sumTienNap)}",style: TextStyle(fontSize: 18,),),
                            // Text("Đã thanh toán: ${priceFormat(sumTienChi)}",style: TextStyle(fontSize: 18,),),
                            // Text("Tổng: ${priceFormat(sum)}",style: TextStyle(fontSize: 18,),),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            Align(
              alignment: Alignment.bottomCenter,
              child: Card(
                color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(30, 32, 38, 1),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child:   Container(
                  width: double.infinity,
                  height: 100,
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Đã nạp",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text("Đã thanh toán",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text("Tổng lượng tiền giao dịch",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text("${priceFormat(sumTienNap)}",style: TextStyle(fontSize: 18,),),
                      ),
                      Align(
                        alignment: Alignment.topRight,
                        child: Text("${priceFormat(sumTienChi)}",style: TextStyle(fontSize: 18,),),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text("${priceFormat(sum)}",style: TextStyle(fontSize: 18,),),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ):Container(child: Text("Không có dữ liệu"),);
    },
  );
  }

  List<PieChartSectionData> showingSections(double nap,double chi) {

    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: nap,
            title: '${nap}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: chi,
            title: '${chi}%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 0,
            title: ' ',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 0,
            title: ' ',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          throw Error();
      }
    });
  }
  Widget buildBarChart() {
    return Observer(builder: (context) {
        return _reportDataStore.listitemReports!=null? AspectRatio(
          aspectRatio: 1.66,
          child: Card(
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                child: SizedBox(
                  height: 400,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.center,
                      barTouchData: BarTouchData(
                        enabled: false,
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        bottomTitles: SideTitles(
                          showTitles: true,
                          textStyle:   TextStyle(color: Color(0xff939393), fontSize: 10),
                          margin: 10,
                          getTitles: (double value) {
                            switch (value.toInt()) {
                              case 0:
                                return 'Jan\n2021';
                              case 1:
                                return 'Feb\n2021';
                              case 2:
                                return 'Mar\n2021';
                              case 3:
                                return 'Apr\n2021';
                              case 4:
                                return 'May\n2021';
                              case 5:
                                return 'Jun\n2020';
                              case 6:
                                return 'Jul\n2020';
                              case 7:
                                return 'Aug\n2020';
                              case 8:
                                return 'Sep\n2020';
                              case 9:
                                return 'Oct\n2020';
                              case 10:
                                return 'Nov\n2020';
                              case 11:
                                return 'Dec\n2020';
                              default:
                                return '';
                            }
                          },
                        ),
                        leftTitles: SideTitles(
                          showTitles: true,
                          textStyle:   TextStyle(
                              color: Color(
                                0xff939393,
                              ),
                              fontSize: 10),
                          margin: 0,
                        ),
                      ),
                      gridData: FlGridData(
                        show: true,
                        checkToShowHorizontalLine: (value) => value % 10 == 0,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: const Color(0xffe7e8ec),
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      groupsSpace: 4,
                      barGroups: getData(),
                    ),
                  ),
                )
          )
        )
        ):Container(child: Text("Không có dữ liệu"));
      }
    );
  }
  List<BarChartGroupData> getData() {
    List<BarChartGroupData> list =[];
    if(_reportDataStore.listitemReports!=null)
      for(int i=0,ii=12;i<ii;i++){
        list.add(BarChartGroupData(
            x: i,
            barsSpace: 4,
            barRods: [
              BarChartRodData(
                  y:  _reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soBaiDang.toDouble(),
                  rodStackItem: [
                    BarChartRodStackItem(0, _reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soBaiDang.toDouble(), dark),
                    BarChartRodStackItem(0, _reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienNap.toDouble()/1000000, normal),
                    BarChartRodStackItem(0, _reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienChi.toDouble()/1000000, light),
                  ]
              )
            ]
        ));
      }
    return list;
  }
  Widget buildLineChart() {
    List<FlSpot> listBaiDang=[];
    List<FlSpot> listSoTienNap=[];
    List<FlSpot> listSoTienChi=[];
    print("DuongLx: ${_reportDataStore.listitemReports.listitemReports.length}");
    if(_reportDataStore.listitemReports!=null)
    for(int i=0,ii=12;i<ii;i++){
      listBaiDang.add(FlSpot(i.toDouble(),_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soBaiDang.toDouble()));
      listSoTienNap.add(FlSpot(i.toDouble(),_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienNap.toDouble()/1000000));
      listSoTienChi.add(FlSpot(i.toDouble(),_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienChi.toDouble()/1000000));
    }
    return Observer(builder: (context) {
      return _reportDataStore.listitemReports!=null? Container(
      child: SizedBox(
        width: 350,
        height: 400,
        child:LineChart(
          LineChartData(
            lineTouchData: LineTouchData(enabled: false),
            lineBarsData: [
              LineChartBarData(
                spots:listSoTienNap,
                isCurved: true,
                barWidth: 2,
                colors: [
                  Colors.green,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: listBaiDang,
                isCurved: true,
                barWidth: 2,
                colors: [
                  Colors.black,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
              LineChartBarData(
                spots: listSoTienChi,
                isCurved: false,
                barWidth: 2,
                colors: [
                  Colors.red,
                ],
                dotData: FlDotData(
                  show: false,
                ),
              ),
            ],
            betweenBarsData: [
              BetweenBarsData(
                fromIndex: 0,
                toIndex: 2,
                colors: [Colors.red.withOpacity(0.3)],
              )
            ],
            minY: 0,
            titlesData: FlTitlesData(
              bottomTitles: SideTitles(
                  showTitles: true,
                  textStyle: TextStyle(
                      fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
                  getTitles: (value) {
                    switch (value.toInt()) {
                      case 0:
                        return 'Jan\n2021';
                      case 1:
                        return 'Feb\n2021';
                      case 2:
                        return 'Mar\n2021';
                      case 3:
                        return 'Apr\n2021';
                      case 4:
                        return 'May\n2021';
                      case 5:
                        return 'Jun\n2020';
                      case 6:
                        return 'Jul\n2020';
                      case 7:
                        return 'Aug\n2020';
                      case 8:
                        return 'Sep\n2020';
                      case 9:
                        return 'Oct\n2020';
                      case 10:
                        return 'Nov\n2020';
                      case 11:
                        return 'Dec\n2020';
                      default:
                        return '';
                    }
                  }),
              rightTitles:SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '${value}';
                },
              ),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '\$ ${value} Triệu';
                },
              ),
            ),
            gridData: FlGridData(
              show: true,
              checkToShowHorizontalLine: (double value) {
                return value == 1 || value == 6 || value == 4 || value == 5;
              },
            ),
          )
        )
      ),
    ):Container(child: Text("Không có dữ liệu"));
    }
    );
  }

  Widget StackedAreaLineChart(){
    return Container(
      width: 1000,
      color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(30, 32, 38, 1),
      child: new charts.LineChart(
        _createLineChartData(_reportDataStore.listitemReports,dropdownValue),
        animate: true,
        animationDuration: Duration(seconds: 2),
        defaultRenderer:
        new charts.LineRendererConfig(includeArea: true, stacked: true),
        behaviors: [new charts.SeriesLegend()],
      ),
    );
  }

  Widget HorizontalPatternForwardHatchBarChart(){
    return Container(
      width: 1000,
      color: _themeStore.darkMode!=true? Colors.white: Color.fromRGBO(30, 32, 38, 1),
      child: new charts.BarChart(
        _createBarChartData(_reportDataStore.listitemReports,dropdownValue),
        animate: true,
        animationDuration: Duration(seconds: 2),
        domainAxis: new charts.OrdinalAxisSpec(
            renderSpec: new charts.SmallTickRendererSpec(

              // Tick and Label styling here.
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 14, // size in Pts.
                    color: _themeStore.darkMode ==true ? charts.MaterialPalette.white: charts.MaterialPalette.black),

                // Change the line colors to match text color.
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),

        /// Assign a custom style for the measure axis.
        primaryMeasureAxis: new charts.NumericAxisSpec(
            renderSpec: new charts.GridlineRendererSpec(

              // Tick and Label styling here.
                labelStyle: new charts.TextStyleSpec(
                    fontSize: 14, // size in Pts.
                    color: _themeStore.darkMode ==true ? charts.MaterialPalette.white: charts.MaterialPalette.black),

                // Change the line colors to match text color.
                lineStyle: new charts.LineStyleSpec(
                    color: charts.MaterialPalette.black))),
        barGroupingType: charts.BarGroupingType.grouped,
        vertical: true,
        // Add the series legend behavior to the chart to turn on series legends.
        // By default the legend will display above the chart.
        behaviors: [new charts.SeriesLegend()],
      ),
    );
  }


  /// Create series list with multiple series
  static List<charts.Series<LinearSales, int>> _createLineChartData(listitemReport l,String dropdownValue) {
    List<LinearSales> soBaiDang=[],soTienNap=[],soTienChi=[];
    if (l != null) {

      for(int i=0,ii=12;i<ii;i++){
        if(dropdownValue == "Số bài đăng"){
          soBaiDang.add(new LinearSales(i+1, l.listitemReports[0].listyearReports[i].soBaiDang),);
          soTienNap.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienNap).toInt()*0));
          soTienChi.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienChi).toInt()*0));
        }
        else if(dropdownValue == "Số tiền nạp"){
          soBaiDang.add(new LinearSales(i+1, l.listitemReports[0].listyearReports[i].soBaiDang*0),);
          soTienNap.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
          soTienChi.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienChi).toInt()*0));
        }
        else if(dropdownValue == "Số tiền thanh toán"){
          soBaiDang.add(new LinearSales(i+1, l.listitemReports[0].listyearReports[i].soBaiDang*0),);
          soTienNap.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienNap).toInt()*0));
          soTienChi.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
        }
        else{
          soBaiDang.add(new LinearSales(i+1, l.listitemReports[0].listyearReports[i].soBaiDang),);
          soTienNap.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
          soTienChi.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
        }


      }
    }
    return [
      new charts.Series<LinearSales, int>(
        id: 'Số bài đăng',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soBaiDang,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Số tiền thanh toán',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soTienChi,
      ),
      new charts.Series<LinearSales, int>(
        id: 'Số tiền nạp',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soTienNap,
      ),

    ];
  }


  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createBarChartData(listitemReport l,String dropdownValue) {


    List<OrdinalSales> soBaiDang=[],soTienNap=[],soTienChi=[];
    if (l != null) {
      for(int i=0,ii=12;i<ii;i++){

        if(dropdownValue == "Số bài đăng"){
          soBaiDang.add(new OrdinalSales(ThangInttoString(i), l.listitemReports[0].listyearReports[i].soBaiDang),);
          soTienNap.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienNap).toInt()*0));
          soTienChi.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienChi).toInt()*0));
        }
        else if(dropdownValue == "Số tiền nạp"){
          soBaiDang.add(new OrdinalSales(ThangInttoString(i), l.listitemReports[0].listyearReports[i].soBaiDang*0),);
          soTienNap.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
          soTienChi.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienChi).toInt()*0));
        }
        else if(dropdownValue == "Số tiền thanh toán"){
          soBaiDang.add(new OrdinalSales(ThangInttoString(i), l.listitemReports[0].listyearReports[i].soBaiDang*0),);
          soTienNap.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienNap).toInt()*0));
          soTienChi.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
        }
        else{
          soBaiDang.add(new OrdinalSales(ThangInttoString(i), l.listitemReports[0].listyearReports[i].soBaiDang),);
          soTienNap.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
          soTienChi.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
        }

      }
    }
    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Số bài đăng',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: soBaiDang,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Số tiền thanh toán',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: soTienChi,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Sô tiền nạp',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: soTienNap,
        fillPatternFn: (OrdinalSales sales, _) =>
        charts.FillPatternType.forwardHatch,
      ),

    ];
  }
  static String ThangInttoString(int i){
    switch (i) {
      case 0:
        return 'Jan';
      case 1:
        return 'Feb';
      case 2:
        return 'Mar';
      case 3:
        return 'Apr';
      case 4:
        return 'May';
      case 5:
        return 'Jun';
      case 6:
        return 'Jul';
      case 7:
        return 'Aug';
      case 8:
        return 'Sep';
      case 9:
        return 'Oct';
      case 10:
        return 'Nov';
      case 11:
        return 'Dec';
      default:
        return '';
    }

  }
}
/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
