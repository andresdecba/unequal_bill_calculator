import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:bill_calculator/ui/screens.dart';

class CreateUsersScreen extends StatelessWidget {
  const CreateUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateUsersScreenState>(context);
    List<UserModel> _usersList = _state.usersBox.values.toList().cast<UserModel>();

    //get screen size
    final _screenData = MediaQuery.of(context);

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
                    CreateUsersForm(onEdit: false),
                  ],
                ),
              ),
            ),

            // reset app button
            ElevatedButton(
              child: const Text('Resetear app'),
              onPressed: () {
                _state.reset();
                Navigator.pushNamed(context, '/');
              },
            ),

            kSizedBoxBig,

            //////////// ADDED USERS LIST ///////////
            _usersList.isEmpty
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
                    width: _screenData.size.width,
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
                        rows: _usersList.map((user) {
                          //int index = _usersList.indexOf(item);

                          return DataRow(
                            cells: <DataCell>[
                              ////// NAME
                              DataCell(
                                Text(
                                  user.userName,
                                  style: kTextSmall,
                                ),
                              ),

                              ////// EDIT / UPDATE
                              DataCell(
                                kIconButton(
                                  // show dialog box
                                  onPress: () => showDialog(
                                    barrierColor: kDialogBackground,
                                    context: context,
                                    builder: (context) => DialogBox(
                                      title: 'Editar usuario',
                                      children: [
                                        CreateUsersForm(
                                          onEdit: true,
                                          user: user,
                                        )
                                      ],
                                    ),
                                  ),
                                  icon: Icons.edit,
                                ),
                              ),

                              ////// DELETE
                              DataCell(kIconButton(
                                onPress: () => _state.eliminarUsuario(user: user),
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
  const ContinueButton({Key? key, required CreateUsersScreenState state})
      : _state = state,
        super(key: key);

  final CreateUsersScreenState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: const Text(
        'CONTINUAR >',
        style: kButtonsText,
      ),
      onPressed: () {
        if (_state.usersBox.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              settings: const RouteSettings(name: "/agregarCuentas"),
              builder: (context) => const CreateExpensesScreen(),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarCustom(message: 'Agrege un usuario.'));
        }
      },
    );
  }
}
