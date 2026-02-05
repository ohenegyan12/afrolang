import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:languageapp/features/auth/screens/signup_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flag/flag.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int _currentStep = 0;
  
  // State variables for selections
  String? _nativeLanguage;
  String? _learningLanguage;
  String? _hearAboutUs; // New state variable
  String? _proficiencyLevel;
  String? _learningReason; // New state variable
  
  // Updated Daily Goal State
  int _selectedDuration = 15; // Default 15 mins
  String _selectedPeriod = "Morning"; // Default Morning

  final int _totalSteps = 10; // Intro 1, Intro 2, Q1, Q2, Q3, Q4, Q5 (Reason), Q6, Loading, SignUp

  void _nextStep() {
    setState(() {
      _currentStep++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                  child: _buildStepContent(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0: return _buildIntro1();
      case 1: return _buildIntro2();
      case 2: return _buildNativeLanguageStep();
      case 3: return _buildLearningLanguageStep();
      case 4: return _buildHearAboutStep(); 
      case 5: return _buildProficiencyStep();
      case 6: return _buildReasonStep(); // New Step
      case 7: return _buildDailyGoalStep();
      case 8: return _buildLoadingStep();
      case 9: return _buildFinalAuthStep();
      default: return Container();
    }
  }

  // --- Step 0: Welcome Mascot ---
  // --- Step 0: Welcome Mascot ---
  Widget _buildIntro1() {
    return Container(
      key: const ValueKey(0),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Speech Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "Hello, I’m Blinky! Let’s\ncustomize your profile",
              textAlign: TextAlign.center,
              style: GoogleFonts.familjenGrotesk(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
                height: 1.3,
              ),
            ),
          ).animate().fadeIn().moveY(begin: 10, end: 0),
          
          // Speech bubble tail
          CustomPaint(
            painter: TrianglePainter(color: Colors.white),
            size: const Size(20, 10),
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: 24),

          // Mascot
          SvgPicture.asset(
            "assets/onboarding-1.svg",
            height: 250,
          ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),

          const Spacer(),

          _buildPrimaryButton(
            text: "Let’s go",
            onPressed: _nextStep,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // --- Step 1: Mascot Request ---
  Widget _buildIntro2() {
    return Container(
      key: const ValueKey(1),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          // Speech Bubble
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  height: 1.3,
                ),
                children: [
                  const TextSpan(text: "Answer to "),
                  TextSpan(
                    text: "7 questions",
                    style: GoogleFonts.familjenGrotesk(
                      color: const Color(0xFF2CB2FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const TextSpan(text: "\nbefore start"),
                ],
              ),
            ),
          ).animate().fadeIn().moveY(begin: 10, end: 0),
          
          // Speech bubble tail
          CustomPaint(
            painter: TrianglePainter(color: Colors.white),
            size: const Size(20, 10),
          ).animate().fadeIn(delay: 100.ms),

          const SizedBox(height: 24),

          // Mascot
          SvgPicture.asset(
            "assets/onboarding-2.svg",
            height: 250,
          ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),

          const Spacer(),

          _buildPrimaryButton(
            text: "Continue",
            onPressed: _nextStep,
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  // --- Step 2: Native Language ---
  Widget _buildNativeLanguageStep() {
    final languages = [
      {'name': 'American English', 'countryCode': 'US'},
      {'name': 'German', 'countryCode': 'DE'},
      {'name': 'Chinese', 'countryCode': 'CN'},
      {'name': 'Korean', 'countryCode': 'KR'},
      {'name': 'French', 'countryCode': 'FR'},
      {'name': 'Arabic', 'countryCode': 'SA'},
      {'name': 'Portugal', 'countryCode': 'PT'},
      {'name': 'Italian', 'countryCode': 'IT'},
      {'name': 'Russian', 'countryCode': 'RU'},
      {'name': 'Japanese', 'countryCode': 'JP'},
      {'name': 'Hindi', 'countryCode': 'IN'},
    ];
    return _buildQuestionStep(
      stepIndex: 2,
      question: "Which language do you speak fluently?",
      options: languages,
      selectedValue: _nativeLanguage,
      onSelect: (val) => setState(() => _nativeLanguage = val),
    );
  }

  // --- Step 3: Target Language ---
  Widget _buildLearningLanguageStep() {
    final languages = [
      {'name': 'Twi (Ghana)', 'countryCode': 'GH'},
      {'name': 'Ga (Ghana)', 'countryCode': 'GH'},
    ];
    return _buildQuestionStep(
      stepIndex: 3,
      question: "Which language would you like to learn?",
      options: languages,
      selectedValue: _learningLanguage,
      onSelect: (val) => setState(() => _learningLanguage = val),
    );
  }

  // --- Step 4: Hear About Us (3/7) ---
  Widget _buildHearAboutStep() {
    final options = [
      {'name': 'YouTube'},
      {'name': 'Google Search'},
      {'name': 'Twitter'},
      {'name': 'Instagram'},
      {'name': 'Website'},
      {'name': 'Article / Blog'},
      {'name': 'Friends'},
    ];
    return _buildQuestionStep(
      stepIndex: 4,
      question: "How did you hear about us?",
      options: options,
      selectedValue: _hearAboutUs,
      onSelect: (val) => setState(() => _hearAboutUs = val),
    );
  }

  // --- Step 5: Proficiency (4/7) ---
  Widget _buildProficiencyStep() {
    final language = _learningLanguage?.split(' ').first ?? "target language"; 
    
    final levels = [
      {'name': 'Not at all', 'icon': '😐'},
      {'name': 'A little', 'icon': '😛'},
      {'name': 'Very well', 'icon': '❤️'},
      {'name': 'Like a native', 'icon': '👑'},
    ];

    return _buildGridStep(
      stepIndex: 5,
      question: "How well do you speak $language?",
      options: levels,
      selectedValue: _proficiencyLevel,
      onSelect: (val) => setState(() => _proficiencyLevel = val),
    );
  }



  // --- Step 6: Reason for Learning (5/7) ---
  Widget _buildReasonStep() {
    final language = _learningLanguage?.split(' ').first ?? "target language";

    final reasons = [
      {'name': 'For work', 'icon': '🖥️'},
      {'name': 'For studying', 'icon': '📗'},
      {'name': 'For travel', 'icon': '🚗'},
      {'name': 'Hobby', 'icon': '💬'},
      {'name': 'For fun', 'icon': '👍'},
      {'name': 'To make friends', 'icon': '😃'},
    ];

    return _buildGridStep(
      stepIndex: 6,
      question: "Why are you learning $language?",
      options: reasons,
      selectedValue: _learningReason,
      onSelect: (val) => setState(() => _learningReason = val),
    );
  }

  // --- Grid Step Builder (Reusable) ---
  Widget _buildGridStep({
    required int stepIndex,
    required String question,
    required List<Map<String, dynamic>> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return Column(
      key: ValueKey(stepIndex),
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                "${stepIndex - 1}/7",
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        
        // Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (stepIndex - 1) / 7.0,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF59C8FF)),
              minHeight: 8,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Mascot + Question Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Mascot
              SvgPicture.asset(
                "assets/onboarding-2.svg",
                height: 100,
              ),
              const SizedBox(width: 12),
              
              // Speech Bubble
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        question,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -10,
                      bottom: 20,
                      child: CustomPaint(
                        painter: TrianglePainter(color: Colors.white, isLeft: true, borderColor: const Color(0xFFE5E5E5)),
                        size: const Size(12, 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn().moveY(begin: 10, end: 0),

        const SizedBox(height: 24),

        // Grid Options
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.1, // Square-ish
            ),
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final label = option['name'];
              final icon = option['icon'];
              final isSelected = selectedValue == label;
              
              return GestureDetector(
                onTap: () => onSelect(label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFDFFFD6) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                        offset: const Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        icon,
                        style: const TextStyle(fontSize: 32),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        label,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF5BA83B) : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 24),

        // Continue Button
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildPrimaryButton(
            text: "Continue", 
            onPressed: selectedValue != null ? _nextStep : () {}, 
          ),
        ),
      ],
    );
  }

  // --- Step 7: Daily Goal (6/7) ---
  Widget _buildDailyGoalStep() {
    final options = [
      {'duration': 5, 'label': 'Habit', 'color': Colors.transparent},
      {'duration': 10, 'label': 'Focus', 'color': const Color(0xFFDFFFD6)}, 
      {'duration': 15, 'label': 'Routine', 'color': Colors.transparent},
      {'duration': 20, 'label': 'Discipline', 'color': Colors.transparent},
    ];

    return Column(
      key: const ValueKey(7),
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                "6/7", // Step 6 of 7
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: 6 / 7.0,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF59C8FF)),
              minHeight: 8,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Mascot + Question Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Mascot
              SvgPicture.asset(
                "assets/onboarding-2.svg",
                height: 100,
              ),
              const SizedBox(width: 12),
              
              // Speech Bubble
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        "How long do you want to learn daily?",
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -10,
                      bottom: 20,
                      child: CustomPaint(
                        painter: TrianglePainter(color: Colors.white, isLeft: true, borderColor: const Color(0xFFE5E5E5)),
                        size: const Size(12, 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn().moveY(begin: 10, end: 0),

        const SizedBox(height: 24),

        // Options List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: options.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final option = options[index];
              final duration = option['duration'] as int;
              final label = option['label'] as String;
              final isSelected = _selectedDuration == duration;
              
              return GestureDetector(
                onTap: () => setState(() => _selectedDuration = duration),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFDFFFD6) : Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                        offset: const Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        "$duration minutes",
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        label,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? const Color(0xFF5BA83B) : Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        // Continue Button
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildPrimaryButton(
            text: "Continue", 
            onPressed: () => _nextStep(), 
          ),
        ),
      ],
    );
  }


  // --- Step 6: Loading ---
  // --- Step 8: Loading/Customizing (7/7) ---
  Widget _buildLoadingStep() {
    return Column(
      key: const ValueKey(8),
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                "7/7",
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),

        // Progress Bar (Full)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: const LinearProgressIndicator(
              value: 1.0,
              backgroundColor: Color(0xFFF3F4F6),
              valueColor: AlwaysStoppedAnimation(Color(0xFF59C8FF)),
              minHeight: 8,
            ),
          ),
        ),

        // Main Content (Centered)
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Bubble (Top)
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
                        "Now we are customizing your profile, wait...",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    // Triangle Pointing Down (Approximation with rotated square)
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
                            boxShadow: [
                               BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 4,
                                offset: const Offset(2, 2),
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                     // Cover top of triangle to blend
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
              _buildMascot(size: 140)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05), duration: 1.seconds),
              
              const SizedBox(height: 32),

              Text(
                "LOADING...",
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 1.2,
                ),
              ).animate(onPlay: (c) => c.repeat())
               .fadeIn(duration: 800.ms)
               .then()
               .fadeOut(duration: 800.ms),
            ],
          ),
        ),

        // Finish Button
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildPrimaryButton(
            text: "Finish", 
            onPressed: () {
               // Proceed to Final Auth or Home
               _nextStep();
            }, 
          ),
        ),
      ],
    );
  }

  // --- Step 7: Final Sign Up ---
  Widget _buildFinalAuthStep() {
    return Container(
      key: const ValueKey(9),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          
          // Mascot
          _buildMascot(size: 160).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
          
          const SizedBox(height: 40),
          
          Text(
            "Save your journey",
            textAlign: TextAlign.center,
            style: GoogleFonts.familjenGrotesk(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ).animate().fadeIn(delay: 200.ms),
          
          const SizedBox(height: 16),
          
          Text(
            "Don’t lose your unlocked levels and claimed rewards by just Signing-Up in Mieo",
            textAlign: TextAlign.center,
            style: GoogleFonts.familjenGrotesk(
              fontSize: 16,
              color: Colors.black54,
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 400.ms),
          
          const SizedBox(height: 60),
          
          // Google Sign Up Button (3D White)
          GestureDetector(
            onTap: () {
                // Handle Google Sign Up
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE5E5E5), width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFFE5E5E5),
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/google.svg", width: 24),
                  const SizedBox(width: 12),
                  Text(
                    "Sign Up with Google",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ).animate().fadeIn(delay: 600.ms).moveY(begin: 10, end: 0),
          
          const SizedBox(height: 20),
          
          // Create Account Button (3D Blue)
          GestureDetector(
            onTap: () {
               Navigator.pushReplacement(
                context, 
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF2CB2FF),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xFF1E9AD8),
                    offset: Offset(0, 4),
                    blurRadius: 0,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                "Create Account",
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ).animate().fadeIn(delay: 800.ms).moveY(begin: 10, end: 0),
          
          const Spacer(),
        ],
      ),
    );
  }

  // --- Question Step Builder (Reusable) ---
  Widget _buildQuestionStep({
    required int stepIndex,
    required String question,
    required List<Map<String, dynamic>> options,
    required String? selectedValue,
    required Function(String) onSelect,
  }) {
    return Column(
      key: ValueKey(stepIndex),
      children: [
        // Top Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  if (_currentStep > 0) {
                    setState(() => _currentStep--);
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
              Text(
                "${stepIndex - 1}/7",
                style: GoogleFonts.familjenGrotesk(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ),
        
        // Progress Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: (stepIndex - 1) / 7.0,
              backgroundColor: const Color(0xFFF3F4F6),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF59C8FF)),
              minHeight: 8,
            ),
          ),
        ),

        const SizedBox(height: 24),

        // Mascot + Question Bubble
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              // Mascot
              SvgPicture.asset(
                "assets/onboarding-2.svg",
                height: 100,
              ),
              const SizedBox(width: 12),
              
              // Speech Bubble
              Expanded(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
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
                        question,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -10,
                      bottom: 20,
                      child: CustomPaint(
                        painter: TrianglePainter(color: Colors.white, isLeft: true, borderColor: const Color(0xFFE5E5E5)),
                        size: const Size(12, 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ).animate().fadeIn().moveY(begin: 10, end: 0),

        const SizedBox(height: 24),
        
        // Options List
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: options.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final option = options[index];
              final label = option['name'];
              final isSelected = selectedValue == label;
              
              return GestureDetector(
                onTap: () => onSelect(label),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12), // Reduced vertical padding slightly
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFFDFFFD6) : Colors.white, 
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                      width: 2,
                    ),
                    boxShadow: [
                      // 3D Shadow effect
                      BoxShadow(
                        color: isSelected ? const Color(0xFF88D870) : const Color(0xFFE5E5E5),
                        offset: const Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Flag/Icon
                      if (option.containsKey('countryCode') || option.containsKey('flag'))
                        Container(
                          width: 48, // Wider container
                          height: 38, // Taller container
                          margin: const EdgeInsets.only(right: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.grey.shade100,
                            // border: Border.all(color: Colors.black.withOpacity(0.05)),
                          ),
                           alignment: Alignment.center,
                           clipBehavior: Clip.antiAlias,
                           child: Flag.fromString(
                             option['countryCode'] ?? 'US',
                             height: 38,
                             width: 48,
                             fit: BoxFit.cover,
                             borderRadius: 8,
                           ),
                        ),
                      Text(
                        label,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF5BA83B) : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        const SizedBox(height: 24),
        // Continue Button
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildPrimaryButton(
            text: "Continue", 
            onPressed: selectedValue != null ? _nextStep : () {}, 
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionStep({
    required Key key,
    required String title,
    required List<String> options,
    required String? selectedOption,
    required Function(String) onSelect,
    required VoidCallback onNext,
    bool useListView = false,
  }) {
    return Column(
      key: key,
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.familjenGrotesk(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: options.length,
            separatorBuilder: (c, i) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = selectedOption == option;
              
              return GestureDetector(
                onTap: () => onSelect(option),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? const Color(0xFF59C8FF) : Colors.transparent,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(0, 2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        option,
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      // Radio Circle
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: isSelected ? const Color(0xFF59C8FF) : Colors.grey.shade300,
                            width: 2,
                          ),
                          color: isSelected ? const Color(0xFF59C8FF) : Colors.transparent,
                        ),
                        child: isSelected 
                            ? const Icon(Icons.check, size: 16, color: Colors.white)
                            : null,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        
        Padding(
          padding: const EdgeInsets.all(24),
          child: _buildPrimaryButton(
            text: "Next", 
            onPressed: selectedOption != null ? onNext : () {}, // Disable loosely if null
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton({required String text, required VoidCallback onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: const Color(0xFF2CB2FF),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E9AD8), // Darker blue shadow
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: GoogleFonts.familjenGrotesk(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildMascot({double size = 150}) {
    // Placeholder Mieo Mascot
    return Center(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.white, // White background for the mascot
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            )
          ],
        ),
        child: ClipOval(
          child: Icon(Icons.pets, size: size * 0.6, color: const Color(0xFF59C8FF)),
        ), 
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isLeft;
  final Color? borderColor;

  TrianglePainter({required this.color, this.isLeft = false, this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    final borderPaint = Paint()
      ..color = borderColor ?? Colors.transparent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final path = Path();
    if (isLeft) {
      // Pointing left
      path
        ..moveTo(size.width, 0)
        ..lineTo(0, size.height / 2)
        ..lineTo(size.width, size.height)
        ..close();
    } else {
      // Pointing down (default)
      path
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0)
        ..close();
    }

    canvas.drawPath(path, paint);
    if (borderColor != null) {
        // Simple lines for border effect on triangle not perfect but works for bubble tail
       if (isLeft) {
          canvas.drawLine(Offset(size.width, 0), Offset(0, size.height/2), borderPaint);
          canvas.drawLine(Offset(0, size.height/2), Offset(size.width, size.height), borderPaint);
       }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
  // --- Grid Step Builder (For Proficiency 4/7) ---

