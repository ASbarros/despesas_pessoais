class ExpensesTable {
  final table = 'expences';
  final columnId = 'id';
  final columnTitle = 'title';
  final columnValue = 'value';
  final columnDate = 'date';

  String get query => '''CREATE TABLE $table (
      $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $columnTitle TEXT NOT NULL,
      $columnValue TEXT NOT NULL,
      $columnDate INTEGER NOT NULL
    )''';
}
