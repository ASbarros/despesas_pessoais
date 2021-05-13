import 'package:rx_notifier/rx_notifier.dart';

import '../models/expenses_model.dart';
import '../repositorys/expenses_repository.dart';
import 'controller_base.dart';

class HomeController extends ControllerBase {
  final title = RxNotifier<String>('Despesas Pessoais'),
      _search = RxNotifier<String?>(null),
      _repository = ExpensesRepository(),
      _startDate = RxNotifier<DateTime?>(null),
      _endDate = RxNotifier<DateTime?>(null),
      loading = RxNotifier<bool>(false);

  var _items = RxList<ExpensesModel>([]);

  HomeController() {
    init();
  }

  @override
  Future<void> init() async {
    loading.value = true;
    var response = await _repository.fetchExpenses();
    _items = response.asRx();
    _items.sort((a, b) => b.date.toString().compareTo(a.date.toString()));
    loading.value = false;
  }

  @override
  void dispose() {
    title.dispose();
    _search.dispose();
    _endDate.dispose();
    _startDate.dispose();
    loading.dispose();
  }

  List<ExpensesModel> get items => [..._items];

  String? get search => _search.value;

  set search(String? value) {
    _search.value = value;
  }

  DateTime? get startDate => _startDate.value;

  set startDate(DateTime? date) {
    _startDate.value = date;
  }

  DateTime? get endDate => _endDate.value;
  set endDate(DateTime? date) {
    _endDate.value = date;
  }

  List<ExpensesModel> get filteredExpenses {
    var filteredExpenses = items;
    if (search != null && search!.isNotEmpty) {
      filteredExpenses = filteredExpenses
          .where((element) =>
              element.title.toLowerCase().contains(search!.toLowerCase()))
          .toList();
    }

    if (_startDate.value != null) {
      filteredExpenses = filteredExpenses
          .where((element) => element.date.isAfter(_startDate.value!))
          .toList();
    }

    if (_endDate.value != null) {
      filteredExpenses = filteredExpenses
          .where((element) => element.date.isBefore(_endDate.value!))
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

    return;
  }

  Future<void> update(ExpensesModel obj) async {
    await _repository.update(obj);
    _items.removeWhere((element) => element.id == obj.id);
    _items.add(obj);
    _items.sort((a, b) => a.title.compareTo(b.title));

    return;
  }

  void delete(int id) async {
    _items.removeWhere((tr) => tr.id == id);
    await _repository.delete(id);
  }

  Future<void> restore(list) async {
    await _repository.restore(list);
    await init();
    return;
  }
}
