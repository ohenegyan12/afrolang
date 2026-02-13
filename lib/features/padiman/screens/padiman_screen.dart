import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:math' as math;
import 'package:flag/flag.dart';

class PadimanScreen extends StatefulWidget {
  const PadimanScreen({super.key});

  @override
  State<PadimanScreen> createState() => _PadimanScreenState();
}

class _PadimanScreenState extends State<PadimanScreen> with SingleTickerProviderStateMixin {
  bool _isListening = false;
  bool _isThinking = false;
  String _currentAiMessage = "Maakye, wo ho te sεn?";
  String _currentTranslation = "Good morning, how are you?";
  
  // AI Settings
  double _speechSpeed = 1.0;
  bool _showTranslations = true;
  bool _autoPlay = true;

  void _showSettingsModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFCFAF7),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                "AI Settings",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              
              // Speech Speed
              const Text(
                "Speech Speed",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  _buildSpeedChip("Slow", 0.75, setModalState),
                  const SizedBox(width: 12),
                  _buildSpeedChip("Normal", 1.0, setModalState),
                  const SizedBox(width: 12),
                  _buildSpeedChip("Fast", 1.25, setModalState),
                ],
              ),
              const SizedBox(height: 32),
              
              // Simple Toggles
              _buildSettingToggle(
                "Show Translations",
                "Display English text below Twi",
                _showTranslations,
                (val) => setModalState(() => _showTranslations = val),
              ),
              const SizedBox(height: 16),
              _buildSettingToggle(
                "Auto-play Audio",
                "Automatically play AI responses",
                _autoPlay,
                (val) => setModalState(() => _autoPlay = val),
              ),
            ],
          ),
        ),
      ),
    ).then((_) => setState(() {})); // Refresh UI if needed
  }

  Widget _buildSpeedChip(String label, double speed, StateSetter setModalState) {
    bool isSelected = _speechSpeed == speed;
    return Expanded(
      child: GestureDetector(
        onTap: () => setModalState(() => _speechSpeed = speed),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF6C91FF) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.black.withOpacity(0.05),
            ),
            boxShadow: isSelected ? [
              BoxShadow(
                color: const Color(0xFF6C91FF).withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ] : [],
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingToggle(String title, String subtitle, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 13,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: (val) {
            onChanged(val);
            setState(() {});
          },
          activeColor: const Color(0xFF6C91FF),
        ),
      ],
    );
  }

  void _showEndSessionConfirmation() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFFFCFAF7),
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: const Text(
          "End Session?",
          style: TextStyle(
            fontFamily: 'Poppins', 
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        content: const Text(
          "Ready to wrap up your practice with Padiman AI?",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12, right: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Stay",
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.4),
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context); // Close modal
                    Navigator.pop(context); // Go back to homepage
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text(
                    "End Session",
                    style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _toggleListening() async {
    setState(() {
      _isListening = !_isListening;
      _isThinking = false;
    });

    if (!_isListening) {
      // Logic for when stopping listening - simulate thinking
      setState(() => _isThinking = true);
      await Future.delayed(2.seconds);
      setState(() => _isThinking = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      body: Column(
        children: [
          // Upper Content inside SafeArea
          Expanded(
            child: SafeArea(
              bottom: false, // Allow content to reach voice interface
              child: Column(
                children: [
                  // Premium Header
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildIconButton(Icons.settings_outlined, () {
                          _showSettingsModal();
                        }),
                        _buildLanguageIndicator(),
                        GestureDetector(
                          onTap: _showEndSessionConfirmation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.04),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Text(
                              'done',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Visualizer (Dynamic based on state)
                          _buildVisualizerSection(),
                          const SizedBox(height: 48),

                          // AI Message Area
                          AnimatedSwitcher(
                            duration: 400.ms,
                            child: _isThinking 
                              ? _buildThinkingState()
                              : _buildAiMessageDisplay(),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Voice UI touches the bottom of the screen
          _buildVoiceInterface(),
        ],
      ),
    );
  }

  Widget _buildLanguageIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flag.fromCode(FlagsCode.GH, width: 20, height: 15),
          const SizedBox(width: 8),
          const Text(
            "Twi",
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVisualizerSection() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Pulsing background glow
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                const Color(0xFF6C91FF).withOpacity(_isListening ? 0.15 : 0.05),
                const Color(0xFF6C91FF).withOpacity(0),
              ],
            ),
          ),
        ).animate(onPlay: (c) => c.repeat())
         .scale(begin: const Offset(0.9, 0.9), end: const Offset(1.2, 1.2), duration: 2.seconds, curve: Curves.easeInOut),

        // The Wave
        if (!_isThinking)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(40, (index) {
            double distanceFromCenter = (index - 20).abs().toDouble();
            double heightFactor = 1.0 - (distanceFromCenter / 22);
            double baseHeight = 15 + (heightFactor * 50);
            
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 2.5),
              width: 3.5,
              height: baseHeight,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF6C91FF).withOpacity(0.4),
                    const Color(0xFF6C91FF),
                    const Color(0xFF6C91FF).withOpacity(0.4),
                  ],
                ),
              ),
            )
            .animate(onPlay: (c) => _isListening ? c.repeat(reverse: true) : c.stop())
            .scaleY(
              begin: 0.5,
              end: 1.8,
              duration: (400 + (index % 5) * 100).ms,
              delay: (index * 20).ms,
              curve: Curves.easeInOut,
            );
          }),
        ),
      ],
    );
  }

  Widget _buildAiMessageDisplay() {
    return Column(
      key: ValueKey(_currentAiMessage),
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 6,
              height: 6,
              decoration: const BoxDecoration(
                color: Color(0xFF6C91FF),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              "Padiman AI",
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: Color(0xFF6C91FF),
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          _currentAiMessage,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: Colors.black,
          ),
        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0),
        const SizedBox(height: 12),
        if (_showTranslations)
        Text(
          _currentTranslation,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black.withOpacity(0.3),
          ),
        ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
      ],
    );
  }

  Widget _buildThinkingState() {
    return Column(
      key: const ValueKey("thinking"),
      children: [
        const Text(
          "Padiman is thinking...",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (i) => 
            Container(
              width: 10,
              height: 10,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: const BoxDecoration(
                color: Color(0xFF6C91FF),
                shape: BoxShape.circle,
              ),
            ).animate(onPlay: (c) => c.repeat())
             .scale(begin: const Offset(0.8, 0.8), end: const Offset(1.2, 1.2), duration: 600.ms, delay: (i * 200).ms)
             .fadeOut(begin: 0.4, duration: 600.ms)
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black87, size: 22),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildVoiceInterface() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 28, 32, 44),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(44)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSwitcher(
            duration: 200.ms,
            child: Text(
              _isListening ? "Listening..." : "Tap to speak",
              key: ValueKey(_isListening),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _isListening ? const Color(0xFF6C91FF) : Colors.black38,
              ),
            ),
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: _toggleListening,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_isListening)
                  ...List.generate(2, (i) => 
                    Container(
                      width: 90 + (i * 40),
                      height: 90 + (i * 40),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF6C91FF).withOpacity(0.2 - (i * 0.1)),
                          width: 2,
                        ),
                      ),
                    ).animate(onPlay: (c) => c.repeat())
                     .scale(begin: const Offset(1.0, 1.0), end: const Offset(1.4, 1.4), duration: 1200.ms, curve: Curves.easeOut)
                     .fadeOut(duration: 1200.ms)
                  ),
                
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: _isListening ? const Color(0xFF6C91FF) : Colors.black,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isListening ? const Color(0xFF6C91FF) : Colors.black).withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Icon(
                    _isListening ? Icons.mic : Icons.mic_none,
                    color: Colors.white,
                    size: 38,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Tooltip/Hint
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.lightbulb_outline, size: 18, color: Colors.orange.shade400),
              const SizedBox(width: 10),
              Text(
                "Try saying: \"M'adamfo\"",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}


