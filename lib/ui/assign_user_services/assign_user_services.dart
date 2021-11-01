// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'package:bill_calculator/states/states.dart';

// class AssignUserServices extends StatefulWidget {
//   const AssignUserServices({Key? key, required this.indexUsuario}) : super(key: key);
//   final int indexUsuario;
//   @override
//   State<AssignUserServices> createState() => _AssignUserServicesState();
// }

// class _AssignUserServicesState extends State<AssignUserServices> {
//   @override
//   Widget build(BuildContext context) {
//     // provider
//     final _state = Provider.of<CalculateState>(context);

//     return Scaffold(
//       floatingActionButton: const DoneButton(),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             ////////// TITLE ///////// 08103450310
//             Container(
//               padding: const EdgeInsets.only(top: 75, bottom: 50, left: 25, right: 25),
//               width: double.infinity,
//               decoration: const BoxDecoration(
//                 color: Colors.amber,
//               ),
//               child: Text(
//                 'ASIGNE LOS GASTOS QUE PAGA\n "${_state.listaUsuarios[widget.indexUsuario].userNombre}"',
//                 style: const TextStyle(fontSize: 30, fontFamily: 'Highman'),
//                 textAlign: TextAlign.center,
//               ),
//             ),

//             /////////// SERVICES ////////////
//             FittedBox(
//               fit: BoxFit.contain,

//               child: DataTable(
//                 checkboxHorizontalMargin: 15,
//                 dataRowHeight: 60,
//                 headingTextStyle: const TextStyle(
//                   fontSize: 25,
//                   color: Colors.black,
//                   fontFamily: 'OpenSans_Condensed-Regular',
//                 ),
//                 headingRowColor: MaterialStateColor.resolveWith((states) => Color(0xFFEEEEEE)),
//                 showBottomBorder: true,
//                 showCheckboxColumn: true,

//                 ////colums
//                 columns: const <DataColumn>[
//                   DataColumn(
//                     label: Text(
//                       'SERVICIO',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'MONTO',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
//                     ),
//                   ),
//                   DataColumn(
//                     label: Text(
//                       'DIVIDIR DESIGUAL',
//                       style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
//                     ),
//                   ),
//                 ],

//                 ////rows
//                 rows: _state.listaServicios.map((item) {
//                   // INDEX DEL SERVICIO del usuario
//                   int servicioUsuarioIndex = _state.listaUsuarios[widget.indexUsuario].servicios.indexWhere((element) => element.servicio == item);

//                   return DataRow(
//                     // si el usuario tiene el servicio agregado poner el check en selected
//                     selected: _state.listaUsuarios[widget.indexUsuario].servicios.map((e) => e.servicio).contains(item),

//                     // 1- buscar, 2- si el usuario no tiene el servicio, agregarlo, si no, quitarlo.
//                     onSelectChanged: (isSelected) => setState(() {
//                       _state.listaUsuarios[widget.indexUsuario].servicios.map((e) => e.servicio).contains(item) == false
//                           ? _state.agregarServicioUsuario(indexUsuario: widget.indexUsuario, servicio: item)
//                           : _state.quitarServicioUsuario(indexUsuario: widget.indexUsuario, servicio: item);
//                       print(_state.listaUsuarios[widget.indexUsuario].servicios);
//                     }),

//                     cells: <DataCell>[
//                       DataCell(
//                         Text(item.servicioNombre),
//                       ),
//                       DataCell(
//                         Text(item.precio.toString()),
//                       ),

//                       //////////////////////////////////////////
//                       //////// ADD - SUBSTRACT BUTTONS ////////
//                       DataCell(
//                         _state.listaUsuarios[widget.indexUsuario].servicios.map((e) => e.servicio).contains(item)
//                             ///// ENABLE UNEQUAL DIVIDE
//                             ? Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       _state.restarMultiplicador(indexUsuario: widget.indexUsuario, indexServicio: servicioUsuarioIndex);
//                                     },
//                                     icon: const Icon(Icons.remove),
//                                   ),
//                                   Text(_state.listaUsuarios[widget.indexUsuario].servicios[servicioUsuarioIndex].multiplicarPor.toString()),
//                                   IconButton(
//                                     onPressed: () {
//                                       _state.sumarMultiplicador(indexUsuario: widget.indexUsuario, indexServicio: servicioUsuarioIndex);
//                                     },
//                                     icon: const Icon(
//                                       Icons.add,
//                                     ),
//                                   ),
//                                 ],
//                               )

//                             ///// DISABLE UNEQUAL DIVIDE
//                             : Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: const [
//                                   IconButton(
//                                     onPressed: null,
//                                     icon: Icon(
//                                       Icons.remove,
//                                       color: Color(0xFFE0E0E0),
//                                     ),
//                                   ),
//                                   Text(
//                                     '0',
//                                     style: TextStyle(color: Color(0xFFE0E0E0)),
//                                   ),
//                                   IconButton(
//                                     onPressed: null,
//                                     icon: Icon(
//                                       Icons.add,
//                                       color: Color(0xFFE0E0E0),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                       ),

//                       //////// ADD - SUBSTRACT BUTTONS ////////
//                       //////////////////////////////////////////
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ),
//             const SizedBox(height: 60)
//           ],
//         ),
//       ),
//     );
//   }
// }

// class DoneButton extends StatelessWidget {
//   const DoneButton({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FloatingActionButton.extended(
//       onPressed: () => Navigator.pop(context),
//       label: const Text(
//         'HECHO >',
//         style: TextStyle(color: Colors.black, fontFamily: 'Highman', fontSize: 20, height: 1.2),
//       ),
//     );
//   }
// }
