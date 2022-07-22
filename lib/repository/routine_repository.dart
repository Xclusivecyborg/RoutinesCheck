import 'package:routine_checks_mobile/data/localdatasource/routines_data_source.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';

class RoutineRepository {
  RoutineRepository(this.datasource);

  final RoutinesLocalDataSource datasource;

  List<Routine> getRoutines()  {
    return datasource.getRoutines();
  }

  Future<void> addRoutine(Routine routine) async {
    return datasource.addRoutine(routine);
  }

  Future<void> editRoutine(Routine routine) async {
    return datasource.editRoutine(routine);
  }

}


