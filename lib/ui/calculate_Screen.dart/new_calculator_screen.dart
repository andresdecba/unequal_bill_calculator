import 'package:bill_calculator/ui/calculate_Screen.dart/global_total_by_user.dart';
import 'package:bill_calculator/ui/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/show_total_bill.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/whatsapp_launcher.dart';

class NewCalculatorScreen extends StatefulWidget {
  const NewCalculatorScreen({Key? key}) : super(key: key);

  @override
  _NewCalculatorScreenState createState() => _NewCalculatorScreenState();
}

class _NewCalculatorScreenState extends State<NewCalculatorScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  // _isActive control how to show the active or inactive tab
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _isActive = !_isActive;
        });
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // FLOATING ACTION BUTTONS WITH OPTIONS
      floatingActionButton: const MultipleFloatingActionButton(),

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // TAB BAR + SHOW TOTAL BILL
            CreateTabs(
              /// dejar
              tabController: _tabController,
              isActive: _isActive,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          physics: const NeverScrollableScrollPhysics(),
          children: const <Widget>[
            // MOSTRAR DIVIDIR GLOBAL
            GlobalTotalByUser(),

            // MOSTRAR DIVIDIR POR ITEM
            UserExpensesList(),
          ],
        ),
      ),
    );
  }
}

///// BUILD TABS
class CreateTabs extends StatelessWidget {
  const CreateTabs({required this.tabController, required this.isActive, Key? key}) : super(key: key);

  final TabController tabController;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.amber,
      expandedHeight: 250,
      pinned: true,
      floating: true,
      flexibleSpace: const FlexibleSpaceBar(
        //////////// TOTAL BILL
        background: ShowTotalBill(),
      ),
      bottom: TabBar(
        controller: tabController,
        tabs: <Widget>[
          Tab(
            // DIVIDIR GLOBAL
            child: Text(
              'Dividir por el total',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isActive == true ? Colors.black : Colors.black.withOpacity(0.5),
              ),
            ),
            icon: Icon(
              Icons.checklist_rounded,
              color: isActive == true ? Colors.black : Colors.black.withOpacity(0.5),
            ),
          ),

          // DIVIDIR POR ITEM
          Tab(
            child: Text(
              'Dividir por item',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: isActive != true ? Colors.black : Colors.black.withOpacity(0.5),
              ),
            ),
            icon: Icon(
              Icons.checklist_rtl,
              color: isActive != true ? Colors.black : Colors.black.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}

///// FLOATING ACTION BUTTONS
class MultipleFloatingActionButton extends StatelessWidget {
  const MultipleFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      overlayOpacity: 0.3,
      overlayColor: Colors.black, // color de fondo en la pantalla
      spacing: 20,
      children: [
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.5),
          child: const Icon(Icons.share),
          label: 'Compartir',
          onTap: () => showInformationDialog(context),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.5),
          child: const Icon(Icons.group),
          label: 'Ver usuarios',
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AgregarUsuarios(),
            ),
          ),
        ),
        SpeedDialChild(
          labelBackgroundColor: Colors.white.withOpacity(0.5),
          child: const Icon(Icons.monetization_on_rounded),
          label: 'Ver gastos',
          onTap: () => Navigator.pop(
            context,
            MaterialPageRoute(
              builder: (context) => const AgregarCuentas(),
            ),
          ),
        ),
      ],
    );
  }
}

