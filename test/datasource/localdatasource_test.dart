import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routine_checks_mobile/data/localdatasource/routines_data_source.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/services/local_database/hive_keys.dart';
import 'package:routine_checks_mobile/services/local_database/local_database.dart';

import 'mocks.dart';

void main() {
  late RoutinesLocalDataSource mockRoutineLocalDataSource;
  late HiveStorage storage;
  setUp(() {
    storage = MockHiveStorage();
    mockRoutineLocalDataSource = RoutinesLocalDataSource(storage);
  });
  group("Routine Repository test", () {
    Routine routine = Routine(
      title: "Test",
      description: "Test",
      frequency: DateTime(2022, 05, 05),
      isCompleted: false,
      status: Status.pending,
    );
    test(
        "When called, expect that the get routines function doesn't an return empty list",
        () {
      when(() => storage.put(HiveKeys.routines, routine))
          .thenAnswer((invocation) {
        return Future.value();
      });
      when(() => storage.get(
            HiveKeys.routines,
          )).thenReturn([routine]);
      expect(mockRoutineLocalDataSource.getRoutines(), isA<List<Routine>>());
    });

    test(
        "When get routines is called, a list of routines should be returned \n and the status of the first routine should be pending",
        () async {
      when(() => mockRoutineLocalDataSource.getRoutines())
          .thenAnswer((invocation) {
        return [
          Routine(
            title: "Test Routine",
            description: "I am testing",
            isCompleted: false,
            status: Status.pending,
            frequency: DateTime.now(),
          ),
        ];
      });

      expect(mockRoutineLocalDataSource.getRoutines().length, 1);
      expect(mockRoutineLocalDataSource.getRoutines().first.status,
          Status.pending);
    });
    test(" When edit routines is called, the value edited should be changed",
        () async {
      Routine rtine = Routine(
        title: "Test",
        description: "Test",
        frequency: DateTime(2022, 05, 05),
        isCompleted: false,
        status: Status.pending,
      );
      when(() => storage.get(
            HiveKeys.routines,
          )).thenReturn([rtine]);

      Routine newroutine = rtine.copyWith(
        status: Status.completed,
        title: "New Title",
      );

      when(() => storage.put(HiveKeys.routines, [newroutine]))
          .thenAnswer((inv) => Future.value());
      await mockRoutineLocalDataSource.editRoutine(newroutine);
      when(() => storage.get(
            HiveKeys.routines,
          )).thenReturn([newroutine]);
      expect(
        mockRoutineLocalDataSource.getRoutines().first.status,
        Status.completed,
      );
    });
  });
}
