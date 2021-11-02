import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/states/states.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculateState(), lazy: false),
        ChangeNotifierProvider(create: (_) => PropinaState()),
        ChangeNotifierProvider(create: (_) => CreateUsersState()),
        ChangeNotifierProvider(create: (_) => CreateExpensesState()),

      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/agregarUsuarios',
      routes: {
        '/agregarUsuarios': (context) => const AgregarUsuarios(),
        '/agregarCuentas': (context) => const AgregarCuentas(),
        '/calcularTodo': (context) => const CalcularTodo(),
        '/usersExpensesList': (context) => const UserExpensesList(),
        '/newCalculatorScreen': (context) => const NewCalculatorScreen(),


        //'/mostrarData': (context) => const AssignUserServices(indexUsuario: 0),
        //'/': (context) => const TopScreenBG(),
        //'/borrar': (context) => Borrar(),
      },

      theme: ThemeData(
        fontFamily: 'OpenSans_Condensed-Regular',
        textTheme: const TextTheme(bodyText2: TextStyle(fontSize: 20.0, color: Colors.black)),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.amber,
          elevation: 0,
        ),
      ),
    );
  }
}
