import 'package:flutter/material.dart';
import 'package:languageapp/core/theme/app_theme.dart';
import 'package:languageapp/features/auth/screens/splash_screen.dart';
import 'package:languageapp/features/home/home_screen.dart';
// import 'package:provider/provider.dart'; // Will use later for state management

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ghanaian Language Learner',
      debugShowCheckedModeBanner: false,
      
      // Theme Configuration
      themeMode: ThemeMode.system, // Respects user's system setting (Dark/Light)
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      
      // Home Route
      home: const SplashScreen(),
    );
  }
}
