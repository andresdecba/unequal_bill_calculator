import 'package:hive/hive.dart';

part 'bill_model.g.dart';

@HiveType(typeId: 3)
class BillModel extends HiveObject {
  BillModel({
    required this.subtotalToPay,
    required this.propina,
    required this.totalToPay,
    required this.divideByAllUsers,
    required this.totalPayersInTotalDivider,
    required this.roundingDifferenceTOTAL,
    required this.roundingDifferenceITEM,
    required this.billName,
  });

  @HiveField(0)
  double subtotalToPay;
  @HiveField(1)
  double propina;
  @HiveField(2)
  double totalToPay;
  @HiveField(3)
  int divideByAllUsers;
  @HiveField(4)
  int totalPayersInTotalDivider;
  @HiveField(5)
  double roundingDifferenceTOTAL;
  @HiveField(6)
  double roundingDifferenceITEM;
  @HiveField(7)
  String billName;

  @override
  String toString() {
    return 'Total a pagar: $totalToPay, usuarios: $divideByAllUsers, Bill name: $billName';
  }
}
