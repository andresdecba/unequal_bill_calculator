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

  // progress indicator
  bool isLoading = false;

  double roundingDifference = 0;

  ///////////////////////////////// CALCULAR TOTAL POR USUARIO GLOBALMENTE /////////////////////////////////

  ///// sumar multiplicador //////
  void sumarTotal({required indexUsuario}) async {
    isLoading = true;
    notifyListeners();

    //await Future.delayed(const Duration(milliseconds: 1000));
    listaUsuarios[indexUsuario].totalDivider++;
    cuentaTotal.dividirPorTodos++;
    calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// restar multiplicador //////
  void restarTotal({required indexUsuario}) async {
    isLoading = true;
    notifyListeners();

    //await Future.delayed(const Duration(milliseconds: 1000));

    //limitar contador a cero o mayor
    if (listaUsuarios[indexUsuario].totalDivider != 0) {
      listaUsuarios[indexUsuario].totalDivider--;
    }
    cuentaTotal.dividirPorTodos--;
    await calcularTotalGlobal();

    isLoading = false;
    notifyListeners();
  }

  ///// calcular totales por usuario globalmente //////
  Future<void> calcularTotalGlobal() async {
    for (var user in listaUsuarios) {
      double total = (cuentaTotal.totalAPagar / cuentaTotal.dividirPorTodos) * user.totalDivider;

      //redondeo
      num mod = pow(10.0, 1);
      user.totalAPagar = ((total * pow(10.0, 1)).round().toDouble() / mod);
    }
  }

  ///////////////////////////////// CALCULAR TOTAL POR CADA CUENTA DE USUARIO /////////////////////////////////

  ///// sumar multiplicador //////
  sumarMultiplicador({required indexUsuario, required indexServicio}) async {
    isLoading = true;
    notifyListeners();

    //await Future.delayed(const Duration(milliseconds: 1000));
    listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor++;
    listaUsuarios[indexUsuario].servicios[indexServicio].servicio.dividirPorTodos++;
    await calcularTotalPorUsuario();
    isLoading = false;

    notifyListeners();
  }

  ///// restar multiplicador //////
  Future<void> restarMultiplicador({required indexUsuario, required indexServicio}) async {
    isLoading = true;
    notifyListeners();
    //await Future.delayed(const Duration(milliseconds: 1000));

    if (listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor != 0) {
      listaUsuarios[indexUsuario].servicios[indexServicio].multiplicarPor--;
      listaUsuarios[indexUsuario].servicios[indexServicio].servicio.dividirPorTodos--;
    }
    calcularTotalPorUsuario();
    isLoading = false;

    notifyListeners();
  }

  ///// calcular totales por usuario  //////  Future.delayed(Duration(milliseconds: 1000));
  Future<void> calcularTotalPorUsuario() async {
    for (var usuario in listaUsuarios) {
      double totalPorUsuario = 0;

      for (var servicio in usuario.servicios) {
        double calculo = (servicio.servicio.precio / servicio.servicio.dividirPorTodos) * servicio.multiplicarPor;

        num mod = pow(10.0, 1);
        servicio.aPagar = ((calculo * pow(10.0, 1)).round().toDouble() / mod);

        totalPorUsuario += servicio.aPagar;
      }
      usuario.totalAPagarByOne = totalPorUsuario;
    }
    isLoading = false;
  }

  
}
