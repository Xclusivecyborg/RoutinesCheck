import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/percentage.dart';
import 'package:routine_checks_mobile/features/home/widgets/home_header.dart';
import 'package:routine_checks_mobile/features/home/widgets/list_of_routines.dart';
import 'package:routine_checks_mobile/features/home/widgets/routine_progress_bar.dart';
import 'package:routine_checks_mobile/utils/colors.dart';
import 'package:routine_checks_mobile/widgets/empty.dart';
import 'package:routine_checks_mobile/widgets/progress_indicator.dart';

import '../../../providers/state_notifier_providers.dart';

class Home extends ConsumerStatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();
    _expireUndoneRoutines();
  }

  void _expireUndoneRoutines() async {
    await ref.read(addRoutineViewmdodelProvider.notifier).expireRoutine();
  }

  @override
  Widget build(BuildContext context) {
    _expireUndoneRoutines();
    final model = ref.read(addRoutineViewmdodelProvider.notifier);
    final state = ref.watch(addRoutineViewmdodelProvider);
    double completed = model.calculateCompletedRoutinesPercentage();
    double missed = model.calculateMissedRoutinesPercentage();
    double pending = model.calculatePendingRoutinesPercentage();
    double completedPercentage = completed / (completed + missed) * 100;

    List<Percentage> progresspercents = [
      Percentage(value: completed, color: AppColors.purple, name: 'Completed'),
      Percentage(value: missed, color: AppColors.red, name: 'Missed'),
      Percentage(value: pending, color: Colors.black, name: 'Pending'),
    ];

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              HomeHeader(state: state),
              const SizedBox(height: 30),
              RoutineProgressIndicator(
                completed: completed,
                missed: missed,
                pending: pending,
              ),
              const SizedBox(height: 30),
              if (state.routines.isNotEmpty)
                Text(
                  completedPercentage >= 70.0
                      ? 'Good job! You have ${completedPercentage >= 70.0 && completedPercentage < 100.0 ? "over " : ""}${completedPercentage.toInt()}% check rate for this routine'
                      : 'You have not done enough checks for this routine.',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 20),
              ...progresspercents.map((percent) {
                return RoutineProgressBar(
                  percent: percent,
                );
              }),
              const Padding(
                padding: EdgeInsets.fromLTRB(8.0, 40, 28, 10),
                child: Text(
                  'My Routines',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              state.routines.isEmpty ? const Empty() : const RoutinesList(),
            ],
          ),
        ),
      ),
    );
  }
}
