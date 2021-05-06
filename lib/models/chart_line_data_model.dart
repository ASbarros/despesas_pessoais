import 'dart:convert';

class ChartLineDataModel {
  final String category;
  final int idCategory;
  final items = List<_Item>.generate(5, (index) {
    var month = DateTime.now().month - index;
    return _Item(value: 0, month: month);
  });

  ChartLineDataModel({
    required this.category,
    required this.idCategory,
  });

  void addItem(Map<String, dynamic> map) {
    var item = _Item.fromMap(map);

    if (item.month < DateTime.now().month &&
        item.month > DateTime.now().month - 5) {
      items[item.month - 1].value += item.value;
      items.sort((a, b) => a.month.compareTo(b.month));
    }
  }

  List<double> get values => items.map((e) => e.value).toList();
  List<int> get months => items.map((e) => e.month).toList();

  @override
  String toString() =>
      'ChartLineDataModel(category: $category, idCategory: $idCategory)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChartLineDataModel &&
        other.category == category &&
        other.idCategory == idCategory;
  }

  @override
  int get hashCode => category.hashCode ^ idCategory.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'idCategory': idCategory,
    };
  }

  factory ChartLineDataModel.fromMap(Map<String, dynamic> map) {
    return ChartLineDataModel(
      category: map['category'],
      idCategory: map['idCategory'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartLineDataModel.fromJson(String source) =>
      ChartLineDataModel.fromMap(json.decode(source));
}

class _Item {
  double value;
  int month;
  _Item({
    required this.value,
    required this.month,
  });

  @override
  String toString() => '_Item(value: $value, month: $month)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _Item && other.month == month;
  }

  @override
  int get hashCode => value.hashCode ^ month.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'value': value,
      'month': month,
    };
  }

  factory _Item.fromMap(Map<String, dynamic> map) {
    return _Item(
      value: map['value'],
      month: map['month'],
    );
  }

  String toJson() => json.encode(toMap());
}
