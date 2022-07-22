import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/services/local_database/hive_keys.dart';
import 'package:routine_checks_mobile/services/local_database/local_database.dart';

class RoutinesLocalDataSource {
  HiveStorage storage;

  RoutinesLocalDataSource(this.storage);
  List<Routine> getRoutines() {
    List routines = storage.get(HiveKeys.routines) ?? <Routine>[];
    List<Routine> routineList = List<Routine>.from(routines);
    return routineList;
  }

  Future<void> addRoutine(Routine routine) async {
    List routines = await storage.get(HiveKeys.routines) ?? [];
    List<Routine> routineList = List<Routine>.from(routines);
    routineList.add(routine);
    await storage.put(HiveKeys.routines, routineList);
  }

  Future<void> editRoutine(Routine routine) async {
    List routines = await storage.get(HiveKeys.routines) ?? [];
    List<Routine> routineList = List<Routine>.from(routines);
    int index = routineList.indexWhere((r) => r.frequency == routine.frequency);
    routineList[index] = routine;
    await storage.put(HiveKeys.routines, routineList);
  }
}
