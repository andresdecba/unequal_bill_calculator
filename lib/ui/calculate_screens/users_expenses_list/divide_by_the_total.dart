import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class DivideByTheTotal extends StatelessWidget {
  const DivideByTheTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _state = Provider.of<CalculateScreenState>(context);
    List<UserModel> _nombres = _state.usersBox.values.toList().cast<UserModel>();

    return ListView(
      padding: const EdgeInsets.all(0),
      children: [
        // TEXTO
        Container(
          padding: kPaddingXS,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kAzul, width: 3)),
            color: kGris300,
          ),
          child: const Text(
            'DIVIDE EL TOTAL DE LA CUENTA en partes iguales o desiguales y muestra lo que debe pagar cada persona.',
            style: kTextXS,
          ),
        ),

        Container(
          padding: kPaddingXS,
          color: kGris100,
          child: Text(
            '> Diferencia por redondeo  \$ ${_state.bill.roundingDifferenceTOTAL.toStringAsFixed(4)}',
            style: kTextSmall,
          ),
        ),

        // LISTA a pagar
        ListView.separated(
          separatorBuilder: (context, index) => kDivder,
          padding: kPaddingSmall,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _nombres.length,
          itemBuilder: (BuildContext context, int usuariosINDEX) {
            // get the user
            final UserModel user = _nombres[usuariosINDEX];

            //////// SHOW USER NAME AND TOTAL  /////////
            return Column(
              children: [
                //// user name
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: Text(
                    '> ${user.userName}',
                    style: kTextLarge,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: _state.isLoading
                        ? const ProgressIndicartor()
                        : Text(
                            ('\$  ${user.totalToPay.toString()}'),
                            style: kTextLarge,
                          ),
                  ),
                ),

                // dividir desigual globalmente
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: const Text(
                    'Dividir desigual',
                    style: kTextSmall,
                  ),
                  // block the buttons wile is loading.
                  trailing: AbsorbPointer(
                    absorbing: _state.isLoading,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ///// restar button
                        kIconButton(
                          onPress: () => _state.restarTotal(user: user),
                          icon: Icons.remove_circle,
                        ),
                        kSizedBoxBig,
                        ///// divisor text
                        Text(
                          user.totalDivider.toString(),
                          style: kTextSmall,
                        ),
                        kSizedBoxBig,
                        ///// sumar button
                        kIconButton(
                          onPress: () => _state.sumarTotal(user: user),
                          icon: Icons.add_circle,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
