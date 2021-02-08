import 'dart:math';

import 'package:flutter/material.dart';

import '../components/chart.dart';
import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../database/database_helper.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  @override
  void initState() {
    super.initState();

    DatabaseHelper.instance.queryAllRows('expences').then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.forEach((element) {
        setState(() {
          _transactions.add(Transaction.fromMap(element));
        });
      });
    }).catchError(print);
  }

  List<Transaction> get _recentTransactions {
    return _transactions
        .where(
            (tr) => tr.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      title: title,
      value: value,
      date: date,
    );

    DatabaseHelper.instance.insert(newTransaction, 'expences');

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
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
        title: Text('Despesas Pessoais'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30),
            onPressed: () => _openTransactionFormModal(context),
          ),
        ],
      ),
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
