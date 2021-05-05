import '../database/database_helper.dart';
import '../database/tables/categories_table.dart';
import '../database/tables/expenses_table.dart';
import '../models/chart_pie_data_model.dart';

class ChartPieRepository {
  final _database = DatabaseHelper.instance;

  Future<List<ChartPieDataModel>> data() async {
    final datas = <ChartPieDataModel>[];
    final listExpenses = await _database.getAll(ExpensesTable.table);
    final listCategories = await _database.getAll(CategoriesTable.table);

    for (final item in listExpenses) {
      final idCategory = item['category'];
      final nameCategory = listCategories
          .firstWhere((element) => element['id'] == idCategory)['title'];
      final value = double.parse(item['value']);

      final data = ChartPieDataModel.fromMap({
        'category': nameCategory,
        'totalValue': value,
        'idCategory': idCategory
      });
      if (datas.contains(data)) {
        final obj =
            datas.firstWhere((element) => element.category == data.category);
        obj.totalValue += data.totalValue;
      } else {
        datas.add(data);
      }
    }
    return datas;
  }
}
