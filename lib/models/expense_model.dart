import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 2)
class ExpenseModel extends HiveObject {
  ExpenseModel({
    required this.expenseName,
    required this.expensePrice,
    required this.expenseApportionment,
  });

  @HiveField(0)
  String expenseName;
  @HiveField(1)
  double expensePrice;
  @HiveField(2)
  int expenseApportionment;

  @override
  String toString() {
    return '** Nombre servicio: $expenseName, Precio: $expensePrice, Dividir:  $expenseApportionment';
  }
}

/*
***ABOUT THIS MODEL***
En este modelo se muestra la informacion del gasto

***ABOUT FIELDS***
expenseName: nombre del gasto
expencePrice: monto del gasto
expenseApportionment: prorrateo del gasto, se usa para dividir el monto del gasto entre la cantidad de usuarios

*/
