import 'package:financas_pessoais/models/category_model.dart';

class CategoryData {
  static var items = [
    CategoryModel(title: 'economias', id: 1).toMap(),
    CategoryModel(title: 'essencial', id: 2).toMap(),
    CategoryModel(title: 'investimentos', id: 3).toMap(),
    CategoryModel(title: 'lazer', id: 4).toMap(),
    CategoryModel(title: 'moto', id: 5).toMap(),
  ];
}
