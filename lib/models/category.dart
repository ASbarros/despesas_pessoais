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
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  @override
  String get table => CategoriesTable().table;

  @override
  Future<int> insert() async {
    return DatabaseHelper.instance.insert(this);
  }

  @override
  Future<int> update() async {
    return DatabaseHelper.instance.update(this, id);
  }

  static Future<List<Category>> getAll() async {
    final categories = <Category>[];
    final values =
        await DatabaseHelper.instance.getAll(Category(title: null).table);
    for (final item in values) {
      categories.add(Category.fromMap(item));
    }
    return categories;
  }

  static Future<Category> getById(int id) async => Category.fromMap(
      await DatabaseHelper.instance.getById(Category(title: null).table, id));

  @override
  Future<int> delete() async {
    return DatabaseHelper.instance.delete(id, table);
  }
}
