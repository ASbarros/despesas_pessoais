import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart' hide Transaction;

import '../models/object_base.dart';
import 'tables/expenses_table.dart';

class DatabaseHelper {
  static final _databaseName = 'personal_expenses.db';
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    var path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(ExpensesTable().query);
  }

  Future<int> insert(ObjectBase obj, String table) async {
    var db = await instance.database;
    var res = await db.insert(table, obj.toMap());
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows(String table) async {
    var db = await instance.database;
    var res = await db.query(table);
    return res;
  }

  Future<int> delete(int id, String table) async {
    var db = await instance.database;
    return await db.delete(table, where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearTable(String table) async {
    var db = await instance.database;
    return await db.rawQuery("DELETE FROM $table");
  }
}
