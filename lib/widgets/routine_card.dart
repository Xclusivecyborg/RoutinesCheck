import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/utils/colors.dart';

class UpNextRoutineWidet extends StatelessWidget {
  const UpNextRoutineWidet({
    Key? key,
    required this.routine,
    this.canChange = false,
    this.onChange,
    this.value = false,
  }) : super(key: key);

  final Routine routine;
  final bool canChange;
  final bool value;
  final void Function(bool?)? onChange;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(15.0),
          margin: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          routine.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          routine.description,
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: AppColors.purple,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          _formatDate(
                            routine.frequency,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (canChange)
                      Row(
                        children: [
                          Checkbox(
                            value: value,
                            onChanged: onChange,
                          ),
                          const Text(
                            'Mark as done',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      )
                  ],
                ),
              ),
              CompletedChip(routine: routine),
            ],
          ),
        ),
        Positioned(
          top: 12,
          left: 10,
          child: Container(
            height: 50,
            width: 10,
            decoration: BoxDecoration(
              color: AppColors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ],
    );
  }
}

class CompletedChip extends StatelessWidget {
  const CompletedChip({
    Key? key,
    required this.routine,
  }) : super(key: key);

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.purple[50]!,
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: routine.status == Status.completed
              ? const Icon(
                  Icons.check,
                  color: AppColors.deepGreen,
                )
              : routine.status == Status.missed
                  ? const Icon(
                      Icons.close,
                      color: AppColors.red,
                    )
                  : const Icon(
                      Icons.timer,
                      color: AppColors.purple,
                    ),
        ),
        const SizedBox(height: 10),
        Text(
          routine.status.name,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}

String _formatDate(DateTime date) {
  return '${date.day},${date.month},${date.year}';
}
