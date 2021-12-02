import 'package:bill_calculator/borrar.dart';
import 'package:bill_calculator/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/models/models.dart';

void main() async {
  // init widgets safety
  WidgetsFlutterBinding.ensureInitialized();

  // init HIVE
  await Hive.initFlutter();

  // register adapters
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(UserExpenseModelAdapter());
  Hive.registerAdapter(ExpenseModelAdapter());
  Hive.registerAdapter(BillModelAdapter());

  // open box
  await Hive.openBox<UserModel>('USERS-BOX');
  await Hive.openBox<UserExpenseModel>('USER-EXPENSES-BOX');
  await Hive.openBox<ExpenseModel>('EXPENSE-BOX');
  await Hive.openBox<BillModel>('BILL-BOX');

  runApp(Phoenix(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculateScreenState()),
        ChangeNotifierProvider(create: (_) => CalculateAllState()),
        ChangeNotifierProvider(create: (_) => CreateUsersScreenState()),
        ChangeNotifierProvider(create: (_) => CreateExpensesScreenState()),
        ChangeNotifierProvider(create: (_) => Propina()),
        ChangeNotifierProvider(create: (_) => CreateNewBillScreenState()),
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
      initialRoute: Singleton().billBOX.isEmpty ? '/' : '/createUsers',
      routes: {
        '/': (context) => CreateNewBillScreen(),
        '/createUsers': (context) => const CreateUsersScreen(),
        '/agregarCuentas': (context) => const CreateExpensesScreen(),
        '/newCalculatorScreen': (context) => const CalculatorScreen(),
        '/aboutTheApp': (context) => const AboutTheApp(),
        '/borrar': (context) => const Borrar(),
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
