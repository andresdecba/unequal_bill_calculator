// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_expense_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserExpenseModelAdapter extends TypeAdapter<UserExpenseModel> {
  @override
  final int typeId = 1;

  @override
  UserExpenseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserExpenseModel(
      expense: fields[0] as ExpenseModel,
      multiplyBy: fields[1] as int,
      toPay: fields[2] as double,
      isAdded: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, UserExpenseModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.expense)
      ..writeByte(1)
      ..write(obj.multiplyBy)
      ..writeByte(2)
      ..write(obj.toPay)
      ..writeByte(3)
      ..write(obj.isAdded);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserExpenseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
