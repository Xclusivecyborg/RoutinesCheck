import 'package:routine_checks_mobile/domain/enum.dart';

class Frequency {
  String name;
  DateTime frequency;
  bool isSelected;
  FrequencyType type;

  Frequency({
    required this.name,
    required this.frequency,
    this.isSelected = false,
   required  this.type,
  });

  factory Frequency.fromJson(Map<String, dynamic> json) => Frequency(
        name: json["name"] ?? "",
        frequency:
            DateTime.parse(json["frequency"] ?? DateTime.now().toString()),
        isSelected: json["isSelected"] ?? false,
        type: FrequencyType.values[json["type"] ?? FrequencyType.hourly],
      );
}
