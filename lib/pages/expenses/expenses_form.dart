import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../../controllers/category_list_controller.dart';
import '../../models/expenses_model.dart';
import '../../repositorys/expenses_repository.dart';

class ExpensesForm extends StatefulWidget {
  final void Function(ExpensesModel) onSubmit;
  final int? id;

  const ExpensesForm({Key? key, required this.onSubmit, this.id})
      : super(key: key);

  @override
  _ExpensesFormState createState() => _ExpensesFormState();
}

class _ExpensesFormState extends State<ExpensesForm> {
  var _expensesModel =
      ExpensesModel(title: '', value: 0.0, category: 0, date: DateTime.now());
  final _titleController = TextEditingController();
  final _valueController = TextEditingController(text: '#,##');

  final _repositoryExpense = ExpensesRepository();

  final _controller = CategorylistController();

  int dropdownValue = 0;

  DateTime _selectedDate = DateTime.now();

  void _submitForm() async {
    final title = _titleController.text;
    final value = double.tryParse(
            _valueController.text.replaceAll('.', '').replaceAll(',', '.')) ??
        0.0;
    if (title.isEmpty || value <= 0) {
      return;
    }
    var _expensesModel = ExpensesModel(
        id: widget.id,
        title: title,
        value: value,
        category: dropdownValue,
        date: _selectedDate);

    widget.onSubmit(_expensesModel);
  }

  void _showDatePicker([DateTime? date]) {
    showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime(2020),
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
    init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void init() async {
    if (widget.id != null && widget.id! > 0) {
      _expensesModel = await _repositoryExpense.getById(widget.id!);
      _titleController.text = _expensesModel.title;
      _valueController.text = _expensesModel.valueFormatted;
      _selectedDate = _expensesModel.date;
      dropdownValue = _expensesModel.category;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final categories = _controller.items;
    if (dropdownValue == 0) {
      dropdownValue =
          // ignore: todo
          categories.first.id!; //TODO: sempre da erro na primeira vez
    }
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
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
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                RealInputFormatter(centavos: true),
              ],
              onSubmitted: (_) => _submitForm(),
            ),
            Row(
              children: [
                const Expanded(flex: 3, child: Text('Categoria')),
                Expanded(
                  flex: 5,
                  child: categories.isNotEmpty
                      ? DropdownButton<int>(
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
                              dropdownValue = newValue!;
                            });
                          },
                          items:
                              categories.map<DropdownMenuItem<int>>((category) {
                            return DropdownMenuItem<int>(
                              value: category.id,
                              child: Text(category.title),
                            );
                          }).toList(),
                        )
                      : Center(
                          child: LinearProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.green),
                          minHeight: 7,
                          backgroundColor: Colors.redAccent,
                        )),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(DateFormat('dd/MM/y').format(_selectedDate)),
                ),
                Expanded(
                  flex: 5,
                  child: TextButton(
                    // textColor: Theme.of(context).primaryColor,
                    onPressed: widget.id != null && widget.id! > 0
                        ? () => _showDatePicker(_expensesModel.date)
                        : _showDatePicker,
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
                ElevatedButton(
                  onPressed: _submitForm,
                  //color: Theme.of(context).primaryColor,
                  //textColor: Theme.of(context).textTheme.button.color,
                  child: const Text('Salvar'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
