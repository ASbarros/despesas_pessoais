import 'package:flutter/material.dart';

import '../models/expenses_model.dart';
import '../repositorys/expenses_repository.dart';

class ExpensesProvider with ChangeNotifier {
  final _repository = ExpensesRepository();
  List<ExpensesModel> _items = [];
  String _search = '';
  DateTime _startDate;
  DateTime _endDate;

  ExpensesProvider() {
    _init();
  }

  Future<void> _init() async {
    _items = await _repository.fetchExpenses();
    notifyListeners();
  }

  DateTime get startDate => _startDate;

  set startDate(DateTime date) {
    _startDate = date;
    notifyListeners();
  }

  DateTime get endDate => _endDate;
  set endDate(DateTime date) {
    _endDate = date;
    notifyListeners();
  }

  String get search => _search;

  set search(String value) {
    _search = value;
    notifyListeners();
  }

  List<ExpensesModel> get items => [..._items];

  List<ExpensesModel> get filteredExpenses {
    var filteredExpenses = items;
    if (_search.isNotEmpty) {
      filteredExpenses = filteredExpenses
          .where((element) =>
              element.title.toLowerCase().contains(_search.toLowerCase()))
          .toList();
    }

    if (_startDate != null) {
      filteredExpenses = filteredExpenses
          .where((element) => element.date.isAfter(_startDate))
          .toList();
    }

    if (_endDate != null) {
      filteredExpenses = filteredExpenses
          .where((element) => element.date.isBefore(_endDate))
          .toList();
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

  Future<void> add(ExpensesModel expense) async {
    expense.id = await _repository.insert(expense);
    _items.add(expense);
    notifyListeners();
    return;
  }

  Future<void> update(ExpensesModel obj) async {
    await _repository.update(obj);
    _items.removeWhere((element) => element.id == obj.id);
    _items.add(obj);
    _items.sort((a, b) => a.title.compareTo(b.title));
    notifyListeners();
    return;
  }

  void delete(int id) async {
    _items.removeWhere((tr) => tr.id == id);
    await _repository.delete(id);
    notifyListeners();
  }

  Future<void> restore(list) async {
    await _repository.restore(list);
    await _init();
    return;
  }
}
