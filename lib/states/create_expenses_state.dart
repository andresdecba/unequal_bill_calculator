import 'package:flutter/material.dart';
import 'package:bill_calculator/model.dart';
import 'package:bill_calculator/states/singleton.dart';
import 'package:bill_calculator/states/states.dart';

class CreateExpensesState extends ChangeNotifier {
  //////////// FORMULARIOS ////////////
  GlobalKey<FormState> cuentasFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editCuentasFormKey = GlobalKey<FormState>();

  bool validateCuentasFormKey() {
    return cuentasFormKey.currentState?.validate() ?? false;
  }

  bool validateEditCuentasFormKey() {
    return editCuentasFormKey.currentState?.validate() ?? false;
  }

  //////////// PROPIEDADES ////////////
  final listaServicios = Singleton().listaServicios;
  final listaUsuarios = Singleton().listaUsuarios;

  //// create expense
  void crearServicio({required String servicioNombre, required double precioServ}) {
    // create ID
    var id = DateTime.now().toString();

    //create new expense
    Servicio newExpense = Servicio(
      servicioNombre: servicioNombre,
      precio: precioServ,
      dividirPorTodos: 0,
      id: id,
    );
    //add to the expenses list
    listaServicios.add(newExpense);

    //add new expense to each user's expenses list
    listaUsuarios.forEach((user) {
      user.servicios.add(
        ServicioUsuario(
          servicio: newExpense,
          multiplicarPor: 1,
          aPagar: 0.0,
          isAdded: true,
        ),
      );
      newExpense.dividirPorTodos++;
    });

    // 1 - calculate TOTAL BILL to pay
    PropinaState().calcularTotal();

    // 2 - re-calculate totals to pay per user
    CalculateState().calcularTotalGlobal();
    CalculateState().calcularTotalPorUsuario();

    notifyListeners();
  }

  //// remove expense
  void eliminarServicio({required int index}) {
    // remove expense to expenses list
    listaServicios.removeAt(index);

    // get THIS expense index from the expenses list
    listaUsuarios.forEach((user) {
      user.servicios.removeAt(index);
    });

    // 1- re-calculate bill
    PropinaState().calcularTotal();

    // 2- re-calculate total to pay per user
    CalculateState().calcularTotalPorUsuario();
    CalculateState().calcularTotalGlobal();

    notifyListeners();
  }

  //// edit expense values
  void editarServicio({required int index, required String serviceName, required double servicePrice}) {
    if (serviceName != '') {
      listaServicios[index].servicioNombre = serviceName;
    }

    if (servicePrice != 0.0) {
      listaServicios[index].precio = servicePrice;
      PropinaState().calcularTotal();
    }

    // 1- re-calculate bill
    PropinaState().calcularTotal();

    // 2- re-calculate total to pay per user
    CalculateState().calcularTotalPorUsuario();
    CalculateState().calcularTotalGlobal();

    notifyListeners();
  }
}
