import 'package:financas_pessoais/repositorys/expenses_repository.dart';
import 'package:flutter/material.dart';

import '../common/custom_drawer/my_drawer.dart';
import '../components/chart.dart';
import '../database/database_helper.dart';
import '../database/tables/expenses_table.dart';
import '../models/category_model.dart';
import '../models/expenses_model.dart';
import 'transaction/expenses_form.dart';
import 'transaction/expenses_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<ExpensesModel> _transactions = [];
  final _repositoryExpenses = ExpensesRepository();

  @override
  void initState() {
    super.initState();
    setState(() {
      _repositoryExpenses.fetchExpenses().then((list) {
        setState(() {
          _transactions.addAll(list);
        });
      }).catchError(print);
    });
  }

  List<ExpensesModel> get _recentTransactions {
    return _transactions
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(
      String title, double value, DateTime date, CategoryModel category) {
    final newTransaction = ExpensesModel(
        title: title, value: value, date: date, category: category.id);

    DatabaseHelper.instance.insert(newTransaction);

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      DatabaseHelper.instance.delete(id, ExpensesTable.table);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ExpensesForm(onSubmit: _addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, size: 30),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
      drawer: MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Chart(recentTransactions: _recentTransactions),
          Flexible(
            child: ExpensesList(
                transactions: _transactions, onRemove: _removeTransaction),
          ),
        ],
      ),
    );
  }
}
