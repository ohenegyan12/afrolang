import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/features/auth/screens/welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // Simulate checking auth state or loading resources
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const WelcomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Brand Color from reference image (Solid bright blue)
    const brandColor = Color(0xFF2CB2FF);
    
    return Scaffold(
      backgroundColor: brandColor,
      body: Stack(
        children: [
          // Centered Text
          Center(
            child: Text(
              "fluento",
              style: GoogleFonts.familjenGrotesk(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: -0.5,
              ),
            ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1.0, 1.0)),
          ),
          
          // Loading Dots at bottom
          Positioned(
            bottom: 100,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildDot(0),
                const SizedBox(width: 8),
                _buildDot(100), // Delay
                const SizedBox(width: 8),
                _buildDot(200), // Delay
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int delay) {
    return Container(
      width: 8,
      height: 8,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
    )
    .animate(onPlay: (c) => c.repeat(reverse: true))
    .fade(duration: 600.ms, delay: delay.ms, begin: 0.3, end: 1.0)
    .scale(duration: 600.ms, delay: delay.ms, begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2));
  }
}
