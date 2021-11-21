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
  void crearServicio({required String servicioNombre, required double precioServ}) {
    //
    //create new expense
    ExpenseModel newExpense = ExpenseModel(
      expenseName: servicioNombre,
      price: precioServ,
      divideByAll: 0,
    );

    //add to the expenses box
    expensesBox.add(newExpense);

    //add the new expense to each user's expenses list
    usersBox.values.forEach((user) {
      //
      // create new userExpesen instance
      UserExpenseModel newUserExpense = UserExpenseModel(
        expense: newExpense,
        multiplyBy: 1,
        toPay: 0.0,
        isAdded: true,
      );

      // increment counter
      newExpense.divideByAll++;
      newExpense.save();

      // add to box
      userExpensesBox.add(newUserExpense);

      // add to user
      user.userExpensesList2.add(newUserExpense);
    });

    // make the whole calculations
    calculations();
    notifyListeners();
  }

  //// remove expense
  void eliminarServicio({required ExpenseModel expense}) {
    //
    // remove THIS expense from the user expenses box
    userExpensesBox.values.forEach((element) {
      if (element.expense == expense) {
        element.delete();
      }
    });

    // remove expense to expenses box
    expense.delete();

    // make the whole calculations
    calculations();
    notifyListeners();
  }

  //// edit expense values
  void editarServicio({required ExpenseModel expense, required String serviceName, required double servicePrice}) {
    if (serviceName != '') {
      expense.expenseName = serviceName;
    }

    if (servicePrice != 0.0) {
      expense.price = servicePrice;
      CalculateAllState().calculateAll();
    }

    expense.save();

    // make the whole calculations
    calculations();
    notifyListeners();
  }

  // make the whole calculations
  void calculations() async {
    // re-calculate these:
    await CalculateAllState().calculateAll();
    await CalculateScreenState().calcularTotalPorItem();
    await CalculateScreenState().calcularTotalGlobal();
  }
}
