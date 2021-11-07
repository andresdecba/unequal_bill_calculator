import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';

class TotalBill extends StatelessWidget {
  const TotalBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _propinaState = Provider.of<PropinaState>(context);
    final _calculateState = Provider.of<CalculateState>(context);
    return Container(
      padding: kPaddingSmall,
      color: kAmarillo,
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //const SizedBox(height: 20),
            ////////// MOSTRAR SUMA TOTAL
            Text(
              '> Total a pagar  \$ ${_propinaState.cuentaTotal.totalAPagar}',
              style: kTextXXL,
            ),
            const SizedBox(height: 15),
            kDivder,
            Text(
              '> Diferencia por redondeo:  ${_calculateState.listaUsuarios.length}',
              style: kTextSmall,
            ),
            kDivder,
            Text(
              '> Total de pagadores:  ${_calculateState.listaUsuarios.length}',
              style: kTextSmall,
            ),
            kDivder,
            Text(
              '> Total de gastos:  ${_calculateState.listaServicios.length}',
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
