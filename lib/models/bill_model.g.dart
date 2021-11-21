// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bill_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BillModelAdapter extends TypeAdapter<BillModel> {
  @override
  final int typeId = 3;

  @override
  BillModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BillModel(
      subtotalToPay: fields[0] as double,
      propina: fields[1] as double,
      totalToPay: fields[2] as double,
      divideByAllUsers: fields[3] as int,
      totalPayersInTotalDivider: fields[4] as int,
      roundingDifferenceTOTAL: fields[5] as double,
      roundingDifferenceITEM: fields[6] as double,
      billName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.subtotalToPay)
      ..writeByte(1)
      ..write(obj.propina)
      ..writeByte(2)
      ..write(obj.totalToPay)
      ..writeByte(3)
      ..write(obj.divideByAllUsers)
      ..writeByte(4)
      ..write(obj.totalPayersInTotalDivider)
      ..writeByte(5)
      ..write(obj.roundingDifferenceTOTAL)
      ..writeByte(6)
      ..write(obj.roundingDifferenceITEM)
      ..writeByte(7)
      ..write(obj.billName);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BillModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
