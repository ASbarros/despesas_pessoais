import 'package:flutter/material.dart';

import '../models/expenses_model.dart';
import '../repositorys/expenses_repository.dart';

class ExpensesProvider with ChangeNotifier {
  final _repository = ExpensesRepository();
  List<ExpensesModel> _items = [];
  String _search = '';

  ExpensesProvider() {
    _init();
  }
  Future<void> _init() async {
    _items = await _repository.fetchExpenses();
    notifyListeners();
  }

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ExpensesModel> get items => [..._items];

  List<ExpensesModel> get filteredExpenses {
    final filteredExpenses = <ExpensesModel>[];
    if (_search.isEmpty) {
      filteredExpenses.addAll(_items);
    } else {
      filteredExpenses.addAll(_items.where((element) =>
          element.title.toLowerCase().contains(_search.toLowerCase())));
    }
    return filteredExpenses;
  }

  List<ExpensesModel> get recentExpenses {
    return _items
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  double get totalValue => filteredExpenses.fold(
      0.0, (previousValue, element) => previousValue += element.value);

  void add(ExpensesModel expense) async {
    expense.id = await _repository.insert(expense);
    _items.add(expense);
    notifyListeners();
  }

  void update(ExpensesModel obj) async {
    await _repository.update(obj);
    _items.removeWhere((element) => element.id == obj.id);
    _items.add(obj);
    _items.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
  }

  void delete(int id) async {
    _items.removeWhere((tr) => tr.id == id);
    await _repository.delete(id);
    notifyListeners();
  }
}
