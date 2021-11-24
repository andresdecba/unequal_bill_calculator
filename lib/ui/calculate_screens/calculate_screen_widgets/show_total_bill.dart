import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class ShowTotalBill extends StatelessWidget {
  const ShowTotalBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // state
    final _state = Provider.of<CalculateAllState>(context);

    return Container(
      padding: kPaddingSmall,
      color: kAmarillo,
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ////////// MOSTRAR SUMA TOTAL
            Text(
              '"${_state.bill.billName}"',
              style: kTextMedium,
            ),
            const SizedBox(height: 15),
            Text(
              '> Total a pagar  \$ ${_state.bill.totalToPay}',
              style: kTextXXL,
            ),
            const SizedBox(height: 15),

            kDivder,
            Text(
              '> Total de pagadores:  ${_state.usersBox.length}',
              style: kTextSmall,
            ),
            kDivder,
            Text(
              '> Total de gastos:  ${_state.expensesBox.length}',
              style: kTextSmall,
            ),
            kDivder,

            ////////// MOSTRAR PROPINA
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Calcular propina  \$ ${_propinaState.cuentaTotal.propina}',
            //       style: kTextMedium,
            //     ),
            //     kIconButton(
            //       onPress: () {
            //         showDialog(
            //           context: context,
            //           builder: (context) => const PropinaDialogBox(),
            //         );
            //       },
            //       icon: Icons.arrow_forward,
            //     )
            //   ],
            // ),
            // kDivder,
            //kSizedBoxBig,
          ],
        ),
      ),
    );
  }
}
