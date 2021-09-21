import 'package:boat_monitor/models/historics_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class LineChartBasic extends StatefulWidget {
  Historics historics;
  LineChartBasic(this.historics);
  @override
  _LineChartBasicState createState() => _LineChartBasicState(historics);
}

class _LineChartBasicState extends State<LineChartBasic> {
  int samples = 1;
  Historics historics;
  _LineChartBasicState(this.historics);
  List<Color> gradientColors = [
    Colors.blueAccent,
    Colors.blue,
  ];
  List<double> xData, yData;
  List<FlSpot> spots;
  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    xData = [];
    yData = [];
    spots = [];

    if (historics != null) {
      samples = historics.historics.length;
      print(samples);
      for (var i = 0; i < samples; i++) {
        xData.add(historics.historics[i].dt.hour.toDouble());
        print(
            'dt:${historics.historics[i].dt} id:${historics.historics[i].id}x:${historics.historics[i].dt.hour.toDouble()}:${historics.historics[i].dt.minute.toDouble()} y:+${historics.historics[i].contWeight.toDouble()}');
        yData.add(historics.historics[i].contWeight.toDouble());
      }

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
              mainData(historics),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData(Historics historics) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
            maxContentWidth: 40,
            tooltipBgColor: Colors.white,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((LineBarSpot touchedSpot) {
                final textStyle = TextStyle(
                  color: touchedSpot.bar.colors[0],
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                );
                return LineTooltipItem(
                    '${historics.historics[touchedSpot.spotIndex].dt.toString().substring(0, historics.historics[touchedSpot.spotIndex].dt.toString().length - 8)}, ${touchedSpot.y.toStringAsFixed(2)}',
                    textStyle);
              }).toList();
            }),
        handleBuiltInTouches: true,
        getTouchLineStart: (data, index) => 0,
      ),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          if (value == 100.0 ||
              value == 500.0 ||
              value == 300.0 ||
              value == 700.0 ||
              value == 900.0) {
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
          showTitles: true,
          reservedSize: 20,
          getTextStyles: (value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 12),
          getTitles: (value) {
            print('value:$value');
            print(historics.historics[value.toInt()].dt);
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
              case 100:
                return '100';
              case 300:
                return '300';
              case 500:
                return '500';
              case 700:
                return '700';
              case 900:
                return '900';
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
      minY: 0,
      maxY: 1000,
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
}
