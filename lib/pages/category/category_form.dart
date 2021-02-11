import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
import '../../models/category.dart';

class CategoryForm extends StatefulWidget {
  final int id;

  const CategoryForm({Key key, this.id}) : super(key: key);
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _titleController = TextEditingController();
  Category category = Category(title: null);

  void _submitForm() {
    final title = _titleController.text;

    if (title.isEmpty) {
      return;
    }

    category.title = title;
    if (widget.id != null && widget.id > 0) {
      DatabaseHelper.instance.update(category, widget.id);
    } else {
      category.insert();
    }
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null && widget.id > 0) {
      Category.getById(widget.id).then((value) {
        setState(() {
          category = value;
          _titleController.text = value.title;
        });
      }).catchError(debugPrint);
    }
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
              onSubmitted: (_) => _submitForm(),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RaisedButton(
                  onPressed: _submitForm,
                  color: Theme.of(context).primaryColor,
                  textColor: Theme.of(context).textTheme.button.color,
                  child: const Text('Nova categoria'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
