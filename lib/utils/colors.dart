import 'package:flutter/material.dart';

class AppColors {
  static const Color grey = Color(0xFFF5F5F5);
  static const Color deepGrey = Color(0xFFE5E5E5);
  static const Color deepGreen = Color(0xFF00BFA5);
  static const Color yellow = Color(0xFFfdc593);
  static const Color red = Color(0xFFF44336);

  static const int purplePrimary = 0xFF8085ff;
  static const MaterialColor purple = MaterialColor(purplePrimary, <int, Color>{
    50: Color(0xFFe8eaf6),
    100: Color(0xFFc5cae9),
    200: Color(0xFF9fa8da),
    300: Color(0xFF7986cb),
    400: Color(0xFF5c6bc0),
    500: Color(0xFF3f51b5),
    600: Color(0xFF3949ab),
    700: Color(0xFF303f9f),
    800: Color(0xFF283593),
    900: Color(0xFF1a237e),
  });

  static LinearGradient completedGradient = const LinearGradient(
    colors: [
      AppColors.purple,
      AppColors.deepGreen,
      AppColors.purple,
      Colors.amber,
    ],
  );
  static LinearGradient missedGradient = const LinearGradient(
    colors: [
      AppColors.red,
      Colors.brown,
      Colors.amber,
    ],
  );
  static LinearGradient pendingGradient = const LinearGradient(
    colors: [
      Colors.black,
      Colors.black,
    ],
  );
}
