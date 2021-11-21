// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      userName: fields[1] as String,
      totalToPay: fields[2] as double,
      totalToPayByExpense: fields[3] as double,
      isPanelOpen: fields[0] as bool,
      totalDivider: fields[4] as int,
      userExpensesList2: (fields[6] as HiveList).castHiveList(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.isPanelOpen)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.totalToPay)
      ..writeByte(3)
      ..write(obj.totalToPayByExpense)
      ..writeByte(4)
      ..write(obj.totalDivider)
      ..writeByte(6)
      ..write(obj.userExpensesList2);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
