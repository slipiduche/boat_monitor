import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:boat_monitor/models/historics_model.dart';

class LineChartTemp extends StatefulWidget {
  Historics historics;
  LineChartTemp(this.historics);
  @override
  _LineChartTempState createState() => _LineChartTempState(historics);
}

class _LineChartTempState extends State<LineChartTemp> {
  int samples = 1;
  Historics historics;
  List<double> xData, yData;
  List<FlSpot> spots;
  _LineChartTempState(this.historics);
  List<Color> gradientColors = [
    Colors.blueAccent,
    Colors.blue,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    xData = [];
    yData = [];
    spots = [];
    if (historics != null) {
      samples = historics.historics.length;
      historics.historics.forEach((element) {
        xData.add(element.dt.hour.toDouble());
        yData.add(element.temp.toDouble());
        //spots.add(FlSpot(, y));
      });
      for (var i = 0; i < samples; i++) {
        spots.add(FlSpot((i).toDouble(), yData[i]));
      }
    }
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.5,
          child: Container(
            decoration: const BoxDecoration(
                // borderRadius: BorderRadius.all(
                //   Radius.circular(18),
                // ),
                color: Colors.white10),
            child: LineChart(
              showAvg ? avgData() : mainData(),
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
                  fontSize: 12,
                  color:
                      showAvg ? Colors.white.withOpacity(0.5) : Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          if (value == 40.0 ||
              value == 20.0 ||
              value == 0.0 ||
              value == -20.0) {
            return FlLine(
              color: Colors.blueAccent,
              strokeWidth: 1,
            );
          } else {
            return FlLine(strokeWidth: 0.0);
          }
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
          showTitles: false,
          reservedSize: 20,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '12:00';
              case 5:
                return '15:00';
              case 8:
                return '18:00';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case -20:
                return '-20';
              case 0:
                return '0';
              case 20:
                return '20';
              case 40:
                return '40';
            }
            return '';
          },
          reservedSize: 25,
          margin: 5,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: Colors.blueAccent, width: 1.0)),
      minX: 0,
      maxX: samples.toDouble() - 1,
      minY: -30,
      maxY: 50,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          colors: gradientColors,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors:
                gradientColors.map((color) => color.withOpacity(0.3)).toList(),
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
            color: Colors.blueAccent,
            strokeWidth: 1,
          );
        },
        getDrawingHorizontalLine: (value) {
          if (value == 40.0 ||
              value == 20.0 ||
              value == 0.0 ||
              value == -20.0) {
            return FlLine(
              color: Colors.blueAccent,
              strokeWidth: 1,
            );
          } else {
            return FlLine(strokeWidth: 0.0);
          }
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 16),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return '12:00';
              case 5:
                return '15:00';
              case 8:
                return '16:00';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '800Kg';
              case 3:
                return '500Kg';
              case 5:
                return '200Kg';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.blueAccent, width: 1)),
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
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2),
          ],
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(show: true, colors: [
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
            ColorTween(begin: gradientColors[0], end: gradientColors[1])
                .lerp(0.2)
                .withOpacity(0.1),
          ]),
        ),
      ],
    );
  }
}
