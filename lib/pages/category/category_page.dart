import 'package:flutter/material.dart';

import '../../database/database_helper.dart';
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
    DatabaseHelper.instance.getAll('categories').then((value) {
      // ignore: avoid_function_literals_in_foreach_calls
      value.forEach((element) {
        setState(() {
          _categories.add(Category.fromMap(element));
        });
      });
    }).catchError(print);
  }

  _openCategoryFormModal(BuildContext context, [int id]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CategoryForm(id: id);
        });
  }

  _removeTransaction(Category obj) {
    setState(() {
      _categories.remove(obj);
      obj.delete();
    });
  }

  Future<Null> _refresh() async {
    Category.getAll().then((value) {
      _categories.clear();
      _categories.addAll(value);
    }).catchError(print);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorias'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.add,
                size: 30,
              ),
              onPressed: () => _openCategoryFormModal(context))
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        child: Center(
          child: _categories.isEmpty
              ? Column(
                  children: [
                    SizedBox(height: 20),
                    Text(
                      'Nenhuma Transação cadastrada!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(height: 20),
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
                      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                      child: ListTile(
                        onTap: () => _openCategoryFormModal(context, item.id),
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: const EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text('${index + 1}',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ),
                        title: Text(
                          item.title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        trailing: IconButton(
                          color: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
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
