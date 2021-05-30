import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../controllers/expenses_list_controller.dart';

class FooterHome extends StatelessWidget {
  const FooterHome(
    this._controller,
  );

  final ExpensesListController _controller;

  String get valueFormatted {
    final numberFormat = NumberFormat.currency(locale: 'pt_br');

    return numberFormat.format(_controller.totalValue).substring(4);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mês Atual'),
                      RxBuilder(
                        builder: (_) => Checkbox(
                          value: _controller.filterCurrentMonth,
                          activeColor: Colors.green,
                          onChanged: (value) =>
                              _controller.filterCurrentMonth = value!,
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Todo período'),
                      RxBuilder(
                        builder: (_) => Checkbox(
                          activeColor: Colors.green,
                          value: !_controller.filterCurrentMonth,
                          onChanged: (value) =>
                              _controller.filterCurrentMonth = !value!,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Card(
        color: Colors.grey[200],
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RxBuilder(
                builder: (_) => Text(
                  'Total: R\$ $valueFormatted',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
