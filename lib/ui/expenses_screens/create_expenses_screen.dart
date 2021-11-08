import 'package:bill_calculator/styles/buttons.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/calculator_screen.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'create_expense_foms.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class CreateExpensesScreen extends StatelessWidget {
  const CreateExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesState>(context);

    //MediaQueryData queryData;
    final _queryData = MediaQuery.of(context);

    return Scaffold(
      // CONTUNE button
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0,
        child: ContinueButtonServ(state: _state),
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
                    Text('¿QUE VAN A PAGAR?', style: kBigTitles),
                    kSizedBoxBig,
                    ///////// CREATE EXPENSE FORMS AND BUTTON ////////
                    CreateExpenseFormsAndButton(onEdit: false),
                  ],
                ),
              ),
            ),

            kSizedBoxBig,

            //////////// ADDED SERVICES LIST ///////////
            _state.listaServicios.isEmpty
                ? Container(
                    height: 200,
                    padding: kPaddingLarge,
                    alignment: Alignment.center,
                    child: const Text(
                      'Agregue los gatos a compartir.',
                      style: kTextSmall,
                      textAlign: TextAlign.center,
                    ),
                  )

                // generar lista de usuarios
                : DataTable(
                    dataRowHeight: kSpaceLarge,
                    showBottomBorder: true,
                    horizontalMargin: kSpaceSmall,
                    columnSpacing: 0,

                    ////colums
                    columns: const <DataColumn>[
                      DataColumn(
                        label: Text('Servicio', style: kTextMedium),
                      ),
                      DataColumn(
                        label: Text('Importe', style: kTextMedium),
                      ),
                      DataColumn(
                        label: Text(''),
                      ),
                      DataColumn(
                        label: Text(''),
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
                              child: Text(item.servicioNombre, style: kTextSmall),
                            ),
                          ),
                          ////// EXPENSE MOUNT
                          DataCell(
                            Container(
                              width: (_queryData.size.width - 50) * 0.3,
                              child: Text(item.precio.toString(), style: kTextSmall),
                            ),
                          ),
                          ////// EDIT
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              width: (_queryData.size.width - 50) * 0.15,
                              child: kIconButton(
                                ////// SHOW DIALOG BOX
                                onPress: () => showDialog(
                                  barrierColor: kDialogBackground,
                                  context: context,
                                  builder: (context) => DialogBox(
                                    title: 'Editar gasto',
                                    children: [
                                      CreateExpenseFormsAndButton(
                                        onEdit: true,
                                        serviceIndex: index,
                                      )
                                    ],
                                  ),
                                ),
                                icon: Icons.edit,
                              ),
                            ),
                          ),
                          ////// DELETE
                          DataCell(
                            Container(
                              alignment: Alignment.centerRight,
                              width: (_queryData.size.width - 50) * 0.15,
                              child: kIconButton(
                                onPress: () => _state.eliminarServicio(index: index),
                                icon: Icons.delete_forever,
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
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const CalculatorScreen()), ModalRoute.withName('/newCalculatorScreen'));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarCustom(message: 'Agrege un gasto.'));
        }
      },
      label: const Text(
        'CONTINUAR >',
        style: kButtonsText,
      ),
    );
  }
}
