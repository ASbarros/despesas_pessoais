import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import 'chart_bar.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart({Key key, @required this.recentTransactions}) : super(key: key);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));

      var totalSum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        final sameDay = recentTransactions[i].date.day == weekDay.day;
        final sameMonth = recentTransactions[i].date.month == weekDay.month;
        final sameYear = recentTransactions[i].date.year == weekDay.year;

        if (sameDay && sameMonth && sameYear) {
          totalSum += recentTransactions[i].value;
        }
      }

      return {'day': DateFormat.E().format(weekDay)[0], 'value': totalSum};
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(0.0, (sum, tr) => sum + tr['value']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((tr) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: tr['day'],
                      value: tr['value'],
                      percentage: (tr['value'] as double) / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
