// To parse this JSON data, do
// final users = usersFromMap(jsonString);

////////// usuario  //////////
class Usuario {
  Usuario({
    required this.userNombre,
    required this.totalAPagar,
    required this.totalAPagarByOne,
    required this.servicios,
    required this.isPanelOpen,
    required this.totalDivider,
  });

  bool isPanelOpen;
  String userNombre;
  double totalAPagar;
  double totalAPagarByOne;
  int totalDivider;
  List<ServicioUsuario> servicios;

  @override
  String toString() {
    return '/// Nombre usuario: $userNombre, Total a pagar:  $totalAPagar, Servicios: $servicios ///';
  }
}

////////// lista de servicios que paga el usuario //////////
class ServicioUsuario {
  ServicioUsuario({required this.servicio, required this.multiplicarPor, required this.aPagar, required this.isAdded});

  Servicio servicio;
  int multiplicarPor;
  double aPagar;
  bool isAdded;

  @override
  String toString() {
    return '++ Servicio: $servicio, Multiplicar por: $multiplicarPor, A pagar: $aPagar ++';
  }
}

////////// detalle del servicio  //////////
class Servicio {
  Servicio({
    required this.servicioNombre,
    required this.precio,
    required this.dividirPorTodos,
    required this.id,
  });

  String servicioNombre;
  double precio;
  int dividirPorTodos;
  String id;

  @override
  String toString() {
    return '** Nombre servicio: $servicioNombre, Precio: $precio, Dividir:  $dividirPorTodos, Id: $id **';
  }
}

/////////// calcular el total ///////////

class CuentaTotal {
  CuentaTotal({
    required this.subTotalAPagar,
    required this.propina,
    required this.totalAPagar,
    required this.dividirPorTodos,
    required this.totalPayersInTotalDivider,
  });

  double subTotalAPagar;
  double propina;
  double totalAPagar;
  int dividirPorTodos;
  int totalPayersInTotalDivider;

  @override
  String toString() {
    return 'Total a pagar $subTotalAPagar, Propina $propina';
  }
}
