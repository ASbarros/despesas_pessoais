import 'package:financas_pessoais/models/chart_pie_data_model.dart';
import 'package:financas_pessoais/repositorys/chart_pie_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'indicator.dart';

class PieChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChartPageState();
}

class PieChartPageState extends State<PieChartPage> {
  int touchedIndex;
  final _repository = ChartPieRepository();
  List<ChartPieDataModel> _data = [];
  final _colors = [
    Colors.blue,
    Colors.yellow[800],
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.black
  ];

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final data = await _repository.data();
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Card(
        color: Colors.grey[300],
        elevation: 5,
        child: _data.isNotEmpty
            ? Row(
                children: <Widget>[
                  const SizedBox(height: 18),
                  Expanded(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: PieChart(
                        PieChartData(
                            pieTouchData:
                                PieTouchData(touchCallback: (pieTouchResponse) {
                              setState(() {
                                if (pieTouchResponse.touchInput
                                        is FlLongPressEnd ||
                                    pieTouchResponse.touchInput is FlPanEnd) {
                                  touchedIndex = -1;
                                } else {
                                  touchedIndex =
                                      pieTouchResponse.touchedSectionIndex;
                                }
                              });
                            }),
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 1,
                            centerSpaceRadius: 30,
                            sections: showingSections()),
                      ),
                    ),
                  ),
                  Column(
                    // mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: showingCatalogSections(),
                  ),
                  const SizedBox(width: 8),
                ],
              )
            : Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  List<Widget> showingCatalogSections() {
    final res = <Widget>[];
    for (var i = 0; i < _data.length; i++) {
      res.add(Indicator(
        color: _colors[i],
        text: _data[i].category,
        isSquare: true,
      ));
      res.add(SizedBox(height: 5));
    }
    return res;
  }

  List<PieChartSectionData> showingSections() {
    final res = <PieChartSectionData>[];
    final total = _data.fold(
        0.0, (previousValue, element) => previousValue += element.totalValue);
    for (var i = 0; i < _data.length; i++) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      res.add(PieChartSectionData(
        color: _colors[i],
        value: _data[i].totalValue,
        title: '${((100 * _data[i].totalValue) / total).toStringAsFixed(2)}%',
        badgeWidget: Text('R\$ ${_data[i].totalValue.toStringAsFixed(2)}'),
        badgePositionPercentageOffset: 1.4,
        radius: radius,
        titleStyle: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: const Color(0xffffffff)),
      ));
    }

    return res;
  }
}
