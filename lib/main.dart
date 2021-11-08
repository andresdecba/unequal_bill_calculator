import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/calculator_screen.dart';
import 'package:bill_calculator/ui/expenses_screens/create_expenses_screen.dart';
import 'package:bill_calculator/ui/users_screen/create_users_screen.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Calculadora de cuentas desigual',
      initialRoute: '/',
      routes: {
        '/': (context) => const CreateUsersScreen(),
        '/agregarCuentas': (context) => const CreateExpensesScreen(),
        '/newCalculatorScreen': (context) => const CalculatorScreen(),
      },

      theme: ThemeData(
        fontFamily: 'OpenSans_Condensed-Regular',
        
        textTheme: const TextTheme(bodyText2: TextStyle(fontFamily: 'OpenSans_Condensed-Regular')),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kAzul,
          elevation: 5,
          
        ),
      ),
    );
  }
}
