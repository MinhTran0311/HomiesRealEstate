import 'package:boilerplate/constants/font_family.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';



class ReportPage extends StatefulWidget {
  ReportPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage>{
  bool showAvg = false;

  List<Color> gradientColors = [
    Colors.yellow,
    Colors.orange,
  ];

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Color(0xfff3af00), rankKey: 'Q2'),
        new CircularSegmentEntry(1800.0, Color(0xffec3337), rankKey: 'Q3'),
        new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
      ],
      rankKey: 'Báo cáo thống kê',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
        border: Border.all(color: Colors.white,width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            spreadRadius: 5,
            blurRadius: 0,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text("Thống kê",style: TextStyle(fontFamily: FontFamily.roboto,fontWeight: FontWeight.bold,fontSize: 24),),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1.70,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(18),
                        ),
                        color: Color(0xff232d37)),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0, left: 12.0, top: 24, bottom: 12),
                      child: LineChart(
                        showAvg ? avgData() : mainData(),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 34,
                  child: FlatButton(
                    onPressed: () {
                      setState(() {
                        showAvg = !showAvg;
                      });
                    },
                    child: Text(
                      'avg',
                      style: TextStyle(
                          fontSize: 12, color: showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Material myCircularItems(String title, String subtitle){
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child:Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment:MainAxisAlignment.center,
            children: <Widget>[
              // FlatButton(onPressed: null, child: Icon(Icons.arrow_back)),
              Column(
                mainAxisAlignment:MainAxisAlignment.center,
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(title,style:TextStyle(
                      fontSize: 20.0,
                      color: Colors.blueAccent,
                    ),),
                  ),

                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:Text(subtitle,style:TextStyle(
                      fontSize: 30.0,
                    ),),
                  ),

                  Padding(
                    padding:EdgeInsets.all(8.0),
                    child:AnimatedCircularChart(
                      size: const Size(100.0, 100.0),
                      initialChartData: circularData,
                      chartType: CircularChartType.Pie,
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(color: Color(0xff68737d), fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      lineTouchData: LineTouchData(enabled: false),
      gridData: FlGridData(
        show: true,
        drawHorizontalLine: true,
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color(0xff37434d),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          textStyle: TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3.44),
            FlSpot(2.6, 3.44),
            FlSpot(4.9, 3.44),
            FlSpot(6.8, 3.44),
            FlSpot(8, 3.44),
            FlSpot(9.5, 3.44),
            FlSpot(11, 3.44),
          ],
          isCurved: true,
          colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1]).lerp(0.2).withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}

