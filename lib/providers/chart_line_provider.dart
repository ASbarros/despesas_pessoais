import 'package:financas_pessoais/models/chart_line_data_model.dart';
import 'package:financas_pessoais/repositorys/chart_line_repository.dart';
import 'package:flutter/material.dart';

class ChartLineProvider with ChangeNotifier {
  final _repository = ChartLineRepository();

  var data = <ChartLineDataModel>[];
  var maxY = 0.0;

  ChartLineProvider() {
    _init();
  }

  void _init() async {
    data = await _repository.data();
    maxY = _repository.maxY;
  }

  Color getColor(int index) {
    return const [
      Colors.green,
      Colors.yellow,
      Colors.black,
      Colors.blue,
      Colors.red,
    ][index];
  }

  String getMonth([double month = 0]) {
    var index = month.toInt();
    switch (index) {
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

  String getTitles(double value) {
    var index = value.toInt() ~/ 100;

    switch (index) {
      case 1:
        return '100';
      case 2:
        return '200';
      case 3:
        return '300';
      case 4:
        return '400';
      case 5:
        return '500';
      case 6:
        return '600';
      case 7:
        return '700';
      case 8:
        return '800';
      case 9:
        return '900';
      case 10:
        return '1.0k';
      case 12:
        return '1.2k';
      case 14:
        return '1.4k';
      case 16:
        return '1.6k';
      case 18:
        return '1.8k';
      case 19:
        return '1.9k';
      case 20:
        return '2.0k';
    }
    return '';
  }
}
