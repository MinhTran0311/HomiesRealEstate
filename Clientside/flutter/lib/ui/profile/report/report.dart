import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/models/report/ListReport.dart';
import 'package:boilerplate/stores/reportData/reportData_store.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _reportDataStore = Provider.of<ReportDataStore>(context);

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
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
              onPressed: (){setState(() {
                Navigator.pop(context);
              });}),
          centerTitle: true,
          title: Text("Thống kê",style: TextStyle(color: Colors.white),),
          bottom:  TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.stacked_line_chart,color: Colors.white,),
              ),
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
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.grey[200],
          child: TabBarView(
            children: <Widget>[
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Text("Thống kê",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                      SizedBox(height: 10,),
                      Observer(builder: (context) {
                        return !_reportDataStore.loading? Card(color: Colors.grey[200], child: SizedBox(width: double.infinity,height: 400, child:StackedAreaLineChart())):CustomProgressIndicatorWidget();
                      }
                      ),
                    ],
                  ),
                )
              ),
              Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        Text("Thống kê",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                        SizedBox(height: 10,),
                        Observer(builder: (context) {
                          return !_reportDataStore.loading? Card(color: Colors.grey[200], child: SizedBox(width: double.infinity,height: 400, child: HorizontalPatternForwardHatchBarChart())):CustomProgressIndicatorWidget();
                        }
                        ),
                      ],
                    ),
                  )
              ),
              Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Observer(builder: (context) {
                          return !_reportDataStore.loading? buildPieChart():CustomProgressIndicatorWidget();
                        }
                        ),
                      ],
                    ),
                  )
              ),
            ],
          ),
        )


      ),
    );
  }
  Widget buildPieChart(){

    return Observer(builder: (context){
      return _reportDataStore.listitemReports!=null?Container(
        child: AspectRatio(
          aspectRatio: 1.3,
          child: Card(
            color: Colors.white,
            child: Row(
              children: <Widget>[
                const SizedBox(
                  height: 18,
                ),
                Expanded(
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
                          sections: showingSections()),
                      ),
                    ),
                  ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[

                  ],
                ),
                const SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ),
      ):Container(child: Text("Không có dữ liệu"),);
    },
  );
  }
  List<PieChartSectionData> showingSections() {
    double sumTienNap=0,sumTienChi=0,sumBaiDang=0;
    for(int i=0,ii=11;i<ii;i++){
      sumTienNap+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienNap;
      sumTienChi+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soTienChi;
      sumBaiDang+=_reportDataStore.listitemReports.listitemReports[0].listyearReports[i].soBaiDang;
    }
    return List.generate(4, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: const Color(0xff0293ee),
            value: 40,
            title: '40%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xfff8b250),
            value: 30,
            title: '30%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 2:
          return PieChartSectionData(
            color: const Color(0xff845bef),
            value: 15,
            title: '15%',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 3:
          return PieChartSectionData(
            color: const Color(0xff13d38e),
            value: 15,
            title: '15%',
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
    return new charts.LineChart(
      _createLineChartData(_reportDataStore.listitemReports),
      animate: true,
      animationDuration: Duration(seconds: 2),
      defaultRenderer:
      new charts.LineRendererConfig(includeArea: true, stacked: true),
    );
  }

  Widget HorizontalPatternForwardHatchBarChart(){
    return new charts.BarChart(
      _createBarChartData(_reportDataStore.listitemReports),
      animate: true,
      animationDuration: Duration(seconds: 2),
      barGroupingType: charts.BarGroupingType.grouped,
      vertical: false,
    );
  }


  /// Create series list with multiple series
  static List<charts.Series<LinearSales, int>> _createLineChartData(listitemReport l) {
    List<LinearSales> soBaiDang=[],soTienNap=[],soTienChi=[];
    if (l != null) {
      for(int i=0,ii=12;i<ii;i++){
        soBaiDang.add(new LinearSales(i+1, l.listitemReports[0].listyearReports[i].soBaiDang),);
        soTienNap.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
        soTienChi.add(new LinearSales(i+1, (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
      }
    }
    return [
      new charts.Series<LinearSales, int>(
        id: 'soBaiDang',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soBaiDang,
      ),
      new charts.Series<LinearSales, int>(
        id: 'soTienChi',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soTienChi,
      ),
      new charts.Series<LinearSales, int>(
        id: 'soTienNap',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: soTienNap,
      ),

    ];
  }


  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createBarChartData(listitemReport l) {
    List<OrdinalSales> soBaiDang=[],soTienNap=[],soTienChi=[];
    if (l != null) {
      for(int i=0,ii=12;i<ii;i++){
        soBaiDang.add(new OrdinalSales(ThangInttoString(i), l.listitemReports[0].listyearReports[i].soBaiDang),);
        soTienNap.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienNap).toInt()));
        soTienChi.add(new OrdinalSales(ThangInttoString(i), (l.listitemReports[0].listyearReports[i].soTienChi).toInt()));
      }
    }
    return [
      new charts.Series<OrdinalSales, String>(
        id: 'soBaiDang',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: soBaiDang,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'soTienChi',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: soTienChi,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'soTienNap',
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
