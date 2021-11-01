import 'package:bill_calculator/states/singleton.dart';
import 'package:flutter/material.dart';

class PropinaState extends ChangeNotifier {
  ///// formularios
  GlobalKey<FormState> propinaFormKey = GlobalKey<FormState>();

  bool validatePropinaFormKey() {
    return propinaFormKey.currentState?.validate() ?? false;
  }

  ///// listas de propiedades //////
  final listaUsuarios = Singleton().listaUsuarios;
  final listaServicios = Singleton().listaServicios;
  final cuentaTotal = Singleton().cuentaTotal;

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
    propinaFromPercent = cuentaTotal.subTotalAPagar * propinaPercent / 100;
    notifyListeners();
  }

  // incrementar porcentaje
  void sumarPorcentaje() {
    propinaPercent++;
    propinaFromPercent = cuentaTotal.subTotalAPagar * propinaPercent / 100;
    notifyListeners();
  }

  // asignar la propina al modelo
  void asignarPropina(bool value) {
    // percent == true, manual == false
    if (value == true) {
      cuentaTotal.propina = propinaFromPercent;
      calcularTotal();
      notifyListeners();
    } else {
      cuentaTotal.propina = propinaFromManual;
      calcularTotal();
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

  ///// calcular la cuenta total //////
  void calcularTotal() {
    // calcular sub-total
    double subTotal = 0.0;

    for (var item in listaServicios) {
      subTotal += item.precio;
    }

    // calcular total a pagar
    double total = subTotal + cuentaTotal.propina;

    // asignar a modelo
    cuentaTotal.subTotalAPagar = subTotal;
    cuentaTotal.totalAPagar = total;
    notifyListeners();
  }
}
