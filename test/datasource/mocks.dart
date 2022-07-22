import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:routine_checks_mobile/services/local_database/local_database.dart';

class MockHiveBox extends Mock implements Box {}

class MockHiveStorage extends Mock implements HiveStorage {}