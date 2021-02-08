import 'package:flutter/material.dart';

import 'object_base.dart';

class Category extends ObjectBase {
  final int id;
  final String title;

  Category({this.id, @required this.title});

  @override
  Map<String, Object> toMap() {
    return {'id': id, 'title': title};
  }
}
