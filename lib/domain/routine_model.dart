// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'routine_model.g.dart';

@HiveType(typeId: 0)
class Routine extends HiveObject implements Equatable {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime frequency;
  @HiveField(3)
  bool isCompleted;
  @HiveField(4)
  Status status;

   Routine({
    required this.title,
    required this.description,
    required this.frequency,
    this.isCompleted = false,
    required this.status,
  });
  @override
  String toString() {
    return 'Routine{title: $title, description: $description, frequency: $frequency, isCompleted: $isCompleted, status: $status}';
  }

  Routine copyWith({
    String? title,
    String? description,
    DateTime? frequency,
    bool? isCompleted,
    Status? status,
  }) {
    return Routine(
      title: title ?? this.title,
      description: description ?? this.description,
      frequency: frequency ?? this.frequency,
      isCompleted: isCompleted ?? this.isCompleted,
      status: status ?? this.status,
    );
  }
  
  @override
  List<Object?> get props => [title, description, frequency, isCompleted, status];
  
  @override
  bool? get stringify => true;
}

@HiveType(typeId: 1)
enum Status {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed,
  @HiveField(2)
  missed,
}
