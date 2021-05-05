import 'package:financas_pessoais/providers/chart_pie_provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State<PieChartPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChartPieProvider>(builder: (_, chartPieProvider, __) {
      return AspectRatio(
        aspectRatio: 1.3,
        child: Card(
          color: Colors.grey[300],
          elevation: 5,
          child: chartPieProvider.data.isNotEmpty
              ? Row(
                  children: <Widget>[
                    const SizedBox(height: 18),
                    Expanded(
                      flex: 4,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: PieChart(
                          PieChartData(
                              pieTouchData: PieTouchData(
                                  touchCallback: (pieTouchResponse) {
                                final desiredTouch = pieTouchResponse.touchInput
                                        is! PointerExitEvent &&
                                    pieTouchResponse.touchInput
                                        is! PointerUpEvent;
                                if (desiredTouch &&
                                    pieTouchResponse.touchedSection != null) {
                                  chartPieProvider.touchedIndex =
                                      pieTouchResponse
                                          .touchedSection!.touchedSectionIndex;
                                } else {
                                  chartPieProvider.touchedIndex = -1;
                                }
                              }),
                              borderData: FlBorderData(show: false),
                              sectionsSpace: 1,
                              centerSpaceRadius: 30,
                              sections: chartPieProvider.showingSections()),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView(reverse: true, children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: chartPieProvider.showingCatalogSections(),
                        ),
                      ]),
                    ),
                    const SizedBox(width: 8),
                  ],
                )
              : Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      );
    });
  }
}
