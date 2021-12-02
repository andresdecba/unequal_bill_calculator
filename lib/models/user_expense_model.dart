import 'package:hive/hive.dart';

import 'package:bill_calculator/models/models.dart';

part 'user_expense_model.g.dart';

@HiveType(typeId: 1)
class UserExpenseModel extends HiveObject {
  UserExpenseModel({
    required this.userExpenseExpense,
    required this.userExpenseByItemFactor,
    required this.userExpenseTotal,
  });

  @HiveField(0)
  HiveList<ExpenseModel> userExpenseExpense; /////// CONVERTIR ESTA PROPIEDAD A UN HIVE LISTTTTTTTT
  @HiveField(1)
  int userExpenseByItemFactor;
  @HiveField(2)
  double userExpenseTotal;
  // @HiveField(3)
  // bool isAdded;

  @override
  String toString() {
    return '$userExpenseExpense, UEF: $userExpenseByItemFactor, A pagar: $userExpenseTotal /';
  }
}

/*
***ABOUT THIS MODEL***
Este modelo es necesario para hacer el calculo por item

***ABOUT FIELDS***
userExpenseExpense: el gasto asociado.
userExpenseByItemFactor: multiplicador (expense.price / expense.divider) * userExpenseByItemFactor = userExpenseTotal.
userExpenseTotal: total a pagar por este item segun el calculo anterior


*/
