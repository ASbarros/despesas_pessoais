import 'dart:convert';
import 'dart:io';

import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:financas_pessoais/providers/category_provider.dart';
import 'package:financas_pessoais/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../repositorys/category_repository.dart';
import '../repositorys/expenses_repository.dart';

class BackupProvider extends ChangeNotifier {
  final _fileName = 'backup_financas_pessoais.json';
  final _repositoryCategory = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();
  Future<String> get _localPath async {
    final directory = await DownloadsPathProvider.downloadsDirectory;

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
