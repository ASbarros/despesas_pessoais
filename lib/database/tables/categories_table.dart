class CategoriesTable {
  static String get table => 'categories';
  final _columnId = 'id';
  final _columnTitle = 'title';

  String get query => '''
    CREATE TABLE $table (
      $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
      $_columnTitle TEXT NOT NULL
    )''';
}
