import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/utils/colors.dart';

class Empty extends StatelessWidget {
  const Empty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          children: const [
            Icon(
              Icons.sentiment_dissatisfied,
              size: 100,
              color: AppColors.purple,
            ),
            Text(
              'There are no routines at this time.\n Add a new one by clicking on the + button.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
