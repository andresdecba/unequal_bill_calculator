import 'dart:math';
import 'package:bill_calculator/states/singleton.dart';
import 'package:flutter/material.dart';

class CalculateState extends ChangeNotifier {
  CalculateState() {
    calcularTotalGlobal();
    calcularTotalPorUsuario();
  }

  ///// PROPIEDADES //////
  final listaUsuarios = Singleton().listaUsuarios;
  final cuentaTotal = Singleton().cuentaTotal;
  final listaServicios = Singleton().listaServicios;

  ///////////////////////////////// CALCULAR TOTAL POR USUARIO GLOBALMENTE /////////////////////////////////

  ///// sumar multiplicador //////
  void sumarTotal({required indexUsuario}) {
    listaUsuarios[indexUsuario].totalDivider++;
    cuentaTotal.dividirPorTodos++;
    calcularTotalGlobal();
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarTotal({required indexUsuario}) {
    //limitar contador a cero o mayor
    if (listaUsuarios[indexUsuario].totalDivider != 0) {
      listaUsuarios[indexUsuario].totalDivider--;
    }
    cuentaTotal.dividirPorTodos--;
    calcularTotalGlobal();
    notifyListeners();
  }

  ///// calcular totales por usuario globalmente //////
  void calcularTotalGlobal() {
    for (var user in listaUsuarios) {
      double total = (cuentaTotal.totalAPagar / cuentaTotal.dividirPorTodos) * user.totalDivider;

      //redondeo
      num mod = pow(10.0, 1);
      user.totalAPagar = ((total * pow(10.0, 1)).round().toDouble() / mod);
    }
  }

  ///////////////////////////////// CALCULAR TOTAL POR CADA CUENTA DE USUARIO /////////////////////////////////

  ///// sumar multiplicador //////
  void sumarMultiplicador({required indexUsuario, required indexServicio}) {
    listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor++;
    listaUsuarios[indexUsuario].servicios[indexServicio].servicio.dividirPorTodos++;
    calcularTotalPorUsuario();
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarMultiplicador({required indexUsuario, required indexServicio}) {
    if (listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor != 0) {
      listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor--;
      listaUsuarios[indexUsuario].servicios[indexServicio].servicio.dividirPorTodos--;
    }
    calcularTotalPorUsuario();
    notifyListeners();
  }

  ///// calcular totales por usuario  //////
  void calcularTotalPorUsuario() {
    // Calcular servicios asignados: ( precio servicio / divisor global) * su multiplicador y redondear
    for (var usuario in listaUsuarios) {
      double totalPorUsuario = 0;

      for (var servicio in usuario.servicios) {
        double calculo = (servicio.servicio.precio / servicio.servicio.dividirPorTodos) * servicio.multiplicarPor;

        num mod = pow(10.0, 1);
        servicio.aPagar = ((calculo * pow(10.0, 1)).round().toDouble() / mod);

        totalPorUsuario += servicio.aPagar;
      }
      usuario.totalAPagarByOne = totalPorUsuario;

      //(cuentaTotal.totalAPagar / cuentaTotal.dividirPorTodos) * usuario.totalDivider;
    }
  }
}
