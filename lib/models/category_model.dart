import 'package:flutter/material.dart';

import '../database/tables/categories_table.dart';
import 'model_base.dart';

class CategoryModel extends ModelBase {
  CategoryModel({int id, @required String title}) : super(id: id, title: title);

  @override
  Map<String, Object> toMap() {
    return {'id': id, 'title': title};
  }

  factory CategoryModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryModel(
      id: map['id'] as int,
      title: map['title'] as String,
    );
  }

  @override
  String get table => CategoriesTable.table;
}
