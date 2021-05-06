import 'package:flutter_charts/flutter_charts.dart' hide Container;

import '../../../providers/chart_line_provider.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyLineChart extends StatefulWidget {
  @override
  _MyLineChartState createState() => _MyLineChartState();
}

class _MyLineChartState extends State<MyLineChart> {
  @override
  Widget build(BuildContext context) {
    final chartLineProvider = context.read<ChartLineProvider>();
    chartLineProvider.defineOptionsAndData();

    var lineChartContainer = LineChartContainer(
      chartData: chartLineProvider.chartData,
      chartOptions: chartLineProvider.lineChartOptions,
      xContainerLabelLayoutStrategy:
          chartLineProvider.xContainerLabelLayoutStrategy,
    );

    var lineChart = LineChart(
      painter: LineChartPainter(lineChartContainer: lineChartContainer),
      container: lineChartContainer,
    );

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10),

          ///ElevatedButton(onPressed: () {}, child: Text('data')), [rows here]
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: lineChart),
              ],
            ),
          ),
          SizedBox(height: 10)
        ],
      ),
    );
  }
}
