import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../database/tables/categories_table.dart';
import 'object_base.dart';

class Category extends ObjectBase {
  int id;
  String title;

  Category({this.id, @required this.title});

  @override
  Map<String, Object> toMap() {
    return {'id': id, 'title': title};
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Category(
      id: map['id'],
      title: map['title'],
    );
  }

  @override
  String get table => CategoriesTable().table;

  @override
  Future<int> insert() async {
    return await DatabaseHelper.instance.insert(this);
  }

  @override
  Future<int> update() async {
    return await DatabaseHelper.instance.update(this, id);
  }

  static Future<List<Category>> getAll() async {
    final categories = <Category>[];
    final values =
        await DatabaseHelper.instance.getAll(Category(title: null).table);
    values.forEach((element) {
      categories.add(Category.fromMap(element));
    });
    return categories;
  }

  static Future<Category> getById(int id) async {
    var category = Category(title: null);
    Map<String, Object> map =
        await DatabaseHelper.instance.getById(category.table, id);
    category = Category.fromMap(map);
    return category;
  }

  @override
  Future<int> delete() async {
    return await DatabaseHelper.instance.delete(id, table);
  }
}
