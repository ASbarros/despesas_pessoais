import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../repositorys/category_repository.dart';
import '../repositorys/expenses_repository.dart';
import 'category_provider.dart';
import 'expenses_provider.dart';

class BackupProvider extends ChangeNotifier {
  final _fileName = 'backup_financas_pessoais.txt';
  final _repositoryCategory = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();
  Future<String?> get _localPath async {
    final directory = await getDownloadsDirectory();
    if (directory == null) return null;
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  void writeCounter() async {
    final file = await _localFile;
    var categories = await _repositoryCategory.fetchCategoriesToMap();
    var expenses = await _repositoryExpenses.fetchExpensesToMap();
    var data = {'categories': categories, 'expenses': expenses};

    // Write the file.
    await file.writeAsString(json.encode(data));
  }

  Future<bool> readCounter(BuildContext context) async {
    var expensesProvider =
        Provider.of<ExpensesProvider>(context, listen: false);
    var categoriesProvider =
        Provider.of<CategoryProvider>(context, listen: false);
    try {
      final file = await _localFile;

      // Read the file.
      var contents = await file.readAsString();

      final categories = json.decode(contents)['categories'];
      final expenses = json.decode(contents)['expenses'];

      await categoriesProvider.restore(categories);
      await expensesProvider.restore(expenses);

      return true;
    } catch (e) {
      return false;
    }
  }
}
