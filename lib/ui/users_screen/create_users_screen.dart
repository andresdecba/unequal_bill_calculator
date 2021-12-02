import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/widgets/widgets.dart';
import 'package:bill_calculator/ui/screens.dart';

class CreateUsersScreen extends StatelessWidget {
  const CreateUsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //provider
    final _state = Provider.of<CreateUsersScreenState>(context);

    // catch the device back button
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        // CONTUNE button
        floatingActionButton: Visibility(
          child: ContinueButton(state: _state),
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
                    Text('¿QUIENES PAGAN?', style: kBigTitles),
                    kSizedBoxBig,
                    ///////// TEXT FIELD + BUTTON ////////
                    CreateUsersForm(onEdit: false),
                  ],
                ),
              ),
            ),

            //////////// if NO USERS YET ///////////
            _state.usersBox.values.isEmpty
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

                //////////// BUILD USERS LIST ///////////
                : AnimatedList(
                    reverse: true,
                    initialItemCount: _state.usersBox.length, //_state.usersBox.isNotEmpty ? 100  : 0,  //
                    key: _state.usrAnimatedListKey,
                    padding: const EdgeInsets.all(0),
                    shrinkWrap: true,
                    itemBuilder: (context, index, animation) {
                      //
                      final user = _state.usersBox.values.elementAt(index);

                      return SizeTransition(
                        sizeFactor: animation,
                        child: NameAndPriceTile(
                          title: user.userName,
                          deleteFnc: () {
                            // delete from provider
                            _state.eliminarUsuario(user: user);
                            // animated list function
                            _state.usrAnimatedListKey.currentState?.removeItem(index, (context, animation) {
                              return SizeTransition(
                                sizeFactor: animation,
                                child: NameAndPriceTile(
                                  title: user.userName,
                                  deleteFnc: () {},
                                  editFnc: const SizedBox(),
                                ),
                              );
                            });
                          },
                          editFnc: CreateUsersForm(
                            onEdit: true,
                            user: user,
                          ),
                        ),
                      );
                    },
                  ),

            kFooterSpace,
          ],
        ),
      ),
    );
  }

  void cosoo(index) {}
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

          Navigator.push( // or pushReplacement, if you need that
            context,
            FadeInRoute(
              routeName: "/agregarCuentas",
              page: const CreateExpensesScreen(),
            ),
          );

        } else {
          ScaffoldMessenger.of(context).showSnackBar(snackBarCustom(message: 'Agrege un usuario.'));
        }
      },
    );
  }
}
