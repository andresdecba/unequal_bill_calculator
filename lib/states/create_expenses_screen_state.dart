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
  void crearServicio({required String servicioNombre, required double precioServ}) async {
    //
    //create new expense
    ExpenseModel newExpense = ExpenseModel(
      expenseName: servicioNombre,
      expensePrice: precioServ,
      expenseDivider: 0,
    );

    //add to the expenses box
    await expensesBox.add(newExpense);

    //add the new expense to each user's expenses list
    usersBox.values.forEach((user) async {
      //
      // create new userExpesen instance
      UserExpenseModel newUserExpense = UserExpenseModel(
        userExpenseExpense: newExpense,
        userExpenseByItemFactor: 1,
        userExpenseTotal: 0.0,
        
      );

      // increment counter
      newExpense.expenseDivider++;
      await newExpense.save();

      // add to box
      await userExpensesBox.add(newUserExpense);

      // add to user
      user.userExpensesList.add(newUserExpense);
    });

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  //// remove expense
  void eliminarServicio({required ExpenseModel expense}) async {
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
