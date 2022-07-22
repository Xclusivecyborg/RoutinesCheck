import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/features/add_routine/notifier/add_routine_notifier.dart';
import 'package:routine_checks_mobile/features/routine_overview/pages/routine_overview.dart';
import 'package:routine_checks_mobile/providers/state_notifier_providers.dart';
import 'package:routine_checks_mobile/utils/colors.dart';


class RoutinesList extends ConsumerStatefulWidget {
  const RoutinesList({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<RoutinesList> createState() => _RoutinesListState();
}

class _RoutinesListState extends ConsumerState<RoutinesList> {
  @override
  void initState() {
    ref.read(addRoutineViewmdodelProvider.notifier).expireRoutine();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final model = ref.read(addRoutineViewmdodelProvider.notifier);
    final state = ref.watch(addRoutineViewmdodelProvider);

    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.purple[100]!,
              width: 1,
            ),
            boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 7,
                spreadRadius: 0.5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          padding: const EdgeInsets.all(7.0),
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => RoutineOverView(
                    routine: state.routines[index],
                  ),
                ),
              );
            },
            leading: Column(
              children: [
                InkWell(
                  onTap: state.routines[index].status == Status.missed
                      ? null
                      : () {
                          setState(() {
                            _changeRoutineStatus(state, index, model);
                          });
                        },
                  child: Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
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
                    child: state.routines[index].status == Status.completed
                        ? const Icon(
                            Icons.check,
                            color: AppColors.deepGreen,
                          )
                        : state.routines[index].status == Status.missed
                            ? const Icon(
                                Icons.close,
                                color: AppColors.red,
                              )
                            : const Icon(
                                Icons.timer,
                                color: Colors.black87,
                              ),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  state.routines[index].status.name,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            title: Text(
              state.routines[index].title,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                decoration: state.routines[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            subtitle: Text(
              state.routines[index].description,
              style: TextStyle(
                decoration: state.routines[index].isCompleted
                    ? TextDecoration.lineThrough
                    : null,
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
          ),
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: state.routines.length,
    );
  }

  void _changeRoutineStatus(
      AddRoutineState state, int index, AddRoutineNotifier model) {
    state.routines[index].isCompleted = !state.routines[index].isCompleted;
    if (state.routines[index].status == Status.pending) {
      state.routines[index].status = Status.completed;
      model.editRoutine(
        state.routines[index].copyWith(status: Status.completed),
      );
    } else {
      state.routines[index].status = Status.pending;
      model.editRoutine(
        state.routines[index].copyWith(
          status: Status.pending,
        ),
      );
    }
  }
}
