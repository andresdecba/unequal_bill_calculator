import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/propina_dialog.dart';

class CalcularTodo extends StatefulWidget {
  const CalcularTodo({Key? key}) : super(key: key);

  @override
  _CalcularTodoState createState() => _CalcularTodoState();
}

class _CalcularTodoState extends State<CalcularTodo> {

  bool _isExpanded = false;
  bool _toggled = true;

  late TabController _tabController;

  

  @override
  Widget build(BuildContext context) {
    //////////// PROVIDERS ///////////
    final _calculateState = Provider.of<CalculateState>(context);
    final _propinaState = Provider.of<PropinaState>(context);

    

    

    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => showInformationDialog(context),
      // ),

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            //////////// TOP SCREEN ///////////
            TopScreenShowTotals(propinaState: _propinaState),

            // Title
            ListTile(
              title: const Text(
                'Totales a pagar por persona',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
              tileColor: Colors.grey[200],
            ),
            // OPTIONS menu
            ExpansionPanelList(
              expansionCallback: (panelIndex, isExpanded) => setState(() {
                _isExpanded = !isExpanded;
              }),
              expandedHeaderPadding: const EdgeInsets.symmetric(horizontal: 20),
              elevation: 0,
              children: [
                ExpansionPanel(
                  backgroundColor: Colors.grey[200],
                  isExpanded: _isExpanded,
                  headerBuilder: (context, value) {
                    return Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: const Text('Mostrar opciones'),
                    );
                  },
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        // options
                        ListTile(
                          title: const Text(
                            'Dividir detalladamente',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          subtitle: const Text('Divide desigualmente cada gasto'),
                          leading: const Icon(Icons.list),
                          onTap: () {
                            Navigator.pushNamed(context, '/usersExpensesList');
                            setState(() => _isExpanded = !_isExpanded);
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.restore),
                          title: const Text(
                            'Reiniciar cuenta',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                          ),
                          subtitle: const Text('Iguala todas las cuentas a 1'),
                          onTap: () {
                            setState(() => _isExpanded = !_isExpanded);
                          },
                        ),
                        ListTile(
                            leading: const Icon(Icons.edit_rounded),
                            title: const Text(
                              'Modificar Propina',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                            ),
                            subtitle: const Text('Cambia la propina'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => const PropinaDialogBox(),
                              );
                              setState(() => _isExpanded = !_isExpanded);
                            }),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            /////////////////////// TODO:  hacerrrr otra cosa, NO ANDAAA
            // DefaultTabController(
            //   length: 2,
            //   child: Scaffold(
            //     body: Column(
            //       children: const [
            //         TabBar(tabs: [
            //           Tab(text: 'Tab 1'),
            //           Tab(text: 'Tab 2'),
            //         ]),
            //         TabBarView(children: [
            //           Text('data'),
            //           Text('data'),
            //         ]),
            //       ],
            //     ),
            //   ),
            // ),

            const Divider(
              endIndent: 20,
              indent: 20,
              height: 0,
              thickness: 1,
              color: Colors.blue,
            ),

            const SizedBox(
              height: 100,
            )
          ],
        ),
      ),
    );
  }
}

class TopScreenShowTotals extends StatelessWidget {
  const TopScreenShowTotals({
    Key? key,
    required PropinaState propinaState,
  })  : _propinaState = propinaState,
        super(key: key);

  final PropinaState _propinaState;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      decoration: containerDecoration(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////// MOSTRAR SUMA TOTAL + PROPINA  ///////////
            Text(
              'Sub-total \$ ${_propinaState.cuentaTotal.subTotalAPagar}',
              style: const TextStyle(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Propina \$ ${_propinaState.cuentaTotal.propina}',
                  style: const TextStyle(fontSize: 25),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const PropinaDialogBox(),
                    );
                  },
                  icon: const Icon(Icons.add_box_rounded),
                )
              ],
            ),
            Text(
              'Total a pagar: \$ ${_propinaState.cuentaTotal.totalAPagar}',
              style: const TextStyle(fontSize: 30),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class GlobalTotalByUser extends StatelessWidget {
  const GlobalTotalByUser({
    Key? key,
    required CalculateState calculateState,
  })  : _calculateState = calculateState,
        super(key: key);

  final CalculateState _calculateState;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 0,
        thickness: 1,
        color: Colors.blue,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _calculateState.listaUsuarios.length,
      itemBuilder: (BuildContext context, int usuariosINDEX) {
        //////// SHOW USER NAME AND TOTAL  /////////
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              //// user name
              ListTile(
                leading: Text(
                  _calculateState.listaUsuarios[usuariosINDEX].userNombre,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    ('\$  ${_calculateState.listaUsuarios[usuariosINDEX].totalAPagar.toString()}'),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              // dividir desigual globalmente
              ListTile(
                leading: const Text(
                  'Dividir desigual:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///// restar button
                    IconButton(
                      onPressed: () {
                        _calculateState.restarTotal(indexUsuario: usuariosINDEX);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 15),
                    ///// divisor text
                    Text(
                      _calculateState.listaUsuarios[usuariosINDEX].totalDivider.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    const SizedBox(width: 15),
                    ///// sumar button
                    IconButton(
                      onPressed: () {
                        _calculateState.sumarTotal(indexUsuario: usuariosINDEX);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
