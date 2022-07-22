import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:routine_checks_mobile/domain/routine_model.dart';
import 'package:routine_checks_mobile/features/home/widgets/nav_bar.dart';
import 'package:routine_checks_mobile/utils/colors.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'services/local_database/hive_keys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await Hive.initFlutter();
  Hive.registerAdapter(RoutineAdapter());
  Hive.registerAdapter(StatusAdapter());
  await Hive.openBox(HiveKeys.appBox);

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: AppColors.purple,
      ),
      home: const NavBar(),
    );
  }
}
