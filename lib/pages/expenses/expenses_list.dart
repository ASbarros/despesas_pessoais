import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/expenses_model.dart';

class ExpensesList extends StatelessWidget {
  final List<ExpensesModel> transactions;
  final void Function(int) onRemove;

  const ExpensesList(
      {Key key, @required this.transactions, @required this.onRemove})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Nenhum Gasto cadastrado!',
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 20),
          Container(
              height: 200,
              child:
                  Image.asset('assets/images/waiting.png', fit: BoxFit.cover)),
        ],
      );
    } else {
      return ListView.builder(
        itemCount: transactions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final tr = transactions[index];
          return Card(
            elevation: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: ListTile(
              leading: CircleAvatar(
                radius: 30,
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: FittedBox(
                    child: Text('${tr.value}',
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
              title: Text(
                tr.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              subtitle: Text(DateFormat('d MMM y').format(tr.date)),
              trailing: IconButton(
                  color: Theme.of(context).errorColor,
                  icon: const Icon(Icons.delete),
                  onPressed: () => onRemove(tr.id)),
            ),
          );
        },
      );
    }
  }
}
