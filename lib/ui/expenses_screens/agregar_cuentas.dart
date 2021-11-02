import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_expense_foms.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class AgregarCuentas extends StatelessWidget {
  const AgregarCuentas({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesState>(context);

    //MediaQueryData queryData;
    final _queryData = MediaQuery.of(context);

    return Scaffold(
      // CONTUNE button
      floatingActionButton: ContinueButtonServ(state: _state),

      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            //////////// TOP SCREEN, INPUT DATA ///////////
            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 25, left: 25, right: 25),
              decoration: containerDecoration(),
              child: Column(
                children: const [
                  ////////// TITLES //////////
                  Text('¿QUE VAN A PAGAR?', style: TextStyle(fontSize: 30, fontFamily: 'Highman')),
                  SizedBox(height: 20),

                  ///////// CREATE EXPENSE FORMS AND BUTTON ////////
                  CreateExpenseForms(onEdit: false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //////////// ADDED SERVICES LIST ///////////
            _state.listaServicios.isEmpty
                ? const Text('No hay servicios agregados', textAlign: TextAlign.center)

                // generar lista de usuarios
                : DataTable(
                    dataRowHeight: 50,
                    showBottomBorder: true,
                    columnSpacing: 0,
                    horizontalMargin: 0,
                    sortColumnIndex: 1,
                    sortAscending: true,

                    ////colums
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Servicio', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ),
                      DataColumn(
                        label: Text('Importe', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ),
                      DataColumn(
                        label: Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ),
                      DataColumn(
                        label: Text('', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900)),
                      ),
                    ],

                    ////rows
                    rows: _state.listaServicios.map((item) {
                      // get THIS expense index from the expenses list
                      int index = _state.listaServicios.indexOf(item);

                      return DataRow(
                        cells: <DataCell>[
                          ////// EXPENSE NAME
                          DataCell(
                            Container(
                              width: (_queryData.size.width - 50) * 0.4,
                              child: Text(item.servicioNombre),
                            ),
                          ),
                          ////// EXPENSE MOUNT
                          DataCell(
                            Container(
                              width: (_queryData.size.width - 50) * 0.3,
                              child: Text(item.precio.toString()),
                            ),
                          ),
                          ////// EDIT
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              width: (_queryData.size.width - 50) * 0.15,
                              child: IconButton(
                                onPressed: () => showDialog(
                                  context: context,
                                  builder: (context) => EditServiceDialog(index: index),
                                ),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                icon: const Icon(Icons.edit),
                              ),
                            ),
                          ),
                          ////// DELETE
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              width: (_queryData.size.width - 50) * 0.15,
                              child: IconButton(
                                onPressed: () => _state.eliminarServicio(index: index),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                icon: const Icon(Icons.delete_forever),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList()),
          ],
        ),
      ),
    );
  }
}

//////////// EDITAR NOMBRE DIALOG ////////////
class EditServiceDialog extends StatelessWidget {
  const EditServiceDialog({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: const EdgeInsets.all(2),
      backgroundColor: Colors.amber,
      contentPadding: EdgeInsets.all(15),
      alignment: Alignment.center,
      title: const Text(
        'EDITAR SERVICIO',
        style: TextStyle(fontSize: 30, fontFamily: 'Highman'),
        textAlign: TextAlign.center,
      ),
      children: [
        CreateExpenseForms(
          onEdit: true,
          serviceIndex: index,
        ),
      ],
    );
  }
}

//////////// CONTINUE BUTTON ///////////
class ContinueButtonServ extends StatelessWidget {
  
  const ContinueButtonServ({Key? key, required CreateExpensesState state})
      : _state = state,
        super(key: key);

  final CreateExpensesState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // VALIDATE FORMS
      onPressed: () {
        if (_state.listaServicios.isNotEmpty) {
          Navigator.pushNamed(context, '/newCalculatorScreen');
        } else {
          const snb = SnackBar(
            content: Text('Agrege un servicio'),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snb);
        }
      },
      label: const Text(
        'CONTINUAR >',
        style: TextStyle(color: Colors.black, fontFamily: 'Highman', fontSize: 20, height: 1.2),
      ),
    );
  }
}
