import 'package:financas_pessoais/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'category_form.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  void _openCategoryFormModal(BuildContext context, [int id]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CategoryForm(id: id);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
      body: Consumer<CategoryProvider>(builder: (_, categoryProvider, __) {
        final categories = categoryProvider.items;
        return Center(
          child: categories.isEmpty
              ? Column(
                  children: [
                    const SizedBox(height: 20),
                    Text(
                      'Nenhuma Categoria cadastrada!',
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
                  itemCount: categories.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final item = categories[index];
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
                          onPressed: () async {
                            final res = await categoryProvider.delete(item.id);
                            if (!res) {
                              _scaffoldKey.currentState.showSnackBar(SnackBar(
                                action: SnackBarAction(
                                  label: 'OK',
                                  onPressed: () {},
                                ),
                                backgroundColor: Colors.red,
                                content:
                                    Text('Categoria com despesas associadas!'),
                                duration: Duration(seconds: 5),
                              ));
                            }
                          },
                        ),
                      ),
                    );
                  },
                ),
        );
      }),
    );
  }
}
