import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../pages/charts/pie_chart/samples/indicator.dart';
import '../models/chart_pie_data_model.dart';
import '../repositorys/chart_pie_repository.dart';

class ChartPieProvider with ChangeNotifier {
  bool _visible = true;
  int _touchedIndex;
  final _repository = ChartPieRepository();

  List<ChartPieDataModel> _data = [];
  final idsCategoriesSelected = [];
  final _colors = [
    Colors.blue,
    Colors.yellow[800],
    Colors.red,
    Colors.purple,
    Colors.pink,
    Colors.green,
    Colors.black
  ];

  ChartPieProvider() {
    _init();
  }

  Future<void> _init() async {
    await _loadData();
    notifyListeners();
  }

  Future<void> _loadData() async {
    _data = await _repository.data();
  }

  set visible(bool value) {
    _visible = value;
    notifyListeners();
  }

  bool get visible => _visible;

  List<ChartPieDataModel> get data => [..._data];

  set touchedIndex(int index) {
    _touchedIndex = index;
    notifyListeners();
  }

  void toggle(int index) {
    idsCategoriesSelected.contains(index)
        ? idsCategoriesSelected.remove(index)
        : idsCategoriesSelected.add(index);
    notifyListeners();
  }

  int get touchedIndex => _touchedIndex;

  List<PieChartSectionData> showingSections() {
    _loadData();

    final res = <PieChartSectionData>[];
    final total = _data.fold(
        0.0, (previousValue, element) => previousValue += element.totalValue);
    for (var i = 0; i < _data.length; i++) {
      if (!idsCategoriesSelected.contains(_data[i].idCategory)) continue;
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 22.0 : 12.0;
      final radius = isTouched ? 60.0 : 50.0;
      res.add(PieChartSectionData(
        color: _colors[i],
        value: _data[i].totalValue,
        title: '${((100 * _data[i].totalValue) / total).toStringAsFixed(2)}%',
        badgeWidget: Text(
            visible ? 'R\$ ${_data[i].totalValue.toStringAsFixed(2)}' : ''),
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

  List<Widget> showingCatalogSections() {
    final res = <Widget>[];
    for (var i = 0; i < _data.length; i++) {
      res.add(Indicator(
        color: _colors[i],
        text: _data[i].category,
        idCategory: _data[i].idCategory,
        selected: idsCategoriesSelected.contains(_data[i].idCategory),
      ));
      res.add(SizedBox(height: 5));
    }
    return res;
  }
}
