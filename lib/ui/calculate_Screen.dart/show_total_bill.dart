import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:bill_calculator/ui/calculate_Screen.dart/propina_dialog.dart';

class ShowTotalBill extends StatelessWidget {
  const ShowTotalBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _propinaState = Provider.of<PropinaState>(context);
    return Container(
      padding: const EdgeInsets.all(25),
      width: double.infinity,
      decoration: containerDecoration(),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ////////// MOSTRAR SUMA TOTAL + PROPINA  ///////////
            Text(
              'Sub-total \$ ${_propinaState.cuentaTotal.subTotalAPagar}',
              style: const TextStyle(fontSize: 25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Propina \$ ${_propinaState.cuentaTotal.propina}',
                  style: const TextStyle(fontSize: 25),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => const PropinaDialogBox(),
                    );
                  },
                  icon: const Icon(Icons.add_box_rounded),
                )
              ],
            ),
            Text(
              'Total a pagar: \$ ${_propinaState.cuentaTotal.totalAPagar}',
              style: const TextStyle(fontSize: 30),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
