import 'dart:convert';

import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../database/tables/expenses_table.dart';
import 'category.dart';
import 'object_base.dart';

class Transaction extends ObjectBase {
  final int id;
  final String title;
  final double value;
  final DateTime date;
  final int category;

  Transaction(
      {this.id,
      @required this.title,
      @required this.value,
      @required this.category,
      @required this.date});

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
  factory Transaction.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Transaction(
      id: map['id'],
      title: map['title'],
      value: double.parse(map['value']),
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      category: map['category'],
    );
  }

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));

  @override
  String get table => ExpensesTable().table;

  @override
  Future<int> insert() async {
    return await DatabaseHelper.instance.insert(this);
  }

  @override
  Future<int> update() async {
    return await DatabaseHelper.instance.update(this, id);
  }

  static Future<List<Transaction>> getAll() async {
    final transactions = <Transaction>[];
    final values = await DatabaseHelper.instance.getAll(
        Transaction(category: null, date: null, title: null, value: null)
            .table);
    for (var item in values) {
      await transactions.add(Transaction.fromMap(item));
    }

    return transactions;
  }

  @override
  Future<int> delete() async {
    return await DatabaseHelper.instance.delete(id, table);
  }
}
