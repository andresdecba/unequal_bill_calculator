import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 3)
class BillModel extends HiveObject {
  BillModel({
    required this.billSubtotal,
    required this.billTip,
    required this.billTotal,
    required this.billDivider,
    required this.billRoundingDifferenceByTotal,
    required this.billRoundingDifferenceByItem,
    required this.billName,
  });

  @HiveField(0)
  double billSubtotal;
  @HiveField(1)
  double billTip;
  @HiveField(2)
  double billTotal;
  @HiveField(3)
  int billDivider;
  // @HiveField(4)
  // int totalPayersInTotalDivider;
  @HiveField(5)
  double billRoundingDifferenceByTotal;
  @HiveField(6)
  double billRoundingDifferenceByItem;
  @HiveField(7)
  String billName;

  @override
  String toString() {
    return 'Total a pagar: $billTotal, usuarios: $billDivider, Bill name: $billName';
  }
}

/*
---ABOUT THIS MODEL---
En ese modelo se muestra la informacion de la suma total de todos los gastos

---ABOUT FILEDS---
billTip: propina para les mozes **no usado en v. 1.0.0**
billSubtotal: subtotal a pagar suma de los gastos SIN la propina **no usado en v 1.0.0**
billTotal: suma de todos los gastos
billDivider: divisor que se cambia cuando el usuario hace +1 - 1 en dividir global
billRoundingDifferenceByTotal: diferencia del redondeo basado en la cuenta de los divisiores globales 
billRoundingDifferenceByItem: diferencia del redondeo basado en la cuenta de los divisiores por gasto
billName: titulo de la cuenta que se va a mostrar al enviar x whatsapp

*/