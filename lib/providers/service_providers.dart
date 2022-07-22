

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine_checks_mobile/data/localdatasource/routines_data_source.dart';
import 'package:routine_checks_mobile/repository/routine_repository.dart';
import 'package:routine_checks_mobile/services/local_database/hive_keys.dart';
import 'package:routine_checks_mobile/services/local_database/local_database.dart';
import 'package:routine_checks_mobile/services/notifications/local_notifications.dart';


final localdbProvider = Provider((_) => HiveStorage(Hive.box(HiveKeys.appBox)));
final notificationProvider = Provider((_) => NotificationHelper());
final routineRepositoryProvivder = Provider((_) => RoutineRepository(RoutinesLocalDataSource(_.read(localdbProvider))));
