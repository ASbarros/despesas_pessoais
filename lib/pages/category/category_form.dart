import 'package:financas_pessoais/repositorys/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';

class CategoryForm extends StatefulWidget {
  final int id;
  final void Function(CategoryModel) onSaved;

  const CategoryForm({Key key, this.id, this.onSaved}) : super(key: key);
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _titleController = TextEditingController();
  final _repository = CategoryRepository();
  CategoryModel category = CategoryModel(title: null);

  void _submitForm() async {
    final title = _titleController.text;

    if (title.isEmpty) {
      return;
    }

    category.title = title;
    if (widget.id != null && widget.id > 0) {
      await _repository.update(category);
    } else {
      category.id = await _repository.insert(category);
    }
    Navigator.of(context).pop();
    widget.onSaved(category);
  }

  @override
  void initState() {
    super.initState();
    if (widget.id != null && widget.id > 0) {
      _repository.getById(widget.id).then((value) {
        setState(() {
          category = value;
          _titleController.text = value.title;
        });
      }).catchError(print);
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
