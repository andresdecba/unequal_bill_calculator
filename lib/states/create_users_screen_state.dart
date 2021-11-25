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
      userTotalByGlobal: 0.0,
      userTotalByItem: 0.0,
      userExpensesList: HiveList<UserExpenseModel>(userExpensesBox),
      userByGlobalFactor: 1,
      //the first person in the list has its panel open, the rest its close
      userPanelState: usersBox.isEmpty ? true : false,
    );

    // agregarlo al box de usuarios
    await usersBox.add(newUser);

    // increment and save bill counter
    bill.billDivider++;
    await bill.save();

    // this is used when a new user is created **AFTER the expenses are created**
    // then we need to add the existing expeses to the new user
    if (expensesBox.isNotEmpty) {

      for (var expense in expensesBox.values) {

        // create new userExpese instance
        UserExpenseModel newUserExpense = UserExpenseModel(
          userExpenseExpense: expense,
          userExpenseByItemFactor: 1,
          userExpenseTotal: 0.0,
        );

        // add userExpense to box
        await userExpensesBox.add(newUserExpense);

        // add userExpense to the new user
        newUser.userExpensesList.add(newUserExpense);
        await newUser.save();

        // increment expenseDivider
        expense.expenseDivider++;
        await expense.save(); 
      }
    }

    // make the whole calculations
    await calculations();
    notifyListeners();
  }

  ///// ELIMINAR usuario /////
  eliminarUsuario({required UserModel user}) async {
    //
    // decremente billDivider used for global calculations
    bill.billDivider = bill.billDivider - user.userByGlobalFactor;
    await bill.save();

    // decrement each expense´s expenseDivider used for item calculation
    for (var item in user.userExpensesList) {
      item.userExpenseExpense.expenseDivider = item.userExpenseExpense.expenseDivider - item.userExpenseByItemFactor;
      item.userExpenseExpense.save();
    }

    //remove user userExpenses from the userExpensesBox
    for (var boxItem in userExpensesBox.values) {
      for (var userItem in user.userExpensesList) {
        if (boxItem == userItem) {
          await boxItem.delete();
        }
      }
    }

    // delete user
    user.delete();

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
}
