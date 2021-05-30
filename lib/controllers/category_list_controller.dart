import 'package:rx_notifier/rx_notifier.dart';

import '../repositorys/expenses_repository.dart';

import '../repositorys/category_repository.dart';

import 'controller_base.dart';
import '../models/category_model.dart';

class CategorylistController extends ControllerBase {
  final _repository = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();
  var _items = RxList<CategoryModel>([]), loading = RxNotifier<bool>(false);
  var items = RxList<CategoryModel>([]);
  CategorylistController() {
    init();
  }

  @override
  Future<void> init() async {
    loading.value = true;
    var response = await _repository.fetchCategories();
    _items = response.asRx();
    items = RxList<CategoryModel>([..._items]);
    loading.value = false;
  }

  @override
  void dispose() {
    _items.dispose();
    loading.dispose();
    items.dispose();
  }

  void add(CategoryModel obj) async {
    obj.id = await _repository.insert(obj);
    _items.add(obj);
    items.add(obj);
  }

  void update(CategoryModel obj) async {
    await _repository.update(obj);
    _items.removeWhere((element) => element.id == obj.id);
    _items.add(obj);
    _items.sort((a, b) => a.title.compareTo(b.title));
    items = RxList<CategoryModel>([..._items]);
  }

  Future<bool> delete(int id) async {
    final expenses = await _repositoryExpenses.getByIdCategory(id);
    if (expenses.isEmpty) {
      _items.removeWhere((tr) => tr.id == id);
      await _repository.delete(id);
      items = RxList<CategoryModel>([..._items]);
      return true;
    } else {
      return false;
    }
  }

  Future<void> restore(list) async {
    await _repository.restore(list);
    await init();
    return;
  }
}
