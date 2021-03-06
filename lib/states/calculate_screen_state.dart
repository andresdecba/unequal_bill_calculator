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
  void sumarTotal({UserModel user}) async {
    isLoading = true;
    notifyListeners();

    user.userByGlobalFactor++;
    await user.save();

    bill.billDivider++;
    await bill.save();
    await calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarTotal({UserModel user}) async {
    isLoading = true;
    notifyListeners();

    // limit counter to zero and at least one user is set to 1
    if (user.userByGlobalFactor != 0 && bill.billDivider != 1) {
      user.userByGlobalFactor--;
      await user.save();
      bill.billDivider--;
      await bill.save();
    }
    await calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// calcular totales por usuario globalmente //////
  calcularTotalGlobal() async {
    // loop
    for (var user in usersBox.values) {
      // calculate
      double total = (bill.billTotal / bill.billDivider) * user.userByGlobalFactor;
      // round
      user.userTotalByGlobal = rounder(total);
      // save
      await user.save();
    }
    // calculate rounding difference;
    roundingDiferenceTOTAL();
  }

  void roundingDiferenceTOTAL() async {
    //
    double value = 0.0;
    for (var user in usersBox.values) {
      value += user.userTotalByGlobal;
    }
    bill.billRoundingDifferenceByTotal = value - bill.billTotal;
    await bill.save();
    notifyListeners();
  }

  ///////////////////////////////// CALCULAR POR ITEM /////////////////////////////////

  ///// incrementar item factor //////
  void sumarItem({UserExpenseModel userExpense}) async {
    isLoading = true;
    notifyListeners();

    userExpense.userExpenseByItemFactor++;
    await userExpense.save();

    userExpense.userExpenseExpense.first.expenseDivider++;
    await userExpense.userExpenseExpense.first.save();
    await calcularTotalPorItem();

    isLoading = false;
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarItem({UserExpenseModel userExpense}) async {
    //
    isLoading = true;
    notifyListeners();

    // validar que no baje de cero y que AL MENOS UN USUARIO tenga el gasto seteado en 1
    if (userExpense.userExpenseByItemFactor != 0 && userExpense.userExpenseExpense.first.expenseDivider != 1) {
      userExpense.userExpenseByItemFactor--;
      await userExpense.save();
      userExpense.userExpenseExpense.first.expenseDivider--;
      await userExpense.userExpenseExpense.first.save();
    }
    await calcularTotalPorItem();

    isLoading = false;
    notifyListeners();
  }

  ///// calcular totales por item  //////
  calcularTotalPorItem() async {
    //
    // loop

    for (var user in usersBox.values) {
      // total
      double totalPerUser = 0;

      for (var userExpense in user.userExpensesList) {
        // total per expense
        double itemTotal = (userExpense.userExpenseExpense.first.expensePrice / userExpense.userExpenseExpense.first.expenseDivider) * userExpense.userExpenseByItemFactor;
        // rounding, asign and save
        userExpense.userExpenseTotal = rounder(itemTotal);
        await userExpense.save();
        // acumular
        totalPerUser += userExpense.userExpenseTotal;
      }

      // asign and save
      user.userTotalByItem = rounder(totalPerUser);
      await user.save();
      notifyListeners();
    }
    //calculate rounding difference;
    roundingDiderenceITEM();
  }

  void roundingDiderenceITEM() async {
    //
    double value = 0.0;
    for (var user in usersBox.values) {
      value += user.userTotalByItem;
    }
    bill.billRoundingDifferenceByItem = value - bill.billTotal;
    await bill.save();
    notifyListeners();
  }

  ///////////////////////////////// RESET DIVIDERS /////////////////////////////////

  resetDividers() async {
    await usersBox.compact();
    await expensesBox.compact();

    for (var user in usersBox.values) {
      user.userByGlobalFactor = 1;

      for (var item in user.userExpensesList) {
        item.userExpenseByItemFactor = 1;
        await item.save();
        item.userExpenseExpense.first.expenseDivider = usersBox.length;
        await item.userExpenseExpense.first.save();
      }

      await user.save();
    }

    bill.billDivider = usersBox.values.length;
    await bill.save();

    await calcularTotalPorItem();
    await calcularTotalGlobal();
    notifyListeners();
  }
}
