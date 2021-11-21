import 'package:bill_calculator/models/models.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    required this.userName,
    required this.totalToPay,
    required this.totalToPayByExpense,
    required this.isPanelOpen,
    required this.totalDivider,
    required this.userExpensesList2,
  });

  @HiveField(0)
  bool isPanelOpen;
  @HiveField(1)
  String userName;
  @HiveField(2)
  double totalToPay;
  @HiveField(3)
  double totalToPayByExpense;
  @HiveField(4)
  int totalDivider;
  // @HiveField(5)
  // List<UserExpenseModel> userExpensesList;
  @HiveField(6)
  HiveList<UserExpenseModel> userExpensesList2;

  @override
  String toString() {
    return '/// Nombre usuario: $userName, Total a pagar:  $totalToPay, Servicios: $userExpensesList2 ///';
  }
}
