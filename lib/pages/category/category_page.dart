import 'package:financas_pessoais/repositorys/category_repository.dart';
import 'package:financas_pessoais/repositorys/expenses_repository.dart';
import 'package:flutter/material.dart';

import '../../models/category_model.dart';
import 'category_form.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final _categories = <CategoryModel>[];
  final _repository = CategoryRepository();
  final _repositoryExpenses = ExpensesRepository();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    final list = await _repository.fetchCategories();
    setState(() {
      _categories.addAll(list);
    });
  }

  void _openCategoryFormModal(BuildContext context, [int id]) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return CategoryForm(id: id);
        });
  }

  void _removeCategory(
      {@required CategoryModel obj, @required BuildContext context}) async {
    final expenses = await _repositoryExpenses.getByIdCategory(obj.id);
    if (expenses.isEmpty) {
      setState(() {
        _categories.remove(obj);
        _repository.delete(obj.id);
      });
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
        backgroundColor: Colors.red,
        content: Text('Categoria com despesas associadas!'),
        duration: Duration(seconds: 5),
      ));
    }
  }

  Future<void> _refresh() async {
    final list = await _repository.fetchCategories();
    _categories.clear();
    setState(() {
      _categories.addAll(list);
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
                          onPressed: () =>
                              _removeCategory(obj: item, context: context),
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
