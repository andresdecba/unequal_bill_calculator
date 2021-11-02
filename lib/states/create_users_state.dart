import 'package:bill_calculator/states/singleton.dart';
import 'package:flutter/material.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/model.dart';

class CreateUsersState extends ChangeNotifier {
  ////////// FORMULARIOS ///////////
  GlobalKey<FormState> userFormKey = GlobalKey<FormState>();
  GlobalKey<FormState> editUserFormKey = GlobalKey<FormState>();

  bool validateEditUserFormKey() {
    return editUserFormKey.currentState?.validate() ?? false;
  }

  bool validateUserFormKey() {
    return userFormKey.currentState?.validate() ?? false;
  }

  ///// PROPIEDADES //////
  final listaUsuarios = Singleton().listaUsuarios;
  final cuentaTotal = Singleton().cuentaTotal;
  final listaServicios = Singleton().listaServicios;

  ////////// USUARIOS ///////////

  ///// CREAR usuario /////
  void crearUsuario({required String usrName}) {
    List<ServicioUsuario> agregarServiciosEsxistentes = [];

    // this is used when a new user is created AFETER the expenses are created
    // then we need to add the existing expeses to the new user
    if (listaServicios.isNotEmpty) {
      listaServicios.map((e) {
        agregarServiciosEsxistentes.add(
          ServicioUsuario(
            servicio: e,
            multiplicarPor: 1,
            aPagar: 0.0,
            isAdded: true,
          ),
        );
        e.dividirPorTodos++;
      }).toList();
    }

    // create user
    listaUsuarios.add(Usuario(
      userNombre: usrName,
      totalAPagar: 0.0,
      totalAPagarByOne: 0.0,
      servicios: agregarServiciosEsxistentes, //[],
      totalDivider: 1,
      isPanelOpen: true,
    ));
    cuentaTotal.dividirPorTodos++;

    // 1- re-calculate bill
    PropinaState().calcularTotal();

    // 2- re-calculate total to pay per user
    CalculateState().calcularTotalPorUsuario();
    CalculateState().calcularTotalGlobal();
    notifyListeners();
  }

  ///// ELIMINAR usuario /////
  void eliminarUsuario({required int index}) {
    listaUsuarios.removeAt(index);
    cuentaTotal.dividirPorTodos--;

    // 1- re-calculate bill
    PropinaState().calcularTotal();

    // 2- re-calculate total to pay per user
    CalculateState().calcularTotalPorUsuario();
    CalculateState().calcularTotalGlobal();
    notifyListeners();
  }

  ///// Editar usuario /////
  void editarUsuario({required int index, required String nombre}) {
    listaUsuarios[index].userNombre = nombre;
    notifyListeners();
  }
}
