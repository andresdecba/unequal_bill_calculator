import 'package:bill_calculator/ui/menu_options/menu_options.dart';
import 'package:flutter/material.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/ui/screens.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> with TickerProviderStateMixin {
  //
  // _isActive control how to show the active or inactive tab
  bool _isActive = true;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // tabs
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
  Widget build(BuildContext context) {
    return Scaffold(
      // FLOATING ACTION BUTTONS WITH OPTIONS
      floatingActionButton: OptionsActionButton(activeTab: _isActive),

      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            // TAB BAR + SHOW TOTAL BILL
            CreateTabsAndDisplayTotalBill(
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
            DivideByTheTotal(),

            // MOSTRAR DIVIDIR POR ITEM
            ExpandibleUsersTiles(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

///// BUILD TABS
class CreateTabsAndDisplayTotalBill extends StatelessWidget {
  const CreateTabsAndDisplayTotalBill({
    required this.tabController,
    required this.isActive,
    Key? key,
  }) : super(key: key);

  final TabController tabController;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      automaticallyImplyLeading: false,
      expandedHeight: 270,
      pinned: true,
      floating: true,
      snap: true,
      backgroundColor: kAmarillo,
      elevation: 0,
      flexibleSpace: const FlexibleSpaceBar(
        //
        //////////// HEADER: SHOW TOTAL BILL and bill name
        background: ShowTotalBill(),
      ),
      bottom: TabBar(
        indicatorWeight: 5,
        controller: tabController,
        tabs: <Widget>[
          Tab(
            // DIVIDIR GLOBAL
            child: Row(
              children: [
                Icon(
                  Icons.checklist_rounded,
                  color: isActive == true ? kNegro : kNegro.withOpacity(0.3),
                ),
                kSizedBoxBig,
                Text(
                  'Dividir por el total',
                  style: kTextMedium.copyWith(color: isActive == true ? Colors.black : Colors.black.withOpacity(0.3)),
                ),
              ],
            ),
          ),

          // DIVIDIR POR ITEM
          Tab(
            child: Row(
              children: [
                Icon(
                  Icons.checklist_rtl,
                  color: isActive != true ? kNegro : kNegro.withOpacity(0.3),
                ),
                kSizedBoxBig,
                Text(
                  'Dividir por item',
                  style: kTextMedium.copyWith(color: isActive != true ? Colors.black : Colors.black.withOpacity(0.3)),
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }
}


