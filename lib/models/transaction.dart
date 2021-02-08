import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'object_base.dart';

class Transaction extends ObjectBase {
  final int id;
  final String title;
  final double value;
  final DateTime date;

  Transaction(
      {this.id,
      @required this.title,
      @required this.value,
      @required this.date});

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'value': value,
      'date': date?.millisecondsSinceEpoch,
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
    );
  }

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source));
}
