import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/ui/users_screen/users_form.dart';

class AgregarUsuarios extends StatelessWidget {
  const AgregarUsuarios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateUsersState>(context);

    //get screen size
    final _queryData = MediaQuery.of(context);

    return Scaffold(
      // CONTUNE button
      floatingActionButton: ContinueButton(state: _state),

      // body
      body: SingleChildScrollView(
        //padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //////////// TOP SCREEN, INPUT DATA ///////////

            Container(
              padding: const EdgeInsets.only(top: 50, bottom: 25, left: 25, right: 25),
              decoration: const BoxDecoration(
                color: Colors.amber,
              ),
              child: Column(
                children: [
                  ////////// TITLES //////////
                  const Text('¿QUIENES PAGAN?', style: TextStyle(fontSize: 30, fontFamily: 'Highman')),
                  const SizedBox(height: 20),
                  ///////// TEXT FIELD + BUTTON ////////
                  UsersForm(onEdit: false),
                ],
              ),
            ),

            const SizedBox(height: 20),

            //////////// ADDED USERS LIST ///////////
            _state.listaUsuarios.isEmpty
                ? const Text(
                    'No hay usuarios agregados',
                    textAlign: TextAlign.center,
                  )

                // generar lista de usuarios
                : SizedBox(
                    width: _queryData.size.width,
                    child: DataTable(
                        dataRowHeight: 50,
                        showBottomBorder: true,
                        horizontalMargin: 25,

                        ////colums
                        columns: const <DataColumn>[
                          DataColumn(label: Text('Usuarios', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900))),
                          DataColumn(label: Text('')),
                          DataColumn(label: Text('')),
                        ],

                        ////rows
                        rows: _state.listaUsuarios.map((item) {
                          int index = _state.listaUsuarios.indexOf(item);
                          return DataRow(
                            cells: <DataCell>[
                              ////// NAME
                              DataCell(
                                Text(
                                  item.userNombre,
                                ),
                              ),

                              ////// EDIT
                              DataCell(
                                IconButton(
                                  onPressed: () => showDialog(
                                    context: context,
                                    builder: (context) => EditUserNameDialog(index: index),
                                  ), //  async => editUserNameDialog(context, _state, index), //_state.editarUsuario(index: index, nombre: 'juan'),
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.edit),
                                ),
                              ),

                              ////// DELETE
                              DataCell(
                                IconButton(
                                  onPressed: () => _state.eliminarUsuario(index: index),
                                  padding: EdgeInsets.zero,
                                  alignment: Alignment.center,
                                  icon: const Icon(Icons.delete_forever),
                                ),
                              ),
                            ],
                          );
                        }).toList()),
                  )
          ],
        ),
      ),
    );
  }
}

//////////// EDITAR NOMBRE DIALOG ////////////
class EditUserNameDialog extends StatelessWidget {
  const EditUserNameDialog({Key? key, required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: EdgeInsets.all(15),
      backgroundColor: Colors.amber,
      contentPadding: EdgeInsets.all(15),
      alignment: Alignment.center,
      title: const Text(
        'EDITAR NOMBRE',
        style: TextStyle(fontSize: 30, fontFamily: 'Highman'),
        textAlign: TextAlign.center,
      ),
      children: [
        //SizedBox(height: 30),
        UsersForm(
          onEdit: true,
          userIndex: index,
        ),
      ],
    );
  }
}

//////////// CONTINUE BUTTON ///////////

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required CreateUsersState state})
      : _state = state,
        super(key: key);

  final CreateUsersState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        if (_state.listaUsuarios.isNotEmpty) {
          Navigator.pushNamed(context, '/agregarCuentas');
        } else {
          const snb = SnackBar(
            content: Text('Agrege un usuario'),
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
