import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/buttons.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DivideByTheTotal extends StatelessWidget {
  const DivideByTheTotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calculateState = Provider.of<CalculateState>(context);

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

        // LISTA a pagar
        ListView.separated(
          separatorBuilder: (context, index) => kDivder,
          padding: kPaddingSmall,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _calculateState.listaUsuarios.length,
          itemBuilder: (BuildContext context, int usuariosINDEX) {
            //////// SHOW USER NAME AND TOTAL  /////////
            return Column(
              children: [
                //// user name
                ListTile(
                  dense: true,
                  contentPadding: const EdgeInsets.all(0),
                  leading: Text(
                    '> ${_calculateState.listaUsuarios[usuariosINDEX].userNombre}',
                    style: kTextLarge,
                  ),
                  trailing: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Text(
                      ('\$  ${_calculateState.listaUsuarios[usuariosINDEX].totalAPagar.toString()}'),
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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ///// restar button
                      kIconButton(
                        onPress: () => _calculateState.restarTotal(indexUsuario: usuariosINDEX),
                        icon: Icons.remove_circle,
                      ),
                      kSizedBoxBig,
                      ///// divisor text
                      Text(
                        _calculateState.listaUsuarios[usuariosINDEX].totalDivider.toString(),
                        style: kTextSmall,
                      ),
                      kSizedBoxBig,
                      ///// sumar button
                      kIconButton(
                        onPress: () => _calculateState.sumarTotal(indexUsuario: usuariosINDEX),
                        icon: Icons.add_circle,
                      )
                    ],
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
