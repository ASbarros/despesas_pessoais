import 'dart:async';

abstract class ObjectBase {
  Map<String, Object> toMap();
  String get table;
  Future<int> insert();
  Future<int> update();
  Future<int> delete();
}
