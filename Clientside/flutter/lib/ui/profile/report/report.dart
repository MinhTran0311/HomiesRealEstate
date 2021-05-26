import 'package:boilerplate/constants/font_family.dart';
import 'package:boilerplate/stores/reportData/reportData_store.dart';
import 'package:boilerplate/widgets/progress_indicator_widget.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';



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
                child: Observer(builder: (context) {
                  return !_reportDataStore.loading? buildLineChart():CustomProgressIndicatorWidget();
                }
                )
              ),
              Center(
                child: Text("It's rainy here"),
              ),
              Center(
                child: Text("It's sunny here"),
              ),
            ],
          ),
        )


      ),
    );
  }
  Widget buildBarChart() {
    return null;
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
                  }),
              leftTitles: SideTitles(
                showTitles: true,
                getTitles: (value) {
                  return '\$ ${value}';
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
    ):Container();
    }
    );
  }

}

