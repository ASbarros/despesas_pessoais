import 'dart:convert';

import 'package:flutter/material.dart';

import '../../common/custom_drawer/my_drawer.dart';
import '../../repositorys/category_repository.dart';
import '../../repositorys/expenses_repository.dart';

class BackupPage extends StatefulWidget {
  @override
  _BackupPageState createState() => _BackupPageState();
}

class _BackupPageState extends State<BackupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(title: Text('Backup'), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final response = await ExpensesRepository().fetchExpenses();
                await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: SelectableText(jsonEncode(response)),
                      );
                    });
              },
              child: Text('Exportar Despesas'),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                final response = await CategoryRepository().fetchCategories();
                await showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        content: SelectableText(jsonEncode(response)),
                      );
                    });
              },
              child: Text('Exportar Categorias'),
            ),
          ),
        ],
      ),
    );
  }
}
