import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class ExpandibleUsersTiles extends StatefulWidget {
  const ExpandibleUsersTiles({Key? key}) : super(key: key);
  @override
  State<ExpandibleUsersTiles> createState() => _ExpandibleUsersTilesState();
}

class _ExpandibleUsersTilesState extends State<ExpandibleUsersTiles> {
  

  @override
  Widget build(BuildContext context) {
    // provider
    final _state = Provider.of<CalculateScreenState>(context);
    List<UserModel> _nombres = _state.usersBox.values.toList().cast<UserModel>();

    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: [
        // TEXTO explicativo
        Container(
          padding: kPaddingXS,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kAzul, width: 3)),
            color: kGris300,
          ),
          child: const Text(
            'DIVIDE CADA GASTO en partes iguales o desiguales y muestra lo que debe pagar cada persona.',
            style: kTextXS,
          ),
        ),

        Container(
          padding: kPaddingXS,
          color: kGris100,
          child: Text(
            '> Diferencia por redondeo  \$ ${_state.bill.billRoundingDifferenceByItem.toStringAsFixed(4)}',
            style: kTextSmall,
          ),
        ),

        // LISTA A PAGAR
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: kAzul,
            thickness: 1,
          ),
          padding: kPaddingSmall,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _nombres.length,
          itemBuilder: (BuildContext context, int index) {
            // get user
            final user = _nombres[index];

            // build data
            return Column(
              children: [
                // EXPANSIBLE TILE
                ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 400),
                  elevation: 0,
                  expansionCallback: (int panelIndex, bool isOpen) => setState(
                    () => user.userPanelState = !isOpen,
                  ),
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  children: [
                    ExpansionPanel(
                      isExpanded: user.userPanelState,
                      canTapOnHeader: true,
                      backgroundColor: Colors.grey[50],

                      // HEADER: titulo
                      headerBuilder: (context, isOpen2) {
                        return nombre(_state, user);
                      },

                      //  BODY: show expenses list
                      body: DivideByExpenses(
                        user: user,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
        kFooterSpace,
      ],
    );
  }

  ListTile nombre(CalculateScreenState _state, UserModel user) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      //tileColor: Colors.grey[300],

      // user name
      title: Text(
        '> ${user.userName}',
        style: kTextLarge,
      ),

      // user to pay
      trailing: _state.isLoading
          ? const ProgressIndicartor()
          : Text(
              '\$ ${user.userTotalByItem.toString()}',
              style: kTextLarge,
            ),
    );
  }
}
