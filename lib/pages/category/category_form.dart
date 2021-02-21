import 'package:financas_pessoais/providers/category_provider.dart';
import 'package:financas_pessoais/repositorys/category_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';

class CategoryForm extends StatefulWidget {
  final int id;

  const CategoryForm({Key key, this.id}) : super(key: key);
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _titleController = TextEditingController();
  final _repository = CategoryRepository();
  CategoryModel category;

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
    final categoryProvider = Provider.of<CategoryProvider>(context);

    void _submitForm() {
      final title = _titleController.text;

      if (title.isEmpty) {
        return;
      }

      category.title = title;
      if (widget.id != null && widget.id > 0) {
        categoryProvider.update(category);
      } else {
        categoryProvider.add(category);
      }
      Navigator.of(context).pop();
    }

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
