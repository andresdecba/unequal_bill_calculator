import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class DivideByExpenses extends StatelessWidget {
  //
  const DivideByExpenses({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<CalculateScreenState>(context);

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
            rows: user.userExpensesList.map((userExpense) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(
                    '${userExpense.userExpenseExpense.expenseName} (\$ ${userExpense.userExpenseExpense.expensePrice.toString()})',
                  )),
                  ////////// progress indicator wile is calculating
                  DataCell(
                    _state.isLoading ? const ProgressIndicartor() : Text('\$ ${userExpense.userExpenseTotal.toString()}'),
                  ),
                  DataCell(
                    // block the buttons wile is loading.
                    AbsorbPointer(
                      absorbing: _state.isLoading,
                      child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        // Substract button
                        kIconButton(
                          onPress: () => _state.restarMultiplicador(userExpense: userExpense),
                          icon: Icons.remove_circle,
                        ),
                        kSizedBoxBig,
                        // number
                        Text(userExpense.userExpenseByItemFactor.toString()),
                        kSizedBoxBig,
                        // add button
                        kIconButton(
                          onPress: () => _state.sumarMultiplicador(userExpense: userExpense),
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
