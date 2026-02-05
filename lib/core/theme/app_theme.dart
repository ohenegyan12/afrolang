import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Vibrant Color Palette
  static const Color primaryColor = Color(0xFF6C63FF); // Modern Purple
  static const Color secondaryColor = Color(0xFFFF6584); // Vibrant Pink
  static const Color accentColor = Color(0xFF32D74B); // Fresh Green
  static const Color backgroundColor = Color(0xFF1E1E2C); // Dark Background
  static const Color cardColor = Color(0xFF2D2D44); // Card Background for Dark Mode

  static final ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: backgroundColor,
    primaryColor: primaryColor,
    colorScheme: const ColorScheme.dark(
      primary: primaryColor,
      secondary: secondaryColor,
      surface: cardColor,
      background: backgroundColor,
    ),
    // Set default font family
    textTheme: GoogleFonts.familjenGroteskTextTheme(ThemeData.dark().textTheme),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
    ),
  );
  
  static final ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
      brightness: Brightness.light,
    ),
     textTheme: GoogleFonts.familjenGroteskTextTheme(ThemeData.light().textTheme),
  );
}
