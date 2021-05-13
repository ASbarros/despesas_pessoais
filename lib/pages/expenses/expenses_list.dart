import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../controllers/expenses_list_controller.dart';
import 'expenses_form.dart';

class ExpensesList extends StatelessWidget {
  final HomeController _controller;
  const ExpensesList(this._controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _controller.filteredExpenses.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final tr = _controller.filteredExpenses[index];
        return Card(
          elevation: 6,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (_) {
                    return ExpensesForm(
                        onSubmit: (obj) {
                          _controller.update(obj);
                          Navigator.of(context).pop();
                        },
                        id: tr.id);
                  });
            },
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
                onPressed: () => _controller.delete(tr.id!)),
          ),
        );
      },
    );
  }
}
