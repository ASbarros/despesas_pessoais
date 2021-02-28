import 'package:financas_pessoais/common/search_dialog.dart';
import 'package:financas_pessoais/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/custom_drawer/my_drawer.dart';
import 'charts/chart_card/chart.dart';
import 'expenses/expenses_form.dart';
import 'expenses/expenses_list.dart';
import 'footer_home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          final expensesProvider = Provider.of<ExpensesProvider>(context);
          return ExpensesForm(onSubmit: (obj) async {
            if (obj.id != null && obj.id > 0) {
              await expensesProvider.update(obj);
            } else {
              await expensesProvider.add(obj);
            }
            Navigator.of(context).pop();
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final expensesProvider = Provider.of<ExpensesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Visibility(
          visible: expensesProvider.search.isEmpty,
          child: const Text('Despesas Pessoais'),
          replacement: Text(expensesProvider.search),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () async {
              final search = await showDialog<String>(
                  context: context,
                  builder: (_) => SearchDialog(
                        initialText: expensesProvider.search,
                      ));
              expensesProvider.search = search ?? '';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ChartCard(recentTransactions: expensesProvider.recentExpenses),
          Flexible(
            child: ExpensesList(),
          ),
          FooterHome(totalValue: expensesProvider.totalValue)
        ],
      ),
    );
  }
}
