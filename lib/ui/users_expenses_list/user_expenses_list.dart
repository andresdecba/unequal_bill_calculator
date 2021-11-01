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

    return Scaffold(
      body: SingleChildScrollView(
        child: ListView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          itemCount: _state.listaUsuarios.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              children: [
                ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  tileColor: Colors.amber,

                  // user name
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      '> ${_state.listaUsuarios[index].userNombre}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),

                  // user to pay
                  trailing: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '\$ ${_state.listaUsuarios[index].totalAPagarByOne.toString()}',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                ExpansionPanelList(
                  expandedHeaderPadding: const EdgeInsets.all(0),
                  elevation: 0,
                  expansionCallback: (int panelIndex, bool isOpen) => setState(() => _state.listaUsuarios[index].isPanelOpen = !isOpen),
                  children: [
                    ExpansionPanel(
                      isExpanded: _state.listaUsuarios[index].isPanelOpen,
                      backgroundColor: Colors.grey[300],

                      // HEADER: titulo
                      headerBuilder: (context, isOpen2) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: _state.listaUsuarios[index].isPanelOpen == false
                              ? const Text(
                                  'Mostrar detalles',
                                  style: TextStyle(fontSize: 20),
                                )
                              : const Text(
                                  'Ocultar',
                                  style: TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
                                ),
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
              ],
            );
          },
        ),
      ),
    );
  }
}
