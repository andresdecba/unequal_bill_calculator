import 'dart:math';
import 'package:flutter/material.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

class CalculateScreenState extends ChangeNotifier {
  //
  ///// PROPIEDADES //////
  final usersBox = Singleton().usersBOX;
  final expensesBox = Singleton().expensesBOX;
  final bill = Singleton().billBOX.values.first;

  // progress indicator used while is calculating
  bool isLoading = false;

  ///////////////////////////////// CALCULAR TOTAL POR USUARIO GLOBALMENTE /////////////////////////////////

  ///// sumar multiplicador //////
  void sumarTotal({required UserModel user}) async {
    isLoading = true;
    notifyListeners();

    user.totalDivider++;
    await user.save();

    bill.usersLenght++;
    await bill.save();
    await calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarTotal({required UserModel user}) async {
    isLoading = true;
    notifyListeners();

    // limit counter to zero and at least one user is set to 1
    if (user.totalDivider != 0 && bill.usersLenght != 1) {
      user.totalDivider--;
      await user.save();
      bill.usersLenght--;
      await bill.save();
    }
    await calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// calcular totales por usuario globalmente //////
  calcularTotalGlobal() async {
    for (var user in usersBox.values) {
      //
      double total = (bill.totalToPay / bill.usersLenght) * user.totalDivider;

      //redondeo
      num mod = pow(10.0, 1);
      user.totalToPay = ((total * pow(10.0, 1)).round().toDouble() / mod);
      await user.save();
    }
    // calculate rounding difference;
    roundingDiferenceTOTAL();
  }

  void roundingDiferenceTOTAL() async {
    //
    double totalDeUsuarios = 0.0;

    for (var user in usersBox.values) {
      totalDeUsuarios += user.totalToPay;
    }

    bill.roundingDifferenceTOTAL = totalDeUsuarios - bill.totalToPay;
    await bill.save();
    notifyListeners();
  }

  ///////////////////////////////// CALCULAR TOTAL POR CADA GASTO DE USUARIO /////////////////////////////////

  ///// sumar multiplicador //////
  void sumarMultiplicador({required UserExpenseModel userExpense}) async {
    isLoading = true;
    notifyListeners();

    userExpense.multiplyBy++;
    userExpense.expense.expenseApportionment++;
    await userExpense.save();
    await calcularTotalPorItem();

    isLoading = false;
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarMultiplicador({required UserExpenseModel userExpense}) async {
    //
    isLoading = true;
    notifyListeners();

    // validar que no baje de cero y que AL MENOS UN USUARIO tenga el gasto seteado en 1
    if (userExpense.multiplyBy != 0 && userExpense.expense.expenseApportionment != 1) {
      userExpense.multiplyBy--;
      await userExpense.save();
      userExpense.expense.expenseApportionment--;
      await userExpense.expense.save();
    }
    await calcularTotalPorItem();

    isLoading = false;
    notifyListeners();
  }

  ///// calcular totales por item  //////
  calcularTotalPorItem() async {
    for (var user in usersBox.values) {
      // total
      double totalPerUser = 0;

      for (var userExpense in user.userExpensesList2) {
        // total per expense
        double total = (userExpense.expense.expensePrice / userExpense.expense.expenseApportionment) * userExpense.multiplyBy;
        // rounding
        num mod = pow(10.0, 1);
        userExpense.toPay = ((total * pow(10.0, 1)).round().toDouble() / mod);
        // add up
        totalPerUser += userExpense.toPay;
      }

      // asign and save
      user.totalToPayByExpense = totalPerUser;
      await user.save();
    }
    // calculate rounding difference;
    roundingDiderenceITEM();
  }

  void roundingDiderenceITEM() async {
    //
    double total = 0.0;

    for (var user in usersBox.values) {
      total += user.totalToPayByExpense;
    }

    bill.roundingDifferenceITEM = total - bill.totalToPay;
    await bill.save();
    notifyListeners();
  }

  ///////////////////////////////// RESET DIVIDERS /////////////////////////////////

  resetDividers() async {
    for (var user in usersBox.values) {
      user.totalDivider = 1;

      for (var item in user.userExpensesList2) {
        item.multiplyBy = 1;
        item.expense.expenseApportionment = usersBox.length;
        await item.save();
        await item.expense.save();
      }

      await user.save();
    }

    bill.usersLenght = usersBox.length;
    await bill.save();

    await calcularTotalPorItem();
    await calcularTotalGlobal();
    notifyListeners();
  }
}
