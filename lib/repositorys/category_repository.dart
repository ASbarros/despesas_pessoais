import 'package:financas_pessoais/database/database_helper.dart';
import 'package:financas_pessoais/database/tables/categories_table.dart';
import 'package:financas_pessoais/models/category_model.dart';

class CategoryRepository {
  final _database = DatabaseHelper.instance;

  Future<List<CategoryModel>> fetchCategories() async {
    final categories = <CategoryModel>[];
    final list = await _database.getAll(CategoriesTable.table);

    for (final item in list) {
      final category = CategoryModel.fromMap(item);
      categories.add(category);
    }

    return categories;
  }

  Future<CategoryModel> getById(int id) async =>
      CategoryModel.fromMap(await _database.getById(CategoriesTable.table, id));

  Future<int> delete(int id) async {
    return _database.delete(id, CategoriesTable.table);
  }

  Future<int> update(CategoryModel obj) async {
    return _database.update(obj, obj.id);
  }

  Future<int> insert(CategoryModel obj) async {
    return _database.insert(obj);
  }
}
