import 'package:bill_calculator/states/states.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GlobalTotalByUser extends StatelessWidget {
  const GlobalTotalByUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _calculateState = Provider.of<CalculateState>(context);
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        height: 0,
        thickness: 1,
        color: Colors.blue,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _calculateState.listaUsuarios.length,
      itemBuilder: (BuildContext context, int usuariosINDEX) {
        //////// SHOW USER NAME AND TOTAL  /////////
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            children: [
              //// user name
              ListTile(
                leading: Text(
                  _calculateState.listaUsuarios[usuariosINDEX].userNombre,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Text(
                    ('\$  ${_calculateState.listaUsuarios[usuariosINDEX].totalAPagar.toString()}'),
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
                  ),
                ),
              ),

              // dividir desigual globalmente
              ListTile(
                leading: const Text(
                  'Dividir desigual:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ///// restar button
                    IconButton(
                      onPressed: () {
                        _calculateState.restarTotal(indexUsuario: usuariosINDEX);
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 15),
                    ///// divisor text
                    Text(
                      _calculateState.listaUsuarios[usuariosINDEX].totalDivider.toString(),
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
                    ),
                    const SizedBox(width: 15),
                    ///// sumar button
                    IconButton(
                      onPressed: () {
                        _calculateState.sumarTotal(indexUsuario: usuariosINDEX);
                      },
                      icon: const Icon(
                        Icons.add_circle,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
