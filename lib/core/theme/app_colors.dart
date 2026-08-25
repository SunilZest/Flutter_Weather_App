import 'package:flutter/material.dart';

/// Centralized color palette for the app.
///
/// Primary brand colors: Pink, Black, Red, Sky Blue.
/// Used deliberately and sparingly to keep the UI professional.
class AppColors {
  AppColors._();

  // Brand palette
  static const Color skyBlue = Color(0xFF4FA8E0);
  static const Color skyBlueDark = Color(0xFF2E6DA4);
  static const Color pink = Color(0xFFEA5C8F);
  static const Color pinkLight = Color(0xFFFF8FB1);
  static const Color red = Color(0xFFE5484D);
  static const Color black = Color.fromARGB(255, 21, 24, 28);

  // Light theme surface colors
  static const Color lightBackground = Color(0xFFF4F8FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1B1E24);
  static const Color lightTextSecondary = Color(0xFF6B7280);

  // Dark theme surface colors
  static const Color darkBackground = Color(0xFF0E1013);
  static const Color darkSurface = Color(0xFF1B1E24);
  static const Color darkTextPrimary = Color(0xFFF4F6F8);
  static const Color darkTextSecondary = Color(0xFF9AA1AC);

  // Gradients
  static const LinearGradient skyGradientLight = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [skyBlue, Color(0xFF8FD0F2)],
  );

  static const LinearGradient skyGradientDark = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF16324F), black],
  );

  static const LinearGradient pinkButtonGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [pink, pinkLight],
  );

  static const Color success = Color(0xFF34C759);
  static const Color warning = Color(0xFFF5A623);
}
