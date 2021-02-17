import 'dart:convert';

class ChartPieDataModel {
  final String category;
  double totalValue;
  ChartPieDataModel({
    this.category,
    this.totalValue,
  });

  @override
  String toString() =>
      'ChartPieDataModel(category: $category, totalValue: $totalValue)';

  Map<String, dynamic> toMap() {
    return {
      'category': category,
      'totalValue': totalValue,
    };
  }

  factory ChartPieDataModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ChartPieDataModel(
      category: map['category'],
      totalValue: map['totalValue'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChartPieDataModel.fromJson(String source) =>
      ChartPieDataModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ChartPieDataModel && o.category == category;
  }

  @override
  int get hashCode => category.hashCode ^ totalValue.hashCode;
}
