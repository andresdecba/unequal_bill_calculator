import 'package:hive/hive.dart';

part 'expense_model.g.dart';

@HiveType(typeId: 2)
class ExpenseModel extends HiveObject {
  ExpenseModel({
    required this.expenseName,
    required this.price,
    required this.divideByAll,
  });

  @HiveField(0)
  String expenseName;
  @HiveField(1)
  double price;
  @HiveField(2)
  int divideByAll;

  @override
  String toString() {
    return '** Nombre servicio: $expenseName, Precio: $price, Dividir:  $divideByAll';
  }
}
