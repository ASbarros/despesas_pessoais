abstract class ModelBase {
  int id;
  String title;
  Map<String, dynamic> toMap();
  String get table;
  ModelBase({this.id, this.title});
}
