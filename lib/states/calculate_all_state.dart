import 'package:flutter/material.dart';

import 'package:bill_calculator/states/states.dart';

class CalculateAllState extends ChangeNotifier {
  //
  ////// CALCULATE THE TOTAL BILL //////

  ///// listas de propiedades //////
  final usersBox = Singleton().usersBOX;
  final expensesBox = Singleton().expensesBOX;
  final bill = Singleton().billBOX.values.first;

  ///// calcular la cuenta total //////
  calculateAll() async {
    //
    // calcular total a pagar
    double total = 0;
    for (var item in expensesBox.values) {
      total += item.expensePrice;
    }

    // save to the box
    bill.totalToPay = total;
    await bill.save();
    notifyListeners();
  }
}

///// PROPINA *** NO USADO *** /////

class Propina extends ChangeNotifier {
  ///// formularios
  GlobalKey<FormState> propinaFormKey = GlobalKey<FormState>();

  bool validatePropinaFormKey() {
    return propinaFormKey.currentState?.validate() ?? false;
  }

  ///// listas de propiedades //////
  final usersBox = Singleton().usersBOX;
  final expensesBox = Singleton().expensesBOX;
  final bill = Singleton().billBOX.values.first;

  ///// calcular propina //////
  // mostrar el porcentaje
  int propinaPercent = 0;

  // calcular propina a partir del porcentaje
  double propinaFromPercent = 0.0;

  // poner propina con un monto fijo
  double propinaFromManual = 0.0;

  // decrementar porcentaje
  void restarPorcentaje() {
    propinaPercent--;
    propinaFromPercent = bill.subtotalToPay * propinaPercent / 100;
    notifyListeners();
  }

  // incrementar porcentaje
  void sumarPorcentaje() {
    propinaPercent++;
    propinaFromPercent = bill.subtotalToPay * propinaPercent / 100;
    notifyListeners();
  }

  // asignar la propina al modelo
  void asignarPropina(bool value) {
    // percent == true, manual == false
    if (value == true) {
      bill.tip = propinaFromPercent;
      CalculateAllState().calculateAll();
      notifyListeners();
    } else {
      bill.tip = propinaFromManual;
      CalculateAllState().calculateAll();
      notifyListeners();
    }

    // create a expense from tip
    //createTipAsExpense();
  }

  // crear propina como gasto y agregarlo a cada usuario
  // void createTipAsExpense() {
  //   final Servicio tip = Servicio(
  //     servicioNombre: 'Propina',
  //     precio: cuentaTotal.propina,
  //     dividirPorTodos: listaUsuarios.length,
  //     id: 'PropinaID',
  //   );

  //   listaServicios.add(tip);

  //   for (var user in listaUsuarios) {
  //     user.servicios.add(
  //       ServicioUsuario(servicio: tip, multiplicarPor: 1, aPagar: 0.0, isAdded: true),
  //     );
  //   }

  //   // re calculate everything
  //   CalculateState().calcularTotalPorUsuario();
  //   CalculateState().calculatTotalGlobal();
  //   calcularTotal();
  //   notifyListeners();
  // }

}
