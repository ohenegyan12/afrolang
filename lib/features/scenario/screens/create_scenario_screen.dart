import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CreateScenarioScreen extends StatefulWidget {
  const CreateScenarioScreen({super.key});

  @override
  State<CreateScenarioScreen> createState() => _CreateScenarioScreenState();
}

class _CreateScenarioScreenState extends State<CreateScenarioScreen> {
  int _currentStep = 1; // 1: Describe, 2: Create, 3: Practice
  final TextEditingController _describeController = TextEditingController();
  bool _isListening = false;
  bool _showInput = false;

  void _startCreation() {
    setState(() {
      _currentStep = 2;
      _showInput = false;
    });

    // Simulate creation process
    Future.delayed(3500.ms, () {
      if (mounted) {
        setState(() {
          _currentStep = 3;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9F4),
      body: Stack( // Wrap the entire Scaffold body in a Stack
        children: [
          // Content for steps 1 and 2
          Column(
            children: [
              Expanded(
                child: SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      // Header with Back Button
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPillBackButton(),
                            const SizedBox(height: 32),
                            _buildTextStepper(),
                          ],
                        ),
                      ),

                      Expanded(
                        child: AnimatedSwitcher(
                          duration: 400.ms,
                          child: _currentStep == 1
                            ? _buildDescribeStep()
                            : _currentStep == 2
                              ? _buildCreateStep()
                              : Container(), // Nothing here, Step 3 is full-screen
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Interaction Bottom Sheet - Only show in step 1
              if (_currentStep == 1) _buildActionArea(),
            ],
          ),

          // Full-screen Step 3 Overlay
          if (_currentStep == 3) _buildPracticeStep(),
        ],
      ),
    );
  }

  Widget _buildDescribeStep() {
    return Center(
      key: const ValueKey(1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Text(
          "Describe the scenario you want to practice",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.9),
            height: 1.2,
          ),
        ),
      ),
    ).animate().fadeIn();
  }

  Widget _buildCreateStep() {
    return Center(
      key: const ValueKey(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Premium creation animation
          Stack(
            alignment: Alignment.center,
            children: [
              ...List.generate(3, (i) =>
                Container(
                  width: 80 + (i * 30),
                  height: 80 + (i * 30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF6C91FF).withOpacity(0.1),
                      width: 2,
                    ),
                  ),
                ).animate(onPlay: (c) => c.repeat())
                 .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 2000.ms, curve: Curves.easeInOut)
                 .fadeOut(duration: 2000.ms)
              ),
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Color(0xFF6C91FF),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 30),
              ).animate(onPlay: (c) => c.repeat())
               .shimmer(duration: 2000.ms, color: Colors.white.withOpacity(0.4)),
            ],
          ),
          const SizedBox(height: 48),
          const Text(
            "Sit tight!",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
          const SizedBox(height: 12),
          Text(
            "We are creating your custom\nscenario for you...",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              color: Colors.black.withOpacity(0.5),
              height: 1.5,
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  Widget _buildPracticeStep() {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/images/ronaldstilting-fisherman-5704299_1280.jpg', // Placeholder for created scenario
              fit: BoxFit.cover,
            ),
          ),
          
          // Gradient Overlay
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.1),
                    Colors.transparent,
                    Colors.black.withOpacity(0.3),
                  ],
                ),
              ),
            ),
          ),

          // Back Button Overlay
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _buildPillBackButton(),
            ),
          ),

          // Floating Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF8F8F8),
                borderRadius: BorderRadius.circular(32),
                border: Border.all(color: Colors.black, width: 2),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(4, 4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Text(
                          "CUSTOM SCENARIO",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "5 min",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text(
                    _describeController.text.isNotEmpty 
                      ? _describeController.text 
                      : "Developing your custom practice session...",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 40),
                  
                  // Start Button
                  GestureDetector(
                    onTap: () {
                      // Navigate to actual practice screen
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE0E0FF), // Lavender
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(4, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "okay, let's start",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(width: 12),
                          Icon(Icons.arrow_forward, color: Colors.black),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPillBackButton() {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.black.withOpacity(0.1)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.arrow_back, size: 20, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'back',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextStepper() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepText("Describe", 1),
        _buildDottedLine(),
        _buildStepText("Create", 2),
        _buildDottedLine(),
        _buildStepText("Practice", 3),
      ],
    );
  }

  Widget _buildStepText(String text, int step) {
    bool isActive = _currentStep == step;
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 16,
        fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
        color: isActive ? Colors.black : Colors.black.withOpacity(0.3),
      ),
    );
  }

  Widget _buildDottedLine() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: List.generate(
            5,
            (index) => Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: 1,
                color: Colors.black.withOpacity(0.15),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionArea() {
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    
    return Container(
      padding: EdgeInsets.fromLTRB(20, 24, 20, bottomPadding > 0 ? bottomPadding : 32),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F0E6), // Darker cream for the sheet
        borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
        border: Border.all(color: Colors.black.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "describe the scenario",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              // Type Button
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _showInput = !_showInput);
                  },
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.1)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.keyboard_outlined, color: Colors.black87),
                        SizedBox(width: 12),
                        Text(
                          "type",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Tap to Speak Button
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTapDown: (_) => setState(() => _isListening = true),
                  onTapUp: (_) => setState(() => _isListening = false),
                  child: Container(
                    height: 72,
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7DFFF), // Lavender color
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.mic, color: Colors.black),
                        SizedBox(width: 8),
                        Text(
                          "tap to speak",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (_showInput) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black.withOpacity(0.05)),
                    ),
                    child: TextField(
                      controller: _describeController,
                      maxLines: 1, // Single line for better layout with button
                      onChanged: (val) => setState(() {}),
                      decoration: const InputDecoration(
                        hintText: "Enter your scenario...",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      ),
                      style: const TextStyle(fontFamily: 'Poppins'),
                    ),
                  ),
                ),
                if (_describeController.text.isNotEmpty) ...[
                  const SizedBox(width: 12),
                  GestureDetector(
                    onTap: _startCreation,
                    child: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF6C91FF), // Themed blue
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.black, width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_upward, color: Colors.white),
                    ),
                  ).animate().scale(duration: 200.ms, curve: Curves.easeOut),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}
