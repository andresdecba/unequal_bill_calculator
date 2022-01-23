import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class CreateExpensesScreen extends StatelessWidget {
  const CreateExpensesScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateExpensesScreenState>(context);

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
              : AnimatedList(
                  physics: const ScrollPhysics(),
                  reverse: true,
                  key: _state.expAnimatedListKey,
                  initialItemCount: _state.expensesBox.length,
                  padding: const EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (context, index, animation) {
                    //
                    final expense = _state.expensesBox.values.elementAt(index);

                    return SizeTransition(
                      sizeFactor: animation,
                      child: NameAndPriceTile(
                        title: expense.expenseName,
                        subTitle: '\$ ${expense.expensePrice}',
                        // delete item
                        deleteFnc: () {
                          // borrar en pantalla (animated list)
                          _state.expAnimatedListKey.currentState?.removeItem(index, (context, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child: NameAndPriceTile(title: expense.expenseName, deleteFnc: () {}, editFnc: const SizedBox()),
                            );
                          });
                          // borra el item en sí
                          _state.deleteExpense(expense: expense);
                        },
                        // edit item
                        editFnc: CreateExpenseForms(
                          onEdit: true,
                          expense: expense,
                        ),
                      ),
                    );
                  },
                ),

          kFooterSpace,
        ],
      ),
    );
  }
}

//////////// CONTINUE BUTTON ///////////
class ContinueButtonServ extends StatelessWidget {
  const ContinueButtonServ({Key key, CreateExpensesScreenState state})
      : _state = state,
        super(key: key);

  final CreateExpensesScreenState _state;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      // VALIDATE FORMS
      onPressed: () {
        if (_state.expensesBox.isNotEmpty) {

          Navigator.push(
            context,
            FadeInRoute(
              routeName: "/newCalculatorScreen",
              page: const CalculatorScreen(),
            ),
          );
          // UNFOCUS text fields
          FocusScope.of(context).unfocus();

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
