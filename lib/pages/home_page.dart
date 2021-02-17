import 'package:financas_pessoais/repositorys/expenses_repository.dart';
import 'package:flutter/material.dart';

import '../common/custom_drawer/my_drawer.dart';
import 'charts/chart_card/chart.dart';
import '../models/expenses_model.dart';
import 'expenses/expenses_form.dart';
import 'expenses/expenses_list.dart';

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

  void _addTransaction(ExpensesModel obj) async {
    setState(() {
      _transactions.add(obj);
      _transactions.sort((a, b) => a.title.compareTo(b.title));
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(int id) {
    setState(() {
      _transactions.removeWhere((tr) => tr.id == id);
      _repositoryExpenses.delete(id);
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
          ChartCard(recentTransactions: _recentTransactions),
          Flexible(
            child: ExpensesList(
                transactions: _transactions, onRemove: _removeTransaction),
          ),
        ],
      ),
    );
  }
}
