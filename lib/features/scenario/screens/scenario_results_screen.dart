import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:languageapp/features/padiman/screens/padiman_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScenarioResultsScreen extends StatelessWidget {
  final String scenarioTitle;
  final int accuracy;
  final int xpEarned;
  final List<String> newWords;

  const ScenarioResultsScreen({
    super.key,
    required this.scenarioTitle,
    this.accuracy = 100,
    this.xpEarned = 25,
    this.newWords = const ["Kɔfe", "Asikyire", "Nsuo", "Paanoo", "Sika"],
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: Column(
                  children: [
                    // Top Progress Banner (Cool Info)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFD54F),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.flash_on, size: 20, color: Colors.black),
                          const SizedBox(width: 8),
                          const Text(
                            "NEW STREAK RECORD!",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.black,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ).animate().scale(delay: 200.ms),
                    
                    const SizedBox(height: 32),
                    
                    // Celebration Icon/Asset
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                        ),
                        Container(
                          width: 120,
                          height: 120,
                          decoration: const BoxDecoration(
                            color: Color(0xFF6C91FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Icon(Icons.emoji_events, size: 64, color: Colors.white),
                          ),
                        ).animate()
                          .scale(duration: 600.ms, curve: Curves.elasticOut)
                          .shimmer(delay: 800.ms, duration: 2.seconds),
                      ],
                    ),
                    
                    const SizedBox(height: 32),
                    
                    // Main Title
                    Text(
                      accuracy >= 90 ? "Pure Mastery!" : "Great Session!",
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        height: 1.1,
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 8),
                    Text(
                      "You've completed $scenarioTitle",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w500,
                      ),
                    ).animate().fadeIn(delay: 500.ms),
                    
                    const SizedBox(height: 40),
                    
                    // Stats Grid
                    Row(
                      children: [
                        _buildStatCard(
                          label: "ACCURACY",
                          value: "$accuracy%",
                          icon: Icons.track_changes,
                          color: const Color(0xFF6366F1),
                        ),
                        const SizedBox(width: 16),
                        _buildStatCard(
                          label: "XP EARNED",
                          value: "+$xpEarned",
                          icon: Icons.bolt,
                          color: const Color(0xFFF59E0B),
                        ),
                      ],
                    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 40),
                    
                    // Streak Tracker Card
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(6, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "DAILY STREAK",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                "7 DAYS",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.orange.shade700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(7, (i) {
                              bool active = i < 4; // Mock progress
                              return Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: active ? Colors.black : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.black, width: 2),
                                ),
                                child: Icon(
                                  active ? Icons.check : null,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 900.ms),
                    
                    const SizedBox(height: 48),
                    
                    // Words Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          const Icon(Icons.menu_book, size: 18),
                          const SizedBox(width: 8),
                          Text(
                            "NEW VOCABULARY",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              color: Colors.black.withOpacity(0.4),
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    Center(
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        spacing: 12,
                        runSpacing: 12,
                        children: newWords.map((word) => _buildWordChip(word)).toList(),
                      ),
                    ).animate().fadeIn(delay: 1000.ms),
                    
                    const SizedBox(height: 56),
                    
                    // Suggestion Card (Improve Pronunciation)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const PadimanScreen()),
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: const Color(0xFFD7DFFF),
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black, width: 2),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(4, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.black, width: 2),
                              ),
                              child: const Icon(Icons.record_voice_over, color: Color(0xFF6C91FF), size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Speak like a native?",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text(
                                    "Practice these words with Padiman AI voice chat.",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                      color: Colors.black.withOpacity(0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ).animate().fadeIn(delay: 1200.ms),
                    
                    const SizedBox(height: 48),
                    
                    // Suggestion 2: Next Lesson
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "NEXT RECOMMENDED",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: Colors.black.withOpacity(0.4),
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8D9D0),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.black, width: 2),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.arrow_forward_ios, size: 16),
                          const SizedBox(width: 12),
                          const Text(
                            "Ordering Food at the Market",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                          const Spacer(),
                          const Icon(Icons.play_circle_fill, size: 40, color: Colors.black),
                        ],
                      ),
                    ).animate().fadeIn(delay: 1300.ms),
                    
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            
            // Fixed Bottom Button - Styled to stick to bottom
            Container(
              width: double.infinity,
              height: 100,
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text(
                  "CONTINUE",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ).animate().fadeIn(delay: 1500.ms).slideY(begin: 0.5, end: 0),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              offset: Offset(4, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 16),
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Colors.black,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.black.withOpacity(0.4),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWordChip(String word) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.black, width: 1.5),
      ),
      child: Text(
        word,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}
