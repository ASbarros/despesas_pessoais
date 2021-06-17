import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../models/category_model.dart';
import '../repositorys/category_repository.dart';
import '../repositorys/expenses_repository.dart';

class ExpensesFormController {
  var dropdownMenuItems = RxList<DropdownMenuItem<CategoryModel>>([]);

  var selectedCategory = RxNotifier<CategoryModel?>(null);

  final _repositoryExpense = ExpensesRepository();

  Future<void> init(int? id) async {
    final _repository = CategoryRepository();
    var categories = await _repository.fetchCategories();
    dropdownMenuItems.addAll(buildDropdownMenuItemsBank(categories));
    if (id != null && id > 0) {
      var _expensesModel = await _repositoryExpense.getById(id);
      selectedCategory.value = categories
          .firstWhere((element) => element.id == _expensesModel.category);
    }
  }

  RxList<DropdownMenuItem<CategoryModel>> buildDropdownMenuItemsBank(
      List<CategoryModel> list) {
    selectedCategory.value = list.first;
    return list
        .map((e) => DropdownMenuItem(value: e, child: Text(e.title)))
        .toList()
        .asRx();
  }

  void dispose() {
    dropdownMenuItems.dispose();
    selectedCategory.dispose();
  }
}
