import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/models/models.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/widgets/widgets.dart';

class DivideByTheTotalScreen extends StatelessWidget {
  const DivideByTheTotalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    final _state = Provider.of<CalculateScreenState>(context);
    //List<UserModel> _nombres = _state.usersBox.values.toList().cast<UserModel>();

    return ListView(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      children: [
        /////// DESCRIPTION /////
        Container(
          padding: kPaddingXXS,
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: kAzul, width: 3)),
            color: kGris300,
          ),
          child: const Text(
            'DIVIDE EL TOTAL DE LA CUENTA en partes iguales o desiguales y muestra lo que debe pagar cada persona.',
            style: kTextXS,
          ),
        ),

        ////// ROUND
        Container(
          padding: kPaddingXXS,
          color: kGris100,
          child: Text(
            '> Diferencia por redondeo  \$ ${_state.bill.billRoundingDifferenceByTotal.toStringAsFixed(4)}',
            style: kTextXS,
          ),
        ),

        //////////// BUILD USERS LIST ///////////
        ListView.separated(
          separatorBuilder: (context, index) => kDivider2,
          padding: const EdgeInsets.all(0),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _state.usersBox.values.length,
          itemBuilder: (BuildContext context, int index) {
            // get the user
            final UserModel user = _state.usersBox.values.elementAt(index);

            //////// SHOW USER NAME, TOTAL and divide unequal  /////////
            return Column(
              children: [
                Container(
                  color: Colors.grey[50], // user.userByGlobalFactor > 1 ? kAzul.withOpacity(0.1) : Colors.grey[50],
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0), //const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      //////////// USERNAME AND TOTAL //////////
                      /// IMPORTANT: we use "Flexible" before text widget for property text overflow working
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            // user name
                            child: Text(
                              user.userByGlobalFactor > 1 ? '> ${user.userName}' : user.userName,
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
                                      '\$  ${user.userTotalByGlobal.toString()}',
                                      style: kTextLarge,
                                    ),
                                    kSizedBoxBig,
                                  ],
                                ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Dividir desigual',
                            style: kTextSmall,
                          ),
                          SubstractAddButtons(
                            isLoading: _state.isLoading,
                            addBttn: () => _state.sumarTotal(user: user),
                            quantity: user.userByGlobalFactor.toString(),
                            sunstractBttn: () => _state.restarTotal(user: user),
                          ),
                        ],
                      ),
                    ],
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
