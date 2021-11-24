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
  void crearUsuario({required String usrName}) async {
    //
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
    await usersBox.add(newUser);

    // increment and save bill counter
    bill.usersLenght++;
    await bill.save();

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
        await userExpensesBox.add(newUserExpense);

        // add userExpense to the new user
        newUser.userExpensesList2.add(newUserExpense);
        await newUser.save();

        // increment expense counter
        expense.expenseApportionment++;
        await expense.save();
      }).toList();
    }

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  ///// ELIMINAR usuario /////
  eliminarUsuario({required UserModel user}) async {
    // delete user
    user.delete();

    // decremente users count
    bill.usersLenght--;
    await bill.save();

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  ///// Editar usuario /////
  updateUser({required UserModel user, required String newName}) async {
    user.userName = newName;
    await user.save();
    notifyListeners();
  }

  // make the whole calculations
  calculations() async {
    // re-calculate these:
    await CalculateAllState().calculateAll();
    await CalculateScreenState().calcularTotalPorItem();
    await CalculateScreenState().calcularTotalGlobal();
  }

  

 
}
