import 'dart:convert';

import 'package:flutter/material.dart';

import '../database/tables/expenses_table.dart';
import 'model_base.dart';

class ExpensesModel extends ModelBase {
  final double value;
  final DateTime date;
  final int category;

  ExpensesModel(
      {int id,
      @required String title,
      @required this.value,
      @required this.category,
      @required this.date})
      : super(id: id, title: title);

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date?.millisecondsSinceEpoch,
      'category': category
    };
  }

  String toJson() => json.encode(toMap());
  factory ExpensesModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ExpensesModel(
      id: map['id'] as int,
      title: map['title'] as String,
      value: double.tryParse(map['value']) ?? 0.0,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      category: map['category'] as int,
    );
  }

  factory ExpensesModel.fromJson(String source) =>
      ExpensesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String get table => ExpensesTable.table;
}