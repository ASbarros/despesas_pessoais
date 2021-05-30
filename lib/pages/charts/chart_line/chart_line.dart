import 'package:financas_pessoais/providers/chart_page_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../providers/chart_line_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChartLine2 extends StatefulWidget {
  @override
  _ChartLine2State createState() => _ChartLine2State();
}

class _ChartLine2State extends State<ChartLine2> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final chartLineProvider = context.read<ChartLineProvider>();
    final chartPageProvider = context.watch<ChartPageProvider>();
    return Center(
      child: AspectRatio(
        aspectRatio: 1.23,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 20),
                child: LineChart(
                  sampleData1(chartLineProvider, chartPageProvider.visible),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  LineChartData sampleData1(ChartLineProvider provider, bool visible) {
    return LineChartData(
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          tooltipBgColor: Colors.blueAccent,
          getTooltipItems: (List<LineBarSpot> touchedSpots) {
            return touchedSpots.map((barSpot) {
              final flSpot = barSpot;
              if (flSpot.x == 0) {
                return null;
              }
              return LineTooltipItem(
                '${provider.data[flSpot.barIndex].category}: ',
                const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: flSpot.y.toString(),
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
        handleBuiltInTouches: visible,
      ),
      gridData: FlGridData(show: true, horizontalInterval: 300),
      titlesData: FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          margin: 10,
          getTitles: provider.getMonth,
        ),
        leftTitles: SideTitles(
          interval: 300,
          showTitles: true,
          getTitles: visible ? provider.getTitles : (double _) => '',
          margin: 8,
          reservedSize: 30,
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(
            color: Color(0xff4e4965),
            width: 4,
          ),
          left: BorderSide(
            color: Colors.transparent,
          ),
          right: BorderSide(
            color: Colors.transparent,
          ),
          top: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      minX: 1,
      maxX: 5,
      maxY: provider.maxY,
      minY: 0,
      lineBarsData: provider.data
          .map((e) => LineChartBarData(
                spots: e.items
                    .map((i) => FlSpot(i.month.toDouble(),
                        double.parse(i.value.toStringAsFixed(2))))
                    .toList(),
                isCurved: true,
                show: true,
                barWidth: 4,
                colors: [provider.getColor(provider.data.indexOf(e))],
              ))
          .toList(),
    );
  }
}
