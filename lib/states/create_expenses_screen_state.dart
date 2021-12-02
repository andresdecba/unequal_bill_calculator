import 'package:flutter/material.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:hive/hive.dart';

class CreateExpensesScreenState extends ChangeNotifier {
  //////////// FORMULARIOS ////////////
  GlobalKey<FormState> cuentasFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editCuentasFormKey = GlobalKey<FormState>();

  bool validateCuentasFormKey() {
    return cuentasFormKey.currentState?.validate() ?? false;
  }

  bool validateEditCuentasFormKey() {
    return editCuentasFormKey.currentState?.validate() ?? false;
  }

  //////////// ANIMATION KEY ////////////
  final GlobalKey<AnimatedListState> expAnimatedListKey = GlobalKey();

  //////////// PROPIEDADES ////////////
  final usersBox = Singleton().usersBOX;
  final expensesBox = Singleton().expensesBOX;
  final userExpensesBox = Singleton().userExpensesBOX;

  //// create expense
  void createExpense({required String expenseName, required double expensePrice}) async {
    //
    //create new expense
    ExpenseModel newExpense = ExpenseModel(
      expenseName: expenseName,
      expensePrice: expensePrice,
      expenseDivider: 0,
    );

    //store in expenses box
    await expensesBox.add(newExpense);

    // Animate list
    ///// "insertItem(expensesBox.length - 1)" indica la pocision desde donde va a 'nacer' el nuevo item
    ///// y comienza a contar desde 1 y no desde 0... me volví loco hasta descubrir esto :C
    expAnimatedListKey.currentState?.insertItem(expensesBox.length - 1);

    //add the new expense to each user's expenses list
    for (var user in usersBox.values) {
      // create new userExpese instance
      UserExpenseModel newUserExpense = UserExpenseModel(
        userExpenseExpense: HiveList<ExpenseModel>(expensesBox),
        userExpenseByItemFactor: 1,
        userExpenseTotal: 0.0,
      );
      // add newExpense to newUserExpense HIVE LIST
      newUserExpense.userExpenseExpense.add(newExpense);

      // store in user expenses box
      await userExpensesBox.add(newUserExpense);

      // add to user
      user.userExpensesList.add(newUserExpense);
      user.save();

      // increment expense divider
      newExpense.expenseDivider++;
      await newExpense.save();
    }

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  //// remove expense
  void deleteExpense({required ExpenseModel expense}) async {
    //
    //remove THIS expense from the user expenses box
    for (var item in userExpensesBox.values) {
      if (item.userExpenseExpense == expense) {
        await item.delete();
      }
    }

    // remove expense to expenses box
    await expense.delete();

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  //// edit expense values
  void editarServicio({required ExpenseModel expense, required String serviceName, required double servicePrice}) async {
    //
    if (serviceName != '') {
      expense.expenseName = serviceName;
    }

    if (servicePrice != 0.0) {
      expense.expensePrice = servicePrice;
      await CalculateAllState().calculateAll();
    }

    await expense.save();

    // make the whole calculations
    await calculations();
    notifyListeners();
  }
}
