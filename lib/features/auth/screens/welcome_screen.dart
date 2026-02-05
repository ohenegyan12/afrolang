import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageapp/features/auth/screens/login_screen.dart';
import 'package:languageapp/features/auth/screens/signup_screen.dart';
import 'package:languageapp/features/onboarding/screens/onboarding_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Spacer(),
              
              // Mascot Image
              Center(
                child: SizedBox(
                   width: 200,
                   height: 200,
                   child: SvgPicture.asset(
                    'assets/mascot.svg',
                    fit: BoxFit.contain,
                   ),
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 32),
      
              Text(
                "fluento",
                textAlign: TextAlign.center,
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2CB2FF), // Brand Blue
                  letterSpacing: -1.0,
                ),
              ).animate().fadeIn(delay: 200.ms).moveY(begin: 10, end: 0),
      
              const SizedBox(height: 12),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Learn languages the fun way — with Blinky by your side!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.familjenGrotesk(
                    fontSize: 20,
                    color: Colors.black54,
                    height: 1.4,
                  ),
                ).animate().fadeIn(delay: 300.ms),
              ),
      
              const Spacer(),
      
              // "Get Started" Button (Primary 3D Effect)
              _3DButton(
                text: "Get Started",
                textColor: Colors.white,
                backgroundColor: const Color(0xFF2CB2FF),
                borderColor: const Color(0xFF2CB2FF), // Same as bg or slightly lighter
                shadowColor: const Color(0xFF1E9AD8), // Darker blue shadow
                onTap: () {
                   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()),
                  );
                },
              ).animate().fadeIn(delay: 500.ms).moveY(begin: 20, end: 0),
      
              const SizedBox(height: 16),
      
              // "I've a profile" Button (Secondary 3D Effect)
              _3DButton(
                text: "I've a profile",
                textColor: const Color(0xFF2CB2FF),
                backgroundColor: Colors.white,
                borderColor: const Color(0xFFE5E5E5), // Light stroke
                shadowColor: const Color(0xFFE5E5E5), // Light shadow to match stroke depth
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),
      
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _3DButton extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color shadowColor;
  final VoidCallback onTap;

  const _3DButton({
    required this.text,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.shadowColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 2), // The "Stroke"
          boxShadow: [
            BoxShadow(
              color: shadowColor,
              offset: const Offset(0, 4), // The "Dropdown Shadow" (Vertical offset)
              blurRadius: 0, // Solid shadow (no blur)
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.familjenGrotesk(
            color: textColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
