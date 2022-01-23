import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 2)
class ExpenseModel extends HiveObject {
  ExpenseModel({
    this.expenseName,
    this.expensePrice,
    this.expenseDivider,
  });

  @HiveField(0)
  String expenseName;
  @HiveField(1)
  double expensePrice;
  @HiveField(2)
  int expenseDivider;

  @override
  String toString() {
    return '$expenseName, \$ $expensePrice, ED: $expenseDivider -';
  }
}

/*
***ABOUT THIS MODEL***
En este modelo se muestra la informacion del gasto

***ABOUT FIELDS***
expenseName: nombre del gasto
expencePrice: monto del gasto
expenseDivider: se usa para dividir el monto cuando el usuario hace +1 -1 en el gasto 

*/
