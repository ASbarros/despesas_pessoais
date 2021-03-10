import 'package:financas_pessoais/models/category_model.dart';
import 'package:flutter/material.dart';

import '../repositorys/expenses_repository.dart';
import '../repositorys/category_repository.dart';

class CategoryProvider with ChangeNotifier {
  final _repository = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();
  List<CategoryModel> _items = [];

  CategoryProvider() {
    _init();
  }
  Future<void> _init() async {
    _items = await _repository.fetchCategories();
    notifyListeners();
  }

  List<CategoryModel> get items => [..._items];

  void add(CategoryModel obj) async {
    obj.id = await _repository.insert(obj);
    _items.add(obj);
    notifyListeners();
  }

  void update(CategoryModel obj) async {
    await _repository.update(obj);
    _items.removeWhere((element) => element.id == obj.id);
    _items.add(obj);
    _items.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  Future<bool> delete(int id) async {
    final expenses = await _repositoryExpenses.getByIdCategory(id);
    if (expenses.isEmpty) {
      _items.removeWhere((tr) => tr.id == id);
      await _repository.delete(id);
      notifyListeners();
      return true;
    } else {
      notifyListeners();
      return false;
    }
  }

  Future<void> restore(list) async {
    await _repository.restore(list);
    await _init();
    return;
  }
}
