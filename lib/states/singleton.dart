import 'package:hive/hive.dart';

import 'package:bill_calculator/models/models.dart';

////// singleton repositories /////
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  // hive fields
  var usersBOX = Hive.box<UserModel>('USERS-BOX');
  var expensesBOX = Hive.box<ExpenseModel>('EXPENSE-BOX');
  var userExpensesBOX = Hive.box<UserExpenseModel>('USER-EXPENSES-BOX');
  var billBOX = Hive.box<BillModel>('BILL-BOX');
  

}
