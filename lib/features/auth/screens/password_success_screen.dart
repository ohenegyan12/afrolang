import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:languageapp/features/auth/screens/login_screen.dart';

class PasswordSuccessScreen extends StatelessWidget {
  const PasswordSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Spacer(),
            
            // Bubble + Mascot
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Speech Bubble
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 48),
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFE5E5E5)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Text(
                            "You changed your password, go to login",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                        // Triangle Pointing Down
                        Positioned(
                          bottom: -6,
                          child: Transform.rotate(
                            angle: 0.785398, // 45 degrees
                            child: Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: const Border(
                                  bottom: BorderSide(color: Color(0xFFE5E5E5)),
                                  right: BorderSide(color: Color(0xFFE5E5E5)),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Cover top of triangle
                        Positioned(
                          bottom: 0,
                          child: Container(
                            width: 20, 
                            height: 2, 
                            color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().moveY(begin: -10, end: 0),

                  const SizedBox(height: 24),

                  // Mascot
                  SvgPicture.asset(
                    "assets/onboarding-2.svg", // Reusing the mascot asset
                    height: 140,
                  ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                ],
              ),
            ),

            const Spacer(),

            // Button
            Padding(
              padding: const EdgeInsets.all(24),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (route) => false,
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF59C8FF),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF45A6D9),
                        offset: const Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Go To Login",
                    style: GoogleFonts.familjenGrotesk(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
