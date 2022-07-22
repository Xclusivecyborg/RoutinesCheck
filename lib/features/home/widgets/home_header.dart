import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/features/add_routine/notifier/add_routine_notifier.dart';
import 'package:routine_checks_mobile/utils/colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key? key,
    required this.state,
  }) : super(key: key);

  final AddRoutineState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        alignment: Alignment.center,
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.deepGrey,
        ),
        child: const Text(
          "👑",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      title: const Text(
        'Hello, Good day.',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        'You have ${state.routines.length} routines today',
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
    );
  }
}
