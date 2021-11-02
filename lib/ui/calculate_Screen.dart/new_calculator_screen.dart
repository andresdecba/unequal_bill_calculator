import 'package:bill_calculator/ui/calculate_Screen.dart/global_total_by_user.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/show_total_bill.dart';
import 'package:bill_calculator/ui/users_expenses_list/user_expenses_list.dart';
import 'package:flutter/material.dart';

class NewCalculatorScreen extends StatefulWidget {
  const NewCalculatorScreen({Key? key}) : super(key: key);

  @override
  _NewCalculatorScreenState createState() => _NewCalculatorScreenState();
}

class _NewCalculatorScreenState extends State<NewCalculatorScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //title: const Text('TabBar Widget'),
        automaticallyImplyLeading: false,
        toolbarHeight: 10,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Dividir Globalmente',
              icon: Icon(Icons.beach_access_sharp),
            ),
            Tab(
              text: 'Dividir por cuenta',
              icon: Icon(Icons.beach_access_sharp),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
          ///// TOTAL A PAGAR GLOBAL
          SingleChildScrollView(
            child: Column(
              children: const [
                ShowTotalBill(),
                GlobalTotalByUser(),
              ],
            ),
          ),

          ///// TOTAL A PAGAR POR ITEM
          SingleChildScrollView(
            child: Column(
              children: const [
                ShowTotalBill(),
                UserExpensesList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
