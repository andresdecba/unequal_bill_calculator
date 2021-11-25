import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

class CreateNewBillScreenState extends ChangeNotifier {

  final bill = Singleton().billBOX.values.first;

  //// CREATE A NEW BILL ////
  createNewBill({String? billName}) async {

    // create new bill
    var newBill = BillModel(
      billSubtotal: 0.0,
      billTip: 0.0,
      billTotal: 0.0,
      billDivider: 0,
      //totalPayersInTotalDivider: 0,
      billRoundingDifferenceByTotal: 0,
      billRoundingDifferenceByItem: 0,
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
