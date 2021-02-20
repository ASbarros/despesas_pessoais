import 'package:financas_pessoais/common/search_dialog.dart';
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
  final List<ExpensesModel> _expenses = [];
  List<ExpensesModel> _expensesFiltered = [];
  final _repositoryExpenses = ExpensesRepository();
  String _search;

  @override
  void initState() {
    super.initState();
    _search = '';
    setState(() {
      _repositoryExpenses.fetchExpenses().then((list) {
        setState(() {
          _expenses.addAll(list);
        });
      }).catchError(print);
    });
  }

  List<ExpensesModel> get _recentExpenses {
    return _expenses
        .where((tr) =>
            tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  void _addTransaction(ExpensesModel obj) async {
    setState(() {
      _expenses.add(obj);
      _expenses.sort((a, b) => a.title.compareTo(b.title));
    });

    Navigator.of(context).pop();
  }

  void _removeTransaction(int id) {
    setState(() {
      _expenses.removeWhere((tr) => tr.id == id);
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
        title: Visibility(
          visible: _search.isEmpty,
          child: const Text('Despesas Pessoais'),
          replacement: Text(_search),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () async {
              final search = await showDialog<String>(
                  context: context,
                  builder: (_) => SearchDialog(
                        initialText: _search,
                      ));
              _search = search;
              if (search != null) {
                setState(() {
                  _expensesFiltered = _expenses
                      .where((e) =>
                          e.title.toLowerCase().contains(search.toLowerCase()))
                      .toList();
                });
              }
            },
          ),
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
          ChartCard(recentTransactions: _recentExpenses),
          /* Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Card(
              elevation: 6,
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              child: IconButton(icon: Icon(Icons.sort), onPressed: () {}),
            ),
          ]), */
          Flexible(
            child: ExpensesList(
                transactions: _expensesFiltered.isEmpty && _search.isEmpty
                    ? _expenses
                    : _expensesFiltered,
                onRemove: _removeTransaction),
          ),
        ],
      ),
    );
  }
}
