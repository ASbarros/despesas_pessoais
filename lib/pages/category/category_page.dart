import 'package:flutter/material.dart';

import '../../models/category.dart';
import 'category_form.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categories = <Category>[];
  @override
  void initState() {
    super.initState();
    Category.getAll().then((value) {
      setState(() {
        _categories.addAll(value);
      });
    }).catchError(debugPrint);
  }

  void _openCategoryFormModal(BuildContext context, [int id]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CategoryForm(id: id);
        });
  }

  void _removeTransaction(Category obj) {
    setState(() {
      _categories.remove(obj);
      obj.delete();
    });
  }

  Future<void> _refresh() async {
    final list = await Category.getAll();
    _categories.clear();
    setState(() {
      _categories.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorias'),
        actions: [
          IconButton(
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () => _openCategoryFormModal(context))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _refresh,
        child: const Icon(Icons.refresh),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: _categories.isEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Nenhuma Transação cadastrada!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.cover),
                    ),
                  ],
                )
              : ListView.builder(
                  itemCount: _categories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = _categories[index];
                    return Card(
                      elevation: 6,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 5),
                      child: ListTile(
                        onTap: () => _openCategoryFormModal(context, item.id),
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('${index + 1}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: IconButton(
                          color: Theme.of(context).errorColor,
                          icon: const Icon(Icons.delete),
                          onPressed: () => _removeTransaction(item),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
