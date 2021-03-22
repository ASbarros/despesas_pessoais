import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/my_clipper.dart';
import '../../../models/expenses_model.dart';
import 'chart_bar.dart';

class ChartCard extends StatelessWidget with PreferredSizeWidget {
  final List<ExpensesModel> recentTransactions;

  const ChartCard({Key? key, required this.recentTransactions})
      : super(key: key);

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
      return {
        'day': DateFormat('E', 'pt_br').format(weekDay).toUpperCase(),
        'value': totalSum
      };
    }).reversed.toList();
  }

  double get _weekTotalValue {
    return groupedTransactions.fold(
        0.0, (sum, tr) => sum + (tr['value'] as double));
  }

  @override
  Size get preferredSize => const Size(double.infinity, 250);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(size: 58),
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactions
                .map((tr) => Flexible(
                      fit: FlexFit.tight,
                      child: ChartBar(
                        label: tr['day'] as String,
                        value: tr['value'] as double,
                        percentage: _weekTotalValue == 0
                            ? 0
                            : (tr['value'] as double) / _weekTotalValue,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}
