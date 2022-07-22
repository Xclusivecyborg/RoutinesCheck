import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/domain/frequency.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/providers/service_providers.dart';

class AddRoutineNotifier extends StateNotifier<AddRoutineState> {
  AddRoutineNotifier(this._ref) : super(AddRoutineState.initial(_ref));
  final Ref _ref;

//Adds a new routine to the database
  void addRoutine(Routine routine) async {
    _ref.read(routineRepositoryProvivder).addRoutine(routine);
    var newroutines = _ref.watch(routineRepositoryProvivder).getRoutines();
    state = state.copyWith(
      routines: [...newroutines, routine],
    );
    await Future.delayed(const Duration(seconds: 2));
    scheduleNotification(routine);
  }

//Schedule a notification for the routine created
  void scheduleNotification(Routine routine) {
    var newroutines = _ref.watch(routineRepositoryProvivder).getRoutines();
    Map<int, Routine> mapforoutines = newroutines.asMap();
    int id = mapforoutines.entries
        .firstWhere((element) => element.value.frequency == routine.frequency)
        .key;
    _ref.read(notificationProvider).show(
          id: id,
          title: newroutines.last.title,
          body: newroutines.last.description,
          periodically: state.selectedFrequency!.type,
          shceduleDate: newroutines.last.frequency.subtract(
            const Duration(
              minutes: 5,
            ),
          ),
        );
  }

//Cancels notification once a routine is missed
  void cancelNotification(id) {
    _ref.read(notificationProvider).cancel(id);
  }

//Marks a routines as missed
  Future<void> expireRoutine() async {
    DateTime todaysDate = DateTime.now().add(
      const Duration(
        minutes: 5,
      ),
    );
    List<Routine> routines = state.routines;
    Map<int, Routine> mapforoutines = routines.asMap();
    for (var element in routines) {
      if (element.frequency.isBefore(todaysDate) &&
          element.status == Status.pending) {
        await _ref.read(routineRepositoryProvivder).editRoutine(
              element.copyWith(
                status: Status.missed,
              ),
            );
        int id = mapforoutines.entries
            .firstWhere(
              (nlelement) => nlelement.value.frequency == element.frequency,
            )
            .key;
        cancelNotification(id);
      }
    }
  }

//Selects a frequency for the routine to be created
  void selectFrequency(Frequency frequency) {
    state = state.copyWith(
      selectedFrequency: frequency,
    );
  }

//Edits a routine in the database
  Future<void> editRoutine(Routine routine) async {
    _ref.read(routineRepositoryProvivder).editRoutine(routine);
  }

//Calculates the percentage of routines completed
  double calculateCompletedRoutinesPercentage() {
    double progress = 0;
    List<Routine> completedRoutines = state.routines
        .where((element) => element.status == Status.completed)
        .toList();
    if (completedRoutines.isNotEmpty) {
      progress = completedRoutines.length / state.routines.length * 100;
    }
    return progress;
  }

//calculates the percentage of routines missed
  double calculateMissedRoutinesPercentage() {
    double progress = 0;
    List<Routine> missedRoutines = state.routines
        .where((element) => element.status == Status.missed)
        .toList();
    if (missedRoutines.isNotEmpty) {
      progress = missedRoutines.length / state.routines.length * 100;
    }
    return progress;
  }

//calculates the percentage of routines pending
  double calculatePendingRoutinesPercentage() {
    double progress = 0;
    List<Routine> pendingRoutines = state.routines
        .where((element) => element.status == Status.pending)
        .toList();
    if (pendingRoutines.isNotEmpty) {
      progress = pendingRoutines.length / state.routines.length * 100;
    }
    return progress;
  }

// Filters the routines that will occur in the next 12 hours
  List<Routine> filterNext12HoursRoutines() {
    const Duration duration = Duration(hours: 12);
    List<Routine> filtered12HoursRoutines = state.routines.where((element) {
      return element.frequency.isBefore(DateTime.now().add(duration)) &&
          element.status == Status.pending;
    }).toList();
    return filtered12HoursRoutines;
  }
}

class AddRoutineState {
  List<Routine> routines;
  Frequency? selectedFrequency;
  AddRoutineState({
    required this.routines,
    this.selectedFrequency,
  });

  static initial(Ref ref) {
    return AddRoutineState(
      routines: ref.read(routineRepositoryProvivder).getRoutines(),
    );
  }

  AddRoutineState copyWith({
    List<Routine>? routines,
    Frequency? selectedFrequency,
  }) {
    return AddRoutineState(
      routines: routines ?? this.routines,
      selectedFrequency: selectedFrequency ?? this.selectedFrequency,
    );
  }
}
