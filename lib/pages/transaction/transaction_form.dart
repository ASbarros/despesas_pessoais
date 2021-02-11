import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../database/database_helper.dart';
import '../../database/tables/categories_table.dart';
import '../../models/category.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime, Category) onSubmit;

  const TransactionForm({Key key, @required this.onSubmit}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();

  int dropdownValue = 1;
  final _categories = <Category>[];

  DateTime _selectedDate = DateTime.now();

  void _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate, _categories[0]);
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    DatabaseHelper.instance.getAll(CategoriesTable().table).then((value) {
      _categories.clear();
      // ignore: avoid_function_literals_in_foreach_calls
      value.forEach((element) {
        setState(() {
          _categories.add(Category.fromMap(element));
        });
      });
    }).catchError(debugPrint);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Título'),
            ),
            TextField(
              controller: _valueController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Valor (R\$)'),
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Categoria')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<int>(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_drop_down),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: _categories.map<DropdownMenuItem<int>>((category) {
                      return DropdownMenuItem<int>(
                        value: category.id,
                        child: Text(category.title),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(_selectedDate == null
                      ? 'Nenhuma data selectionada!'
                      : DateFormat('dd/MM/y').format(_selectedDate)),
                ),
                Expanded(
                  flex: 5,
                  child: FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _showDatePicker,
                    child: const Text(
                      'Selecionar Data',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitForm,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: const Text('Nova transação'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
