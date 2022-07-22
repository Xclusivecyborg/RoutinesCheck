import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/widgets/empty.dart';
import 'package:routine_checks_mobile/widgets/routine_card.dart';
import '../../../providers/state_notifier_providers.dart';

class UpNext extends ConsumerWidget {
  const UpNext({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Routine> routines = ref
        .read(addRoutineViewmdodelProvider.notifier)
        .filterNext12HoursRoutines();
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Up Next',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          routines.isEmpty
              ? const Empty()
              : Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) {
                      return UpNextRoutineWidet(
                        routine: routines[index],
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: routines.length,
                    shrinkWrap: true,
                  ),
                ),
        ],
      ),
    ));
  }
}
