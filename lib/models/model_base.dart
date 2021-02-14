abstract class ModelBase {
  int id;
  String title;
  Map<String, Object> toMap();
  String get table;
  ModelBase({this.id, this.title});
}
