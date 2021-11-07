import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/styles/buttons.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/ui/users_screen/create_users_form.dart';

class CreateUsersScreen extends StatelessWidget {
  const CreateUsersScreen({
    //required onEditt,
    Key? key,
  }) : super(key: key);

  //final bool onEditt = false;

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateUsersState>(context);

    //get screen size
    final _queryData = MediaQuery.of(context);

    return Scaffold(
      // CONTUNE button
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: ContinueButton(state: _state),
      ),

      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            //////////// TOP SCREEN, INPUT DATA ///////////
            Container(
              padding: kPaddingSmall,
              color: kAmarillo,
              child: SafeArea(
                child: Column(
                  children: const [
                    ////////// TITLES //////////
                    Text('¿QUIENES PAGAN?', style: kBigTitles),
                    kSizedBoxBig,
                    ///////// TEXT FIELD + BUTTON ////////
                    CreateUsersFormAnButton(onEdit: false),
                  ],
                ),
              ),
            ),

            kSizedBoxBig,

            //////////// ADDED USERS LIST ///////////
            _state.listaUsuarios.isEmpty
                ? Container(
                    height: 200,
                    padding: kPaddingLarge,
                    alignment: Alignment.center,
                    child: const Text(
                      'Comience agregando los nombres de las personas que van a compartit los gastos.',
                      style: kTextSmall,
                      textAlign: TextAlign.center,
                    ),
                  )

                // generar lista de usuarios
                : SizedBox(
                    width: _queryData.size.width,
                    child: DataTable(
                        dataRowHeight: kSpaceLarge,
                        showBottomBorder: true,
                        horizontalMargin: kSpaceSmall,
                        columnSpacing: 0,

                        ////colums
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Text(
                              'Usuarios',
                              style: kTextMedium,
                            ),
                          ),
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
                                  style: kTextSmall,
                                ),
                              ),

                              ////// EDIT   EditUserNameDialog(index: index),
                              DataCell(
                                kIconButton(
                                  ////// SHOW DIALOG BOX
                                  onPress: () => showDialog(
                                    barrierColor: kDialogBackground, //Colors.black.withOpacity(0.5),
                                    context: context,
                                    builder: (context) => DialogBox(
                                      title: 'Editar usuario',
                                      children: [
                                        CreateUsersFormAnButton(
                                          onEdit: true,
                                          userIndex: index,
                                        )
                                      ],
                                    ),
                                  ),
                                  icon: Icons.edit,
                                ),
                              ),

                              ////// DELETE
                              DataCell(kIconButton(
                                onPress: () => _state.eliminarUsuario(index: index),
                                icon: Icons.delete_forever,
                              )),
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

//////////// CONTINUE BUTTON ///////////

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key, required CreateUsersState state})
      : _state = state,
        super(key: key);

  final CreateUsersState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text(
        'CONTINUAR >',
        style: kButtonsText,
      ),
      onPressed: () {
        if (_state.listaUsuarios.isNotEmpty) {
          Navigator.pushNamed(context, '/agregarCuentas');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarCustom(message: 'Agrege un usuario.'));
        }
      },
    );
  }
}
