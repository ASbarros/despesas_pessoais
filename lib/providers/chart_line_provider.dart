import 'package:financas_pessoais/models/chart_line_data_model.dart';
import 'package:financas_pessoais/repositorys/chart_line_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_charts/flutter_charts.dart';

class ChartLineProvider with ChangeNotifier {
  final _repository = ChartLineRepository();

  var data = <ChartLineDataModel>[];

  ChartLineProvider() {
    _init();
  }

  void _init() async {
    data = await _repository.data();
  }

  LineChartOptions lineChartOptions = LineChartOptions();

  /// Define options for vertical bar chart, if used in the demo
  ChartOptions _verticalBarChartOptions = VerticalBarChartOptions();

  /// Define Layout strategy go labels. todo-null-safety : this can be null here
  LabelLayoutStrategy xContainerLabelLayoutStrategy =
      DefaultIterativeLabelLayoutStrategy(
    options: VerticalBarChartOptions(),
  );

  /// Define data to be displayed
  ChartData chartData = RandomChartData(useUserProvidedYLabels: true);

  String getMonth([int month = 0]) {
    switch (month) {
      case 1:
        return 'JAR';
      case 2:
        return 'FER';
      case 3:
        return 'MAR';
      case 4:
        return 'ABR';
      case 5:
        return 'MAI';
      case 6:
        return 'JUN';
      case 7:
        return 'JUL';
      case 8:
        return 'AGO';
      case 9:
        return 'SET';
      case 10:
        return 'OUT';
      case 11:
        return 'NOV';
      case 12:
        return 'DEZ';

      default:
        return '';
    }
  }

  void defineOptionsAndData() {
    lineChartOptions = LineChartOptions();
    _verticalBarChartOptions = VerticalBarChartOptions();
    xContainerLabelLayoutStrategy = DefaultIterativeLabelLayoutStrategy(
      options: _verticalBarChartOptions,
    );
    chartData = ChartData();
    chartData.dataRowsLegends = data.map((e) => e.category).toList();
    chartData.dataRows = data.map((e) => e.values).toList();
    chartData.xLabels = data[0].months.map((e) => getMonth(e)).toList();
    chartData.assignDataRowsDefaultColors();
  }
}
