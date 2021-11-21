import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class CreateExpensesScreen extends StatelessWidget {
  const CreateExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesScreenState>(context);
    final _expensesList = _state.expensesBox.values.toList().cast<ExpenseModel>();

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
                    CreateExpenseForms(onEdit: false),
                  ],
                ),
              ),
            ),

            kSizedBoxBig,

            //////////// ADDED SERVICES LIST ///////////
            _state.expensesBox.isEmpty
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
                    rows: _expensesList.map((expense) {
                      return DataRow(
                        cells: <DataCell>[
                          ////// EXPENSE NAME
                          DataCell(
                            Container(
                              width: (_queryData.size.width - 50) * 0.4,
                              child: Text(expense.expenseName, style: kTextSmall),
                            ),
                          ),
                          ////// EXPENSE AMOUNT
                          DataCell(
                            Container(
                              width: (_queryData.size.width - 50) * 0.3,
                              child: Text(expense.price.toString(), style: kTextSmall),
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
                                      CreateExpenseForms(
                                        onEdit: true,
                                        expense: expense,
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
                                onPress: () => _state.eliminarServicio(expense: expense),
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
  const ContinueButtonServ({Key? key, required CreateExpensesScreenState state})
      : _state = state,
        super(key: key);

  final CreateExpensesScreenState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // VALIDATE FORMS
      onPressed: () {
        
        if (_state.expensesBox.isNotEmpty) {
          Navigator.of(context).push(
            MaterialPageRoute(
              settings: const RouteSettings(name: "/newCalculatorScreen"),
              builder: (context) => const CalculatorScreen(),
            ),
          );
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
