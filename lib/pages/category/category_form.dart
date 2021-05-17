import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/category_model.dart';
import '../../providers/category_provider_.dart';
import '../../repositorys/category_repository.dart';

class CategoryForm extends StatefulWidget {
  final int? id;

  const CategoryForm({Key? key, this.id}) : super(key: key);
  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {
  final _titleController = TextEditingController();
  final _repository = CategoryRepository();
  CategoryModel category = CategoryModel(title: '');

  @override
  void initState() {
    super.initState();

    if (widget.id != null && widget.id! > 0) {
      _repository.getById(widget.id!).then((value) {
        setState(() {
          category = value;
          _titleController.text = value.title;
        });
      }).catchError((error, stackTrace) {
        debugPrint('error: $error');
      });
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

      category = CategoryModel(title: title);
      if (widget.id != null && widget.id! > 0) {
        category.id = widget.id;
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
        child: ListView(
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
                ElevatedButton(
                  onPressed: _submitForm,
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
