// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routine_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RoutineAdapter extends TypeAdapter<Routine> {
  @override
  final int typeId = 0;

  @override
  Routine read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Routine(
      title: fields[0] as String,
      description: fields[1] as String,
      frequency: fields[2] as DateTime,
      isCompleted: fields[3] as bool,
      status: fields[4] as Status,
    );
  }

  @override
  void write(BinaryWriter writer, Routine obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.frequency)
      ..writeByte(3)
      ..write(obj.isCompleted)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RoutineAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class StatusAdapter extends TypeAdapter<Status> {
  @override
  final int typeId = 1;

  @override
  Status read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return Status.pending;
      case 1:
        return Status.completed;
      case 2:
        return Status.missed;
      default:
        return Status.pending;
    }
  }

  @override
  void write(BinaryWriter writer, Status obj) {
    switch (obj) {
      case Status.pending:
        writer.writeByte(0);
        break;
      case Status.completed:
        writer.writeByte(1);
        break;
      case Status.missed:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
