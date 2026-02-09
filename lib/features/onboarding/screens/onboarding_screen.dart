import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:languageapp/features/auth/screens/signup_screen.dart';

import 'package:flag/flag.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentStep = 1;
  String selectedLanguage = "TWI";
  int? selectedOptionIndex;
  int? selectedFluencyIndex;

  void _nextStep() {
    if (selectedOptionIndex != null || currentStep == 3) {
      setState(() {
        if (currentStep == 2) {
          selectedFluencyIndex = selectedOptionIndex;
        }
        currentStep++;
        selectedOptionIndex = null; // Reset for next screen
      });
    }
  }

  void _previousStep() {
    setState(() {
      currentStep--;
      selectedOptionIndex = null;
    });
  }

  Widget _buildCurrentStep() {
    switch (currentStep) {
      case 1:
        return _buildStep1();
      case 2:
        return _buildStep2();
      case 3:
        return _buildStep3();
      case 4:
        return _buildStep4();
      case 5:
        return _buildStep5();
      case 6:
        return _buildStep6();
      case 7:
        return _buildStep7();
      default:
        return _buildStep1();
    }
  }

  Widget _buildContinueButton() {
    // In step 3, button is always enabled because choice was made in step 2
    // For steps 1, 2, 4, 5, and 6, the button is hidden due to auto-transition
    bool isEnabled = currentStep == 3 || selectedOptionIndex != null;
    String label = currentStep == 3 ? "Get Started" : "Continue";

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: isEnabled ? _nextStep : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled ? const Color(0xFF007A7A) : const Color(0xFFE0E0E0),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (currentStep == 3) ...[
                const SizedBox(width: 8),
                const Icon(Icons.chevron_right, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Hide header in step 7 (according to design usually final screens are cleaner, 
                  // but your screenshot shows 'back' button. We'll keep it but maybe hide progress 7/7 if unrelated)
                  // Actually the screenshot shows no 7/7 but shows back button.
                  _buildHeader(), 
                  const SizedBox(height: 40),
                ],
              ),
            ),
            
            // Step Content
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _buildCurrentStep(),
              ),
            ),

            // Only show button if not in auto-transition steps (1, 2, 4, 5, 6)
            // And Step 7 has its own buttons, so hide the main continue button
            if (currentStep == 3) _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (currentStep > 1)
          GestureDetector(
            onTap: _previousStep,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(Icons.chevron_left, size: 20, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    "back",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      color: Color(0xFF757575),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          )
        else
          SvgPicture.asset(
            'assets/images/afrolingo-logo.svg',
            height: 28,
          ),
        if (currentStep != 7) // Hide progress counter on the last step as per usual design patterns or screenshot analysis
          Text(
            '$currentStep/7',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
      ],
    );
  }

  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(1),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.w500,
                color: Colors.black,
                height: 1.2,
              ),
              children: [
                TextSpan(text: "Which "),
                TextSpan(
                  text: "Ghanaian",
                  style: TextStyle(
                    color: Color(0xFF007A7A),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(text: " language\nwould you like to learn?"),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildLanguageItem(0, "TWI (ASANTI)", isComingSoon: false),
                _buildLanguageItem(1, "GA", isComingSoon: false),
                _buildDivider("Coming Soon"),
                ...["EWE", "FANTI", "DAGOMBA", "FRAFRA", "BONO"]
                    .asMap()
                    .entries
                    .map((entry) => _buildLanguageItem(entry.key + 2, entry.value, isComingSoon: true))
                    .toList(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(2),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Now let’s find your level of\nfluency in $selectedLanguage.",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildFluencyItem(
                  0,
                  "From Scratch",
                  "A1 Course",
                  "I only know a few words in $selectedLanguage and am essentially starting from scratch.",
                ),
                _buildFluencyItem(
                  1,
                  "Beginner",
                  "A2 Course",
                  "I can speak a little $selectedLanguage and know some of the basics, but am still a beginner.",
                ),
                _buildFluencyItem(
                  2,
                  "Intermediate",
                  "B1 course",
                  "I can order for food or read a menu in $selectedLanguage, but am still improving",
                ),
                _buildFluencyItem(
                  3,
                  "Advanced",
                  "B2 course",
                  "I'm feeling more comfortable speaking $selectedLanguage in public, but still need practice",
                ),
                _buildFluencyItem(
                  4,
                  "Nearly Fluent",
                  "C1 course",
                  "I can watch an $selectedLanguage TV show without needing subtitles",
                ),
                const SizedBox(height: 32),
                const Center(
                  child: Text(
                    "You can always switch to another level later, so\nno stress.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF757575),
                      fontSize: 13,
                      height: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep3() {
    String title = "";
    String description = "";

    switch (selectedFluencyIndex) {
      case 0:
        title = "Starting from scratch?";
        description = "We’ll be adding more support for people like you who are just getting started soon.\n\nIn the meantime, you’re welcome to try us out, but should know that you may be swimming in the deep end.";
        break;
      case 1:
        title = "Brushing up the basics?";
        description = "AfroLingo is designed to help you master the fundamentals. You'll progress quickly through the basics and build a strong foundation for more complex conversations.";
        break;
      case 2:
        title = "Strengthening your skills?";
        description = "You've got a good start! Our lessons will push you to expand your vocabulary and understand the nuances of the language, helping you sound more natural.";
        break;
      case 3:
        title = "Perfecting your flow?";
        description = "We'll challenge you with more complex sentence structures and cultural context to help you bridge the gap between intermediate and advanced fluency.";
        break;
      case 4:
        title = "Maintaining your mastery?";
        description = "Even experts benefit from practice. Our advanced modules provide the perfect environment to refine your accent and catch those last few tricky idioms.";
        break;
      default:
        title = "Starting from scratch?";
        description = "We’ll be adding more support for people like you who are just getting started soon.\n\nIn the meantime, you’re welcome to try us out, but should know that you may be swimming in the deep end.";
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(3),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 28,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                height: 1.2,
              ),
              children: [
                const TextSpan(
                  text: "Afrolingo ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const TextSpan(text: "is best for people\nwho want know the basics of\n"),
                TextSpan(
                  text: selectedLanguage,
                  style: const TextStyle(fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: const Color(0xFF007A7A),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStep4() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(4),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Why are you excited about\nlearning $selectedLanguage?",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSimpleOptionItem(0, "Living in Ghana"),
                _buildSimpleOptionItem(1, "To speak with friends"),
                _buildSimpleOptionItem(2, "For my work"),
                _buildSimpleOptionItem(3, "Visiting Ghana"),
                _buildSimpleOptionItem(4, "Just for fun"),
                const SizedBox(height: 48),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "This helps us personalize the learning to better fit\nyour goals",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStep5() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(5),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "What’s your age?",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSimpleOptionItem(0, "Under 25"),
                _buildSimpleOptionItem(1, "25-40"),
                _buildSimpleOptionItem(2, "40-60"),
                _buildSimpleOptionItem(3, "over 60"),
                const SizedBox(height: 48),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "This help us suggest better topics and scenarios\nfor you to practice.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildStep6() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(6),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Last thing, how did you hear\nabout Afrolingo?",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                _buildSimpleOptionItem(0, "Friends / Family"),
                _buildSimpleOptionItem(1, "Facebook"),
                _buildSimpleOptionItem(2, "TikTok"),
                _buildSimpleOptionItem(3, "News / Press"),
                _buildSimpleOptionItem(4, "Youtube"),
                _buildSimpleOptionItem(5, "Google Search"),
                const SizedBox(height: 48),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      "This helps us improve how we spread the word\nand reach more people.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Colors.grey[600],
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }



  Widget _buildSimpleOptionItem(int index, String title) {
    bool isSelected = selectedOptionIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(24), // Highly rounded like design
        border: Border.all(
          color: isSelected ? Colors.white : const Color(0xFFF0F0F0),
          width: 1.2,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : Colors.black87,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isSelected ? Colors.white : Colors.black87,
          size: 24,
        ),
        onTap: () async {
          setState(() {
            selectedOptionIndex = index;
          });
          // Auto-transition after selection delay
          await Future.delayed(const Duration(milliseconds: 800));
          if (mounted) _nextStep();
        },
      ),
    );
  }
  Widget _buildStep7() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        key: const ValueKey(7),
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Independence Arch Image
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              image: const DecorationImage(
                image: AssetImage('assets/images/step-7-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Text(
            "Great! You are about to start a\ngreat journey in learning $selectedLanguage.",
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.black,
              height: 1.3,
            ),
          ),
          const Spacer(),
          // Sign Up Buttons
          _buildSocialButton(
            label: "Sign up with Google",
            iconPath: "assets/icons/google.png",
            isOutlined: true,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSocialButton(
            label: "Sign up with Apple",
            icon: Icons.apple,
            isDark: true,
            onTap: () {},
          ),
          const SizedBox(height: 16),
          _buildSocialButton(
            label: "Sign up with Email",
            icon: Icons.email_outlined,
            isPrimary: true,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildSocialButton({
    required String label,
    IconData? icon,
    String? iconPath,
    bool isOutlined = false,
    bool isDark = false,
    bool isPrimary = false,
    required VoidCallback onTap,
  }) {
    Color bgColor = Colors.white;
    Color textColor = Colors.black;
    Color borderColor = const Color(0xFFE0E0E0);

    if (isDark) {
      bgColor = Colors.black;
      textColor = Colors.white;
      borderColor = Colors.black;
    } else if (isPrimary) {
      bgColor = const Color(0xFF007A7A);
      textColor = Colors.white;
      borderColor = const Color(0xFF007A7A);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: borderColor,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null)
              Icon(icon, color: textColor, size: 24)
            else if (iconPath != null)
              if (iconPath.endsWith('.svg'))
                SvgPicture.asset(iconPath, width: 24, height: 24)
              else
                Image.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildLanguageItem(int index, String title, {required bool isComingSoon}) {
    bool isSelected = selectedOptionIndex == index;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? Colors.white : const Color(0xFFEEEEEE),
          width: 1.5,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Flag.fromCode(
          FlagsCode.GH,
          height: 18,
          width: 24,
          fit: BoxFit.fill,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isComingSoon 
                ? const Color(0xFFBDBDBD)
                : (isSelected ? Colors.white : Colors.black54),
            letterSpacing: 0.5,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: isComingSoon 
              ? const Color(0xFFE0E0E0)
              : (isSelected ? Colors.white : Colors.black45),
          size: 24,
        ),
        onTap: isComingSoon
            ? null
            : () async {
                setState(() {
                  selectedOptionIndex = index;
                  if (currentStep == 1) {
                    selectedLanguage = title.split(' ')[0];
                  }
                });
                await Future.delayed(const Duration(milliseconds: 800));
                if (mounted) _nextStep();
              },
      ),
    );
  }

  Widget _buildFluencyItem(int index, String title, String course, String description) {
    bool isSelected = selectedOptionIndex == index;
    return GestureDetector(
      onTap: () async {
        setState(() {
          selectedOptionIndex = index;
        });
        await Future.delayed(const Duration(milliseconds: 800));
        if (mounted) _nextStep();
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1A1A1A) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? Colors.white : const Color(0xFFF0F0F0),
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      course,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white.withOpacity(0.6) : const Color(0xFFB0B0B0),
                      ),
                    ),
                  ],
                ),
                Icon(
                  Icons.chevron_right,
                  color: isSelected ? Colors.white : Colors.grey,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white.withOpacity(0.1) : const Color(0xFFF9F9F9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                description,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: isSelected ? Colors.white : Colors.black54,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              label,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const Expanded(child: Divider(color: Color(0xFFEEEEEE))),
        ],
      ),
    );
  }
}
