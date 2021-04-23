import 'package:financas_pessoais/database/database_helper.dart';
import 'package:financas_pessoais/database/tables/expenses_table.dart';
import 'package:financas_pessoais/models/expenses_model.dart';

class ExpensesRepository {
  final _database = DatabaseHelper.instance;

  Future<List<ExpensesModel>> fetchExpenses() async {
    final expenses = <ExpensesModel>[];
    final list = await _database.getAll(ExpensesTable.table);

    for (final item in list) {
      final category = ExpensesModel.fromMap(item);
      expenses.add(category);
    }

    return expenses;
  }

  Future<List<Map<String, dynamic>>> fetchExpensesToMap() async {
    final list = await _database.getAll(ExpensesTable.table);

    return list;
  }

  Future<void> restore(categoriesList) async {
    for (final item in categoriesList) {
      await insert(ExpensesModel.fromMap(item));
    }

    return;
  }

  Future<ExpensesModel> getById(int id) async =>
      ExpensesModel.fromMap(await _database.getById(ExpensesTable.table, id));

  Future<int> delete(int id) async {
    return _database.delete(id, ExpensesTable.table);
  }

  Future<int> update(ExpensesModel obj) async {
    print(obj.toMap());
    return _database.update(obj, obj.id!);
  }

  Future<int> insert(ExpensesModel obj) async {
    return _database.insert(obj);
  }

  Future<List<ExpensesModel>> getByIdCategory(int idCategory) async {
    final expenses = <ExpensesModel>[];
    final list = await _database.getAll(ExpensesTable.table);

    for (final item in list) {
      final expense = ExpensesModel.fromMap(item);
      if (expense.category == idCategory) expenses.add(expense);
    }

    return expenses;
  }
}
