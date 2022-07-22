import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/domain/percentage.dart';

class RoutineProgressBar extends StatelessWidget {
  const RoutineProgressBar({
    Key? key,
    required this.percent,
  }) : super(key: key);
  final Percentage percent;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(10),
          height: 20,
          width: 20,
          decoration: BoxDecoration(
            border: Border.all(),
            color: percent.color,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        Text(
          '${percent.value.toStringAsFixed(1)}%',
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 10),
        Container(
          height: 5,
          width: (percent.value / 100) * MediaQuery.of(context).size.width / 3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: percent.color,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            percent.name,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
