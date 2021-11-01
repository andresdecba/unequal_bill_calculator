import 'package:bill_calculator/states/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({Key? key, required CalculateState state, required this.usuariosINDEX})
      : _state = state,
        super(key: key);

  final CalculateState _state;
  final int usuariosINDEX;

  @override
  Widget build(BuildContext context) {

    final _calculateState = Provider.of<CalculateState>(context);

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        color: Colors.grey[100],
        padding: const EdgeInsets.only(bottom: 40),
        child: DataTable(
            headingRowHeight: 50,
            dataRowHeight: 60,
            //showBottomBorder: true,
            headingTextStyle: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontFamily: 'OpenSans_Condensed-Regular',
            ),

            ////colums
            columns: const <DataColumn>[
              DataColumn(
                label: Text(
                  'SERVICIO',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'IMPORTE',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'A PAGAR',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'DIVIDIR DESIGUAL',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
                  textAlign: TextAlign.center,
                ),
              ),
            ],

            ////rows
            rows: _state.listaUsuarios[usuariosINDEX].servicios.map((item) {
              int index = _state.listaUsuarios[usuariosINDEX].servicios.indexOf(item);

              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Text(
                      item.servicio.servicioNombre,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataCell(
                    Text(
                      item.servicio.precio.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataCell(
                    Text(
                      item.aPagar.toString(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  DataCell(
                    Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () => _state.restarMultiplicador(indexUsuario: usuariosINDEX, indexServicio: index),
                        icon: const Icon(Icons.remove_circle),
                      ),
                      Text(_state.listaUsuarios[usuariosINDEX].servicios[index].multiplicarPor.toString()),
                      IconButton(
                        onPressed: () => _state.sumarMultiplicador(indexUsuario: usuariosINDEX, indexServicio: index),
                        icon: const Icon(
                          Icons.add_circle
                        ),
                      ),
                    ]),
                  ),
                ],
              );
            }).toList()),
      ),
    );
  }
}



