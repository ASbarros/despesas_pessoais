import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';

import '../../common/custom_drawer/my_drawer.dart';
import '../../common/page_default.dart';
import '../../controllers/category_list_controller.dart';
import 'category_form.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _controller = CategorylistController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _openCategoryFormModal(BuildContext context, [int? id]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CategoryForm(id: id);
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
      drawer: MyDrawer(),
      body: RxBuilder(builder: (_) {
        return Visibility(
          visible: !_controller.loading.value || _controller.items.isNotEmpty,
          replacement: Center(child: PageDefault()),
          child: ListView.builder(
            itemCount: _controller.items.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final item = _controller.items[index];
              return Card(
                elevation: 6,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  onTap: () => _openCategoryFormModal(context, item.id),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('${index + 1}',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold)),
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
                      final res = await _controller.delete(item.id!);
                      if (!res) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          action: SnackBarAction(
                            label: 'OK',
                            onPressed: () {},
                          ),
                          backgroundColor: Colors.red,
                          content: Text('Categoria com despesas associadas!'),
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
