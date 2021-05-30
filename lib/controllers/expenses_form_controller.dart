import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../models/category_model.dart';
import '../repositorys/category_repository.dart';

class ExpensesFormController {
  var dropdownMenuItems = RxList<DropdownMenuItem<CategoryModel>>([]);

  var selectedCategory = RxNotifier<CategoryModel?>(null);

  Future<void> init() async {
    final _repository = CategoryRepository();
    var response = await _repository.fetchCategories();
    dropdownMenuItems.addAll(buildDropdownMenuItemsBank(response));
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
