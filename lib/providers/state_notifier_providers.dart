import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routine_checks_mobile/features/add_routine/notifier/add_routine_notifier.dart';

final addRoutineViewmdodelProvider =
    StateNotifierProvider<AddRoutineNotifier, AddRoutineState>(
        (ref) => AddRoutineNotifier(ref));
