import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/ui/screens.dart';
import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class DivideByItemsScreen extends StatefulWidget {
  const DivideByItemsScreen({Key key}) : super(key: key);
  @override
  State<DivideByItemsScreen> createState() => _DivideByItemsScreenState();
}

class _DivideByItemsScreenState extends State<DivideByItemsScreen> {
  @override
  Widget build(BuildContext context) {
    // provider
    final _state = Provider.of<CalculateScreenState>(context);

    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: [
        // TEXTO explicativo
        Container(
          padding: kPaddingXXS,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kAzul, width: 3)),
            color: kGris300,
          ),
          child: const Text(
            'DIVIDE CADA GASTO en partes iguales o desiguales y muestra lo que debe pagar cada persona.',
            style: kTextXS,
          ),
        ),

        // REDONDEO
        Container(
          padding: kPaddingXXS,
          color: kGris100,
          child: Text(
            '> Diferencia por redondeo  \$ ${_state.bill.billRoundingDifferenceByItem.toStringAsFixed(4)}',
            style: kTextXS,
          ),
        ),

        // LISTA A PAGAR
        ListView.separated(
          separatorBuilder: (context, index) => kDivider2,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _state.usersBox.values.length,
          itemBuilder: (BuildContext context, int index) {
            // get user
            UserModel user = _state.usersBox.values.elementAt(index);

            // build data
            return ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 400),
              elevation: 0,
              expansionCallback: (int panelIndex, bool isOpen) => setState(() => user.userPanelState = !isOpen),
              expandedHeaderPadding: const EdgeInsets.all(0),
              children: [
                ExpansionPanel(
                  isExpanded: user.userPanelState,
                  canTapOnHeader: true,
                  backgroundColor: Colors.grey[50],

                  // HEADER: titulo
                  headerBuilder: (context, isOpen2) => Header(user: user, state: _state),

                  //  BODY: show expenses list
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: BuildItems(
                      user: _state.usersBox.values.elementAt(index),
                      indexxxx: index,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        kFooterSpace,
      ],
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
    this.user,
    CalculateScreenState state,
  })  : _state = state,
        super(key: key);

  final UserModel user;
  final CalculateScreenState _state;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[50],
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10), //const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            // user name
            child: Text(
              user.userName,
              style: kTextLarge,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 40),

          // show progress indicator wile is calculating
          _state.isLoading
              ? const ProgressIndicartor()
              : Row(
                  children: [
                    // price
                    Text(
                      '\$  ${user.userTotalByItem.toString()}',
                      style: kTextLarge,
                    ),
                  ],
                ),
        ],
      ),
    );
  }
}
