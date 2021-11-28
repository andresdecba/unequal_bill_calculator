import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class CreateExpensesScreen extends StatelessWidget {
  const CreateExpensesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesScreenState>(context);
    //final _expensesList = _state.expensesBox.values; //.toList(); //.cast<ExpenseModel>();

    return Scaffold(
      // CONTUNE button
      floatingActionButton: Visibility(
        child: ContinueButtonServ(state: _state),
      ),

      // body
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.all(0),
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

          //////////// if NO EXPENSES YET ///////////
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

              //////////// BUILD USERS LIST ///////////
              : ListView.separated(
                  itemCount: _state.expensesBox.values.length,
                  padding: const EdgeInsets.all(0),
                  separatorBuilder: (BuildContext context, int index) => kDivder,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    //
                    final expense = _state.expensesBox.values.elementAt(index);

                    return NameAndPriceTile(
                      title: expense.expenseName,
                      subTitle: '\$ ${expense.expensePrice}',
                      deleteFnc: () => _state.deleteExpense(expense: expense),
                      editFnc: CreateExpenseForms(
                        onEdit: true,
                        expense: expense,
                      ),
                    );
                  },
                ),

          _state.expensesBox.isNotEmpty ? kDivder : const SizedBox(),

          kFooterSpace,
        ],
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
