import 'package:hive/hive.dart';

import 'package:bill_calculator/models/models.dart';

part 'user_expense_model.g.dart';

@HiveType(typeId: 1)
class UserExpenseModel extends HiveObject {
  UserExpenseModel({
    required this.expense,
    required this.multiplyBy,
    required this.toPay,
    required this.isAdded,
  });

  @HiveField(0)
  ExpenseModel expense;
  @HiveField(1)
  int multiplyBy;
  @HiveField(2)
  double toPay;
  @HiveField(3)
  bool isAdded;

  @override
  String toString() {
    return '++ Servicio: $expense, Multiplicar por: $multiplyBy, A pagar: $toPay ++';
  }
}
