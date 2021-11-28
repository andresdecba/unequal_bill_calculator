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

        ////// ROUND
        Container(
          padding: kPaddingXS,
          color: kGris100,
          child: Text(
            '> Diferencia por redondeo  \$ ${_state.bill.billRoundingDifferenceByTotal.toStringAsFixed(4)}',
            style: kTextSmall,
          ),
        ),

        //////////// BUILD USERS LIST ///////////
        ListView.separated(
          separatorBuilder: (context, index) => kDivderBlue,
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
                  color: user.userByGlobalFactor > 1 ? kGris300 : Colors.grey[50],
                  width: double.infinity,
                  padding: kPaddingSmall, //const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      //////////// USERNAME AND TOTAL //////////
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            // user name
                            child: Text(
                              '> ${user.userName}',
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
