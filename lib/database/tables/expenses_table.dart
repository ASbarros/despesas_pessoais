class ExpensesTable {
  static String get table => 'expences';
  final _columnId = 'id';
  final _columnTitle = 'title';
  final _columnValue = 'value';
  final _columnDate = 'date';
  final _columnIdCategory = 'category';

  String get query => '''
    CREATE TABLE $table (
      $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnTitle TEXT NOT NULL,
      $_columnValue TEXT NOT NULL,
      $_columnDate INTEGER NOT NULL,
      $_columnIdCategory INTEGER NOT NULL
      
    )''';
}
