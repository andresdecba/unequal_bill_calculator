import 'package:bill_calculator/states/states.dart';
import 'package:bill_calculator/ui/users_expenses_list/show_expenses_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserExpensesList extends StatefulWidget {
  const UserExpensesList({Key? key}) : super(key: key);
  @override
  State<UserExpensesList> createState() => _UserExpensesListState();
}

class _UserExpensesListState extends State<UserExpensesList> {
  @override
  Widget build(BuildContext context) {
    final _state = Provider.of<CalculateState>(context);

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: _state.listaUsuarios.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            
            // EXPANSIBLE TILE
            ExpansionPanelList(
              animationDuration: const Duration(milliseconds: 400),
              elevation: 0,
              expansionCallback: (int panelIndex, bool isOpen) => setState(
                () => _state.listaUsuarios[index].isPanelOpen = !isOpen,
              ),
              children: [
                ExpansionPanel(
                  isExpanded: _state.listaUsuarios[index].isPanelOpen,
                  backgroundColor: Colors.amber,

                  // HEADER: titulo
                  headerBuilder: (context, isOpen2) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: nombre(_state, index),
                    );
                  },

                  //  BODY: show expenses list
                  body: ExpensesList(
                    state: _state,
                    usuariosINDEX: index,
                  ),
                ),
              ],
            ),
            const Divider(),
          ],
        );
      },
    );
  }

  ListTile nombre(CalculateState _state, int index) {
    return ListTile(
      //contentPadding: const EdgeInsets.all(4),
      tileColor: Colors.amber,

      // user name
      title: Text(
        '> ${_state.listaUsuarios[index].userNombre}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
      ),

      // user to pay
      trailing: Text(
        '\$ ${_state.listaUsuarios[index].totalAPagarByOne.toString()}',
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
      ),
    );
  }
}
