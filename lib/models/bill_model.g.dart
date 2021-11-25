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
      billSubtotal: fields[0] as double,
      billTip: fields[1] as double,
      billTotal: fields[2] as double,
      billDivider: fields[3] as int,
      billRoundingDifferenceByTotal: fields[5] as double,
      billRoundingDifferenceByItem: fields[6] as double,
      billName: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, BillModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.billSubtotal)
      ..writeByte(1)
      ..write(obj.billTip)
      ..writeByte(2)
      ..write(obj.billTotal)
      ..writeByte(3)
      ..write(obj.billDivider)
      ..writeByte(5)
      ..write(obj.billRoundingDifferenceByTotal)
      ..writeByte(6)
      ..write(obj.billRoundingDifferenceByItem)
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
