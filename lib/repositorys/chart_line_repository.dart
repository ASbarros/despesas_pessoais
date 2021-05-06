import 'package:financas_pessoais/database/tables/categories_table.dart';
import 'package:financas_pessoais/database/tables/expenses_table.dart';

import '../database/database_helper.dart';
import '../models/chart_line_data_model.dart';

class ChartLineRepository {
  final _database = DatabaseHelper.instance;
  Future<List<ChartLineDataModel>> data() async {
    final datas = <ChartLineDataModel>[];
    final listExpenses =
        await _database.getAll(ExpensesTable.table, 'date desc');
    final listCategories = await _database.getAll(CategoriesTable.table);

    for (final item in listExpenses) {
      final idCategory = item['category'];
      final nameCategory = listCategories
          .firstWhere((element) => element['id'] == idCategory)['title'];
      final value = double.parse(item['value']);

      final data = ChartLineDataModel.fromMap({
        'category': nameCategory,
        'idCategory': idCategory,
      });

      if (DateTime.fromMillisecondsSinceEpoch(item['date'])
          .isAfter(DateTime.now().subtract(Duration(days: 30 * 5)))) {
        if (datas.contains(data)) {
          final obj =
              datas.firstWhere((element) => element.category == data.category);
          obj.addItem({
            'value': value,
            'month': DateTime.fromMillisecondsSinceEpoch(item['date']).month
          });
        } else {
          data.addItem({
            'value': value,
            'month': DateTime.fromMillisecondsSinceEpoch(item['date']).month
          });
          datas.add(data);
        }
      }
    }
    return datas;
  }
}
