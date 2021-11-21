import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

class CreateUsersScreenState extends ChangeNotifier {
  ////////// FORMULARIOS ///////////
  GlobalKey<FormState> createUserFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editUserFormKey = GlobalKey<FormState>();

  bool validateEditUserFormKey() {
    return editUserFormKey.currentState?.validate() ?? false;
  }

  bool validateCreateUserFormKey() {
    return createUserFormKey.currentState?.validate() ?? false;
  }

  ///// PROPIEDADES //////
  final usersBox = Singleton().usersBOX;
  final expensesBox = Singleton().expensesBOX;
  final userExpensesBox = Singleton().userExpensesBOX;
  final bill = Singleton().billBOX.values.first;

  ////////// USUARIOS ///////////

  ///// CREAR usuario /////
  void crearUsuario({required String usrName}) {
    // create user
    UserModel newUser = UserModel(
      userName: usrName,
      totalToPay: 0.0,
      totalToPayByExpense: 0.0,
      userExpensesList2: HiveList<UserExpenseModel>(userExpensesBox),
      totalDivider: 1,
      //the first person in the list has its panel open, the rest its close
      isPanelOpen: usersBox.isEmpty ? true : false,
    );

    // agregarlo al box de usuarios
    usersBox.add(newUser);

    // increment and save bill counter
    bill.divideByAllUsers++;
    bill.save();

    // this is used when a new user is created **AFTER the expenses are created**
    // then we need to add the existing expeses to the new user
    if (expensesBox.isNotEmpty) {
      //
      expensesBox.values.map((expense) async {
        // create new userExpese instance
        UserExpenseModel newUserExpense = UserExpenseModel(
          expense: expense,
          multiplyBy: 1,
          toPay: 0.0,
          isAdded: true,
        );

        // add userExpense to box
        userExpensesBox.add(newUserExpense);

        // add userExpense to the new user
        newUser.userExpensesList2.add(newUserExpense);
        newUser.save();

        // increment expense counter
        expense.divideByAll++;
        expense.save();
      }).toList();
    }

    // make the whole calculations
    calculations();
    notifyListeners();
  }

  ///// ELIMINAR usuario /////
  void eliminarUsuario({required UserModel user}) {
    // delete user
    user.delete();

    // decremente users count
    bill.divideByAllUsers--;
    bill.save();

    // 1- re-calculate bill
    CalculateAllState().calculateAll();

    // make the whole calculations
    calculations();
    notifyListeners();
  }

  ///// Editar usuario /////
  void editarUsuario({required UserModel user, required String newName}) {
    user.userName = newName;
    user.save();
    notifyListeners();
  }

  // make the whole calculations
  void calculations() async {
    // re-calculate these:
    await CalculateAllState().calculateAll();
    await CalculateScreenState().calcularTotalPorItem();
    await CalculateScreenState().calcularTotalGlobal();
  }

  //// reset app ////
  void reset() async {
    await Singleton().usersBOX.clear();
    await Singleton().expensesBOX.clear();
    await Singleton().userExpensesBOX.clear();
    await Singleton().billBOX.clear();
    notifyListeners();
  }
}
