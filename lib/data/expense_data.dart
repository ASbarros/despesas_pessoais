import 'package:financas_pessoais/models/expenses_model.dart';

class ExpenseData {
  static var items = [
    ExpensesModel(
            id: 1, title: 'title', value: 10, category: 1, date: DateTime.now())
        .toMap(),
    ExpensesModel(
            id: 2,
            title: 'title1',
            value: 10,
            category: 2,
            date: DateTime.parse('2021-02-26'))
        .toMap(),
    ExpensesModel(
            id: 3,
            title: 'title2',
            value: 120,
            category: 3,
            date: DateTime.parse('2021-02-27'))
        .toMap(),
    ExpensesModel(
            id: 4,
            title: 'title3',
            value: 150,
            category: 4,
            date: DateTime.parse('2021-01-27'))
        .toMap(),
    ExpensesModel(
            id: 5,
            title: 'title4',
            value: 300,
            category: 5,
            date: DateTime.parse('2021-03-27'))
        .toMap(),
    ExpensesModel(
            id: 6,
            title: 'title5',
            value: 200,
            category: 1,
            date: DateTime.parse('2021-03-20'))
        .toMap(),
    ExpensesModel(
            id: 7,
            title: 'title6',
            value: 60,
            category: 2,
            date: DateTime.parse('2021-02-15'))
        .toMap(),
    ExpensesModel(
            id: 8,
            title: 'title7',
            value: 40,
            category: 3,
            date: DateTime.parse('2021-01-10'))
        .toMap(),
    ExpensesModel(
            id: 9,
            title: 'title8',
            value: 50,
            category: 4,
            date: DateTime.parse('2021-04-01'))
        .toMap(),
    ExpensesModel(
            id: 10,
            title: 'gasolina',
            value: 30,
            category: 5,
            date: DateTime.parse('2021-04-02'))
        .toMap(),
    ExpensesModel(
            id: 10,
            title: 'investimento em fundos',
            value: 100,
            category: 3,
            date: DateTime.parse('2021-04-23'))
        .toMap(),
  ];
}
