import 'package:flutter/material.dart';

import '../common/custom_drawer/my_drawer.dart';
import '../components/chart.dart';
import '../database/database_helper.dart';
import '../database/tables/expenses_table.dart';
import '../models/category.dart';
import '../models/transaction.dart';
import 'transaction/transaction_form.dart';
import 'transaction/transaction_list.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      Transaction.getAll().then((list) {
        setState(() {
          _transactions.addAll(list);
        });
      }).catchError(print);
    });
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(
      String title, double value, DateTime date, Category category) {
    final newTransaction = Transaction(
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
      DatabaseHelper.instance.delete(id, ExpensesTable().table);
    });
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(onSubmit: _addTransaction);
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
            child: TransactionList(
                transactions: _transactions, onRemove: _removeTransaction),
          ),
        ],
      ),
    );
  }
}
