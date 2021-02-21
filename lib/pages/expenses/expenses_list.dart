import 'package:financas_pessoais/pages/expenses/expenses_form.dart';
import 'package:financas_pessoais/providers/expenses_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList({Key key}) : super(key: key);

  @override
  _ExpensesListState createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ExpensesProvider>(builder: (_, expensesProvider, __) {
      final filteredExpenses = expensesProvider.filteredProducts;
      if (filteredExpenses.isEmpty) {
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
                child: Image.asset('assets/images/waiting.png',
                    fit: BoxFit.cover)),
          ],
        );
      } else {
        return ListView.builder(
          itemCount: filteredExpenses.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final tr = filteredExpenses[index];
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
                              expensesProvider.update(obj);
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
                    onPressed: () => expensesProvider.delete(tr.id)),
              ),
            );
          },
        );
      }
    });
  }
}
