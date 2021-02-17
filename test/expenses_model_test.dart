import 'package:financas_pessoais/models/expenses_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('recebendo uma string("19,30") e setando o value, valor experado: 19.30',
      () {
    final expensesModel =
        ExpensesModel(title: null, value: null, category: null, date: null);
    expensesModel.valueOfString = '19,30';
    expect(expensesModel.value, 19.30);
  });
  test(
      'recebendo uma string("1.222,30") e setando o value, valor experado: 1222.30',
      () {
    final expensesModel =
        ExpensesModel(title: null, value: null, category: null, date: null);
    expensesModel.valueOfString = '1.222,30';
    expect(expensesModel.value, 1222.30);
  });
  test('value em string, valor experado: "0,30"', () {
    final expensesModel =
        ExpensesModel(title: null, value: 0.30, category: null, date: null);

    expect(expensesModel.valueFormatted, '0,30');
  });
  test('value em string, valor experado: "1.222,30"', () {
    final expensesModel =
        ExpensesModel(title: null, value: 1222.3, category: null, date: null);

    expect(expensesModel.valueFormatted, '1.222,30');
  });
}
