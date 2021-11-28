import 'package:flutter/material.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

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

    

    //add the new expense to each user's expenses list
    for (var user in usersBox.values) {

      // create new userExpese instance
      UserExpenseModel newUserExpense = UserExpenseModel(
        userExpenseExpense: newExpense,
        userExpenseByItemFactor: 1,
        userExpenseTotal: 0.0,
      );
      
      // store in user expenses box
      await userExpensesBox.add(newUserExpense);

      // add to user
      user.userExpensesList.add(newUserExpense);

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
