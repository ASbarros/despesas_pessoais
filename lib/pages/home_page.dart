import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../common/custom_drawer/my_drawer.dart';
import '../common/page_default.dart';
import '../common/search_dialog.dart';
import '../controllers/expenses_list_controller.dart';
import 'charts/chart_card/chart.dart';
import 'expenses/expenses_form.dart';
import 'expenses/expenses_list.dart';
import 'footer_home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final ExpensesListController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ExpensesListController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return ExpensesForm(onSubmit: (obj) async {
            if (obj.id != null && obj.id! > 0) {
              await _controller.update(obj);
            } else {
              await _controller.add(obj);
            }
            Navigator.of(context).pop();
          });
        });
  }

  final Stream<int> _bids = (() async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield 1;
    await Future<void>.delayed(Duration(seconds: 1));
  })();
  final Stream<int> _bids2 = (() async* {
    await Future<void>.delayed(Duration(seconds: 1));
    yield 1;
    await Future<void>.delayed(Duration(seconds: 1));
  })();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RxBuilder(
            builder: (_) =>
                Text(_controller.search ?? _controller.title.value)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, size: 30),
            onPressed: () async {
              final search = await showDialog<String>(
                  context: context,
                  builder: (_) => SearchDialog(
                        initialText: _controller.search,
                      ));
              _controller.search = search;
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
          StreamBuilder(
            stream: _bids,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
                ChartCard(recentTransactions: _controller.recentExpenses),
          ),
          Flexible(
            child: RxBuilder(
              builder: (_) => Visibility(
                  visible: !(_controller.loading.value &&
                      _controller.filteredExpenses.isEmpty),
                  replacement: PageDefault(),
                  child: ExpensesList(_controller)),
            ),
          ),
          StreamBuilder(
              stream: _bids2,
              builder: (BuildContext context, AsyncSnapshot<int> snapshot) =>
                  FooterHome(totalValue: _controller.totalValue)),
        ],
      ),
    );
  }
}
