import 'package:bill_calculator/models/models.dart';
import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  UserModel({
    required this.userName,
    required this.userTotalByGlobal,
    required this.userTotalByItem,
    required this.userPanelState,
    required this.userByGlobalFactor,
    required this.userExpensesList,
  });

  @HiveField(0)
  bool userPanelState;
  @HiveField(1)
  String userName;
  @HiveField(2)
  double userTotalByGlobal;
  @HiveField(3)
  double userTotalByItem;
  @HiveField(4)
  int userByGlobalFactor;
  // @HiveField(5)
  // List<UserExpenseModel> userExpensesList;
  @HiveField(6)
  HiveList<UserExpenseModel> userExpensesList;

  @override
  String toString() {
    return '$userName, global: \$$userTotalByGlobal, item: \$$userByGlobalFactor, UGF: $userByGlobalFactor, $userExpensesList ///';
  }
}

/*
***ABOUT THIS MODEL***
La informacion del usuario lo que debe pagar

***ABOUT FIELDS***
userName: nombre del usuario.
userPanelState: estado (abierto o cerrado) de la pestaña que muestra los gastos de cada usuario.
userTotalByGlobal: es lo que paga el usuario dividiendo el global de la cuenta.
userTotalByItem: es lo que paga el usuario dividiendo la cuenta por items.
userByGlobalDivider: se usa para calcular el userTotalByGlobal (la suma de todos los gastos / userByGlobalDivider = userTotalByGlobal).
userExpensesList: una lista con todos los gastos y los elementos para calcular el total por item


*/
