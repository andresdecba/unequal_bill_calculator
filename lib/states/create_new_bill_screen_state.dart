import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:intl/intl.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

class CreateNewBillScreenState extends ChangeNotifier {
  //
  // create a default name
  String getDate() {    
    DateTime now = DateTime.now();
    String dateToday = '${DateFormat('dd-MM-yyyy · kk:mm').format(now)}';
    return dateToday;
  }

  //// CREATE A NEW BILL ////
  createNewBill({String? billName}) async {
    //
    // create a default name
    // DateTime now = DateTime.now();
    // String dateToday = 'Nueva_cuenta: ${DateFormat('dd-MM-yyyy – kk:mm').format(now)}';

    // create new bill
    var newBill = BillModel(
      subtotalToPay: 0.0,
      tip: 0.0,
      totalToPay: 0.0,
      usersLenght: 0,
      //totalPayersInTotalDivider: 0,
      roundingDifferenceTOTAL: 0,
      roundingDifferenceITEM: 0,
      billName: billName != null ? billName : 'Cuenta nueva (${getDate()})',
    );

    // save it in the box
    await Singleton().billBOX.add(newBill);
  }

  // update bill name
  updateBillName({required String newName}) {
    //
    Singleton().billBOX.values.first.billName = newName;
    Singleton().billBOX.values.first.save();
    notifyListeners();
  }

  //// reset app ////
  Future resetApp(BuildContext context) async {
    // clear
    await Singleton().usersBOX.clear();
    await Singleton().expensesBOX.clear();
    await Singleton().userExpensesBOX.clear();
    await Singleton().billBOX.clear();

    // compact
    await Singleton().usersBOX.compact();
    await Singleton().expensesBOX.compact();
    await Singleton().userExpensesBOX.compact();
    await Singleton().billBOX.compact();

    // i implemented the whole reset app state
    // becouse i did not know how to compact, close and re-open boxes :(
    Phoenix.rebirth(context);
  }
}
