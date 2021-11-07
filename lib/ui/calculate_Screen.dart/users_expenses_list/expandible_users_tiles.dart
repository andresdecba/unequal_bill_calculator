import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'divide_by_items.dart';

class ExpandibleUsersTiles extends StatefulWidget {
  const ExpandibleUsersTiles({Key? key}) : super(key: key);
  @override
  State<ExpandibleUsersTiles> createState() => _ExpandibleUsersTilesState();
}

class _ExpandibleUsersTilesState extends State<ExpandibleUsersTiles> {
  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<CalculateState>(context);

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

        // LISTA A PAGAR
        ListView.separated(
          separatorBuilder: (context, index) => const Divider(
            color: kAzul,
            thickness: 1,
          ),
          padding: kPaddingSmall,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _state.listaUsuarios.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                // EXPANSIBLE TILE
                ExpansionPanelList(
                  animationDuration: const Duration(milliseconds: 400),
                  elevation: 0,
                  expansionCallback: (int panelIndex, bool isOpen) => setState(
                    () => _state.listaUsuarios[index].isPanelOpen = !isOpen,
                  ),
                  expandedHeaderPadding: EdgeInsets.all(0),
                  children: [
                    ExpansionPanel(
                      isExpanded: _state.listaUsuarios[index].isPanelOpen,
                      canTapOnHeader: true,
                      backgroundColor: Colors.grey[50],

                      // HEADER: titulo
                      headerBuilder: (context, isOpen2) {
                        return nombre(_state, index);
                      },

                      //  BODY: show expenses list
                      body: DivideByItems(state: _state, usuariosINDEX: index),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  ListTile nombre(CalculateState _state, int index) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      //tileColor: Colors.grey[300],

      // user name
      title: Text(
        '> ${_state.listaUsuarios[index].userNombre}',
        style: kTextLarge,
      ),

      // user to pay
      trailing: Text(
        '\$ ${_state.listaUsuarios[index].totalAPagarByOne.toString()}',
        style: kTextLarge,
      ),
    );
  }
}
