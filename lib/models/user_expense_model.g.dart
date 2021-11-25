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
      userExpenseExpense: fields[0] as ExpenseModel,
      userExpenseByItemFactor: fields[1] as int,
      userExpenseTotal: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, UserExpenseModel obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userExpenseExpense)
      ..writeByte(1)
      ..write(obj.userExpenseByItemFactor)
      ..writeByte(2)
      ..write(obj.userExpenseTotal);
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
