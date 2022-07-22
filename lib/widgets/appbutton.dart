import 'package:flutter/material.dart';
import 'package:routine_checks_mobile/utils/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key, this.text, this.onTap}) : super(key: key);
  final String? text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.purple,
        ),
        child: Text(
          text ?? 'Add Routine',
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
