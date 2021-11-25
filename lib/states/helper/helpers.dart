import 'dart:math';
import 'package:intl/intl.dart';

import 'package:bill_calculator/states/states.dart';

// round some number
double rounder(double value) {
  num mod = pow(10.0, 1);
  double result = ((value * pow(10.0, 1)).round().toDouble() / mod);
  return result;
}

// generate date
String getDate() {
  DateTime now = DateTime.now();
  String dateToday = '${DateFormat('dd-MM-yyyy · kk:mm').format(now)}';
  return dateToday;
}

// make the whole calculations
calculations() async {
  // re-calculate these:
  await CalculateAllState().calculateAll();
  await CalculateScreenState().calcularTotalGlobal();
  await CalculateScreenState().calcularTotalPorItem();
}
