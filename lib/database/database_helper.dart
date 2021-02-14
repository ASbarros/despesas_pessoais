import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

import '../models/model_base.dart';
import 'tables/categories_table.dart';
import 'tables/expenses_table.dart';

class DatabaseHelper {
  static const _databaseName = 'personal_expenses6.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _initDatabase();
    }

    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(CategoriesTable().query);
    await db.execute(ExpensesTable().query);
  }

  Future<int> insert(ModelBase obj) async {
    final db = await instance.database;
    final res = await db.insert(obj.table, obj.toMap());
    return res;
  }

  Future<int> update(ModelBase obj, int id) async {
    final db = await instance.database;
    final res = await db
        .update(obj.table, obj.toMap(), where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final db = await instance.database;
    final res = await db.query(table);
    return res;
  }

  Future<Map<String, dynamic>> getById(String table, int id) async {
    final db = await instance.database;
    final res = await db.query(table,
        columns: ['*'], where: 'id = ?', whereArgs: [id], limit: 1);
    return res[0];
  }

  Future<int> delete(int id, String table) async {
    final db = await instance.database;
    return db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTable(String table) async {
    final db = await instance.database;
    return db.rawQuery('DELETE FROM $table');
  }
}
