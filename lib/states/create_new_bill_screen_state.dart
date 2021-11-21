import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';

class CreateNewBillScreenState extends ChangeNotifier {
  //
  //// TEXT FORM THINGS
  GlobalKey<FormState> newBillTitleKey = GlobalKey<FormState>();
  bool validateNewBillTitle() {
    return newBillTitleKey.currentState?.validate() ?? false;
  }

  ///// FIELDS //////
  final bill = Singleton().billBOX;

  //// CREATE A NEW BILL ////
  createNewBill({String? billName}) {
    //
    // default name
    DateTime now = DateTime.now();
    String dateToday = 'Nueva_cuenta: ${DateFormat('dd-MM-yyyy – kk:mm').format(now)}';

    // create new bill
    var newApp = BillModel(
      subtotalToPay: 0.0,
      propina: 0.0,
      totalToPay: 0.0,
      divideByAllUsers: 0,
      totalPayersInTotalDivider: 0,
      roundingDifferenceTOTAL: 0,
      roundingDifferenceITEM: 0,
      billName: billName != null ? billName : dateToday,
    );

    // save it in the box
    bill.add(newApp);
  }
}
