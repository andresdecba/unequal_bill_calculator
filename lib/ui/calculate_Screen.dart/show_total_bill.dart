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
            const Divider(),            
            Text(
              '> Total a pagar  \$ ${_propinaState.cuentaTotal.totalAPagar}',
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w900),
            ),
            const Divider(),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calcular propina  \$ ${_propinaState.cuentaTotal.propina}',
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
            const Divider(),


            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
