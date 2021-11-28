import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:animate_do/animate_do.dart';

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
    //List<UserModel> _usersList = _state.usersBox.values.toList();

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
                : ListView.separated(
                    itemCount: _state.usersBox.values.length,
                    reverse: true,
                    dragStartBehavior: DragStartBehavior.start,
                    padding: const EdgeInsets.all(0),
                    separatorBuilder: (BuildContext context, int index) => kDivder,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      //
                      final user = _state.usersBox.values.elementAt(index);
                
                      return FadeInDown(
                        duration: const Duration(milliseconds: 3000),
                        animate: true,
                        child: NameAndPriceTile(
                          title: user.userName,
                          deleteFnc: () => _state.eliminarUsuario(user: user),
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
