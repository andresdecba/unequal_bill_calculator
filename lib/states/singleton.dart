import '../model.dart';

////// singleton repositories /////
class Singleton {
  static final Singleton _singleton = Singleton._internal();

  factory Singleton() {
    return _singleton;
  }

  Singleton._internal();

  // propiedades
  final List<Usuario> listaUsuarios = [];
  final List<Servicio> listaServicios = [];
  final CuentaTotal cuentaTotal = CuentaTotal(
    subTotalAPagar: 0.0,
    propina: 0.0,
    totalAPagar: 0.0,
    dividirPorTodos: 0,
    totalPayersInTotalDivider: 0,
  );
  //final double cuentaTotal = 0.0;
}
  