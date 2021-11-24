import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 3)
class BillModel extends HiveObject {
  BillModel({
    required this.subtotalToPay,
    required this.tip,
    required this.totalToPay,
    required this.usersLenght,
    //required this.totalPayersInTotalDivider,
    required this.roundingDifferenceTOTAL,
    required this.roundingDifferenceITEM,
    required this.billName,
  });

  @HiveField(0)
  double subtotalToPay;
  @HiveField(1)
  double tip;
  @HiveField(2)
  double totalToPay;
  @HiveField(3)
  int usersLenght;
  // @HiveField(4)
  // int totalPayersInTotalDivider;
  @HiveField(5)
  double roundingDifferenceTOTAL;
  @HiveField(6)
  double roundingDifferenceITEM;
  @HiveField(7)
  String billName;

  @override
  String toString() {
    return 'Total a pagar: $totalToPay, usuarios: $usersLenght, Bill name: $billName';
  }
}

/*
---ABOUT THIS MODEL---
En ese modelo se muestra la informacion de la suma total de todos los gastos

---ABOUT FILEDS---
tip: propina para les mozes **no usado en v. 1.0.0**
subtotalToPay: subtotal a pagar suma de los gastos SIN la propina **no usado en v 1.0.0**
totalToPay: suma de todos los gastos
usersLenght: cantidad de usuarios
roundingDifferenceTOTAL: diferencia del redondeo basado en la cuenta de los divisiores globales 
roundingDifferenceITEM: diferencia del redondeo basado en la cuenta de los divisiores por gasto
billName: titulo de la cuenta que se va a mostrar al enviar x whatsapp

*/