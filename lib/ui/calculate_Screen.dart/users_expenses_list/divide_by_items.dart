import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/buttons.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DivideByItems extends StatelessWidget {
  DivideByItems({Key? key, required CalculateState state, required this.usuariosINDEX})
      : _state = state,
        super(key: key);

  final CalculateState _state;
  final int usuariosINDEX;

  //bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    //final _calculateState = Provider.of<CalculateState>(context);

    return FittedBox(
      fit: BoxFit.fitWidth,
      child: Container(
        color: Colors.grey[50],
        child: DataTable(
            columnSpacing: 40,
            headingRowHeight: 50,
            dataRowHeight: 50,
            headingTextStyle: kTextSmall,
            horizontalMargin: 0,
            showBottomBorder: false,
            dataTextStyle: kTextSmall,

            ////colums
            columns: const <DataColumn>[
              DataColumn(
                label: Text('Gasto'),
              ),
              DataColumn(
                label: Text('A pagar'),
              ),
              DataColumn(
                label: Text('     Dividir desigual'),
              ),
            ],

            ////rows
            rows: _state.listaUsuarios[usuariosINDEX].servicios.map((item) {
              int index = _state.listaUsuarios[usuariosINDEX].servicios.indexOf(item);

              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    '${item.servicio.servicioNombre} (\$ ${item.servicio.precio.toString()})',
                  )),
                  DataCell(
                    _state.isLoading ? const ProgressIndicartor() : Text('\$ ${item.aPagar.toString()}'),
                  ),
                  DataCell(
                    // block the buttons wile is loading.
                    AbsorbPointer(
                      absorbing: _state.isLoading,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        // Substract button
                        kIconButton(
                          onPress: () => _state.restarMultiplicador(indexUsuario: usuariosINDEX, indexServicio: index),
                          icon: Icons.remove_circle,
                        ),
                        kSizedBoxBig,
                        // number
                        Text(_state.listaUsuarios[usuariosINDEX].servicios[index].multiplicarPor.toString()),
                        kSizedBoxBig,
                        // add button
                        kIconButton(
                          onPress: () => _state.sumarMultiplicador(indexUsuario: usuariosINDEX, indexServicio: index),
                          icon: Icons.add_circle,
                        ),
                      ]),
                    ),
                  ),
                ],
              );
            }).toList()),
      ),
    );
  }
}
