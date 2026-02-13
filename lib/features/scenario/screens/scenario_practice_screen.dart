import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:languageapp/features/padiman/screens/padiman_screen.dart';

class ScenarioPracticeScreen extends StatefulWidget {
  final String scenarioTitle;
  
  const ScenarioPracticeScreen({
    super.key,
    required this.scenarioTitle,
  });

  @override
  State<ScenarioPracticeScreen> createState() => _ScenarioPracticeScreenState();
}

enum PracticeType { listen, match }

class PracticeStep {
  final String twi;
  final String english;
  final String pronunciation;
  final PracticeType type;
  final List<String>? options;

  PracticeStep({
    required this.twi,
    required this.english,
    required this.pronunciation,
    required this.type,
    this.options,
  });
}

class _ScenarioPracticeScreenState extends State<ScenarioPracticeScreen> {
  int _currentIndex = 0;
  bool _isRevealed = false;
  bool _isListening = false;
  String? _selectedOption;
  bool? _isCorrect;
  
  // Expanded dataset with multiple game types
  final List<PracticeStep> _practiceSteps = [
    PracticeStep(twi: "Kɔfe", english: "Coffee", pronunciation: "[Ko-fe]", type: PracticeType.listen),
    PracticeStep(twi: "Asikyire", english: "Sugar", pronunciation: "[A-si-ch-ire]", type: PracticeType.listen),
    PracticeStep(
      twi: "Kɔfe", 
      english: "Coffee", 
      pronunciation: "[Ko-fe]", 
      type: PracticeType.match,
      options: ["Kɔfe", "Asikyire", "Nsuo", "Paanoo"]
    ),
    PracticeStep(twi: "Nsuo", english: "Water", pronunciation: "[N-su-o]", type: PracticeType.listen),
    PracticeStep(twi: "Paanoo", english: "Bread", pronunciation: "[Paa-noo]", type: PracticeType.listen),
    PracticeStep(
      twi: "Nsuo", 
      english: "Water", 
      pronunciation: "[N-su-o]", 
      type: PracticeType.match,
      options: ["Asikyire", "Nsuo", "Kɔfe", "Anika"]
    ),
    PracticeStep(twi: "Mepa wo kyɛw", english: "Please", pronunciation: "[Me-pa wo ch-ew]", type: PracticeType.listen),
    PracticeStep(twi: "Aseda", english: "Thank you", pronunciation: "[A-se-da]", type: PracticeType.listen),
    PracticeStep(
      twi: "Aseda", 
      english: "Thank you", 
      pronunciation: "[A-se-da]", 
      type: PracticeType.match,
      options: ["Medaase", "Aseda", "Akyire", "Anɔpa"]
    ),
    PracticeStep(twi: "Sika", english: "Money", pronunciation: "[Si-ka]", type: PracticeType.listen),
  ];

  void _next() {
    if (_currentIndex < _practiceSteps.length - 1) {
      setState(() {
        _currentIndex++;
        _isRevealed = false;
        _isListening = false;
        _selectedOption = null;
        _isCorrect = null;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PadimanScreen()),
      );
    }
  }

  void _checkAnswer(String option) {
    if (_isCorrect != null) return;
    
    setState(() {
      _selectedOption = option;
      _isCorrect = option == _practiceSteps[_currentIndex].twi;
    });

    if (_isCorrect!) {
      Future.delayed(800.ms, _next);
    }
  }

  @override
  Widget build(BuildContext context) {
    final step = _practiceSteps[_currentIndex];
    final progress = (_currentIndex + 1) / _practiceSteps.length;

    return Scaffold(
      backgroundColor: const Color(0xFFF9F7F2),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black54),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Stack(
                        children: [
                          AnimatedContainer(
                            duration: 400.ms,
                            curve: Curves.easeOut,
                            width: MediaQuery.of(context).size.width * 0.6 * progress,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6C91FF),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    "${_currentIndex + 1}/${_practiceSteps.length}",
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: AnimatedSwitcher(
                  duration: 400.ms,
                  child: step.type == PracticeType.listen 
                    ? _buildListenStep(step)
                    : _buildMatchStep(step),
                ),
              ),
            ),

            // Bottom Actions
            if (step.type == PracticeType.listen) 
              _buildListenBottom()
            else
              const SizedBox(height: 100), // Space for matching flow
          ],
        ),
      ),
    );
  }

  Widget _buildListenStep(PracticeStep step) {
    return Column(
      key: ValueKey("listen_${_currentIndex}"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "HEAR AND REPEAT",
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF6C91FF),
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 32),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            children: [
              IconButton(
                onPressed: () {}, 
                icon: const Icon(Icons.volume_up, size: 48, color: Color(0xFF6C91FF)),
              ),
              const SizedBox(height: 16),
              Text(
                step.twi,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                step.pronunciation,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  color: Colors.black.withOpacity(0.4),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ).animate().fadeIn().slideY(begin: 0.1, end: 0),
        const SizedBox(height: 48),
        _buildTranslationPeek(step),
      ],
    );
  }

  Widget _buildMatchStep(PracticeStep step) {
    return Column(
      key: ValueKey("match_${_currentIndex}"),
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "SELECT THE CORRECT TRANSLATION",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: Colors.orange,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "How do you say \"${step.english}\"?",
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 40),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.2,
          children: step.options!.map((opt) => _buildOptionCard(opt)).toList(),
        ),
      ],
    );
  }

  Widget _buildOptionCard(String option) {
    bool isSelected = _selectedOption == option;
    Color cardColor = Colors.white;
    Color textColor = Colors.black87;
    BoxBorder? cardBorder = Border.all(color: Colors.black.withOpacity(0.05));

    if (isSelected) {
      if (_isCorrect == true) {
        cardColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        cardBorder = Border.all(color: Colors.green.shade200, width: 2);
      } else if (_isCorrect == false) {
        cardColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        cardBorder = Border.all(color: Colors.red.shade200, width: 2);
      }
    }

    return GestureDetector(
      onTap: () => _checkAnswer(option),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(24),
          border: cardBorder,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Center(
          child: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ),
      ),
    ).animate(target: isSelected ? 1 : 0)
     .scale(begin: const Offset(1,1), end: const Offset(1.05, 1.05), duration: 200.ms);
  }

  Widget _buildTranslationPeek(PracticeStep step) {
    return AnimatedSwitcher(
      duration: 300.ms,
      child: _isRevealed
        ? Column(
            key: const ValueKey("meaning_revealed"),
            children: [
              const Text("MEANING", style: TextStyle(fontFamily: 'Poppins', fontSize: 12, fontWeight: FontWeight.w600, color: Colors.black38)),
              const SizedBox(height: 8),
              Text(step.english, style: const TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black87)),
            ],
          )
        : GestureDetector(
            onTap: () => setState(() => _isRevealed = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              decoration: BoxDecoration(color: const Color(0xFFFFF9E6), borderRadius: BorderRadius.circular(16)),
              child: const Text("Tap to reveal meaning", style: TextStyle(fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w600, color: Colors.orange)),
            ),
          ),
    );
  }

  Widget _buildListenBottom() {
    return Container(
      padding: const EdgeInsets.fromLTRB(32, 24, 32, 48),
      decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(40))),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTapDown: (_) => setState(() => _isListening = true),
            onTapUp: (_) => setState(() => _isListening = false),
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (_isListening)
                  ...List.generate(2, (i) => 
                    Container(
                      width: 90 + (i * 40), height: 90 + (i * 40),
                      decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: const Color(0xFF6C91FF).withOpacity(0.2 - (i * 0.1)), width: 2)),
                    ).animate(onPlay: (c) => c.repeat()).scale(begin: const Offset(1, 1), end: const Offset(1.4, 1.4), duration: 1200.ms).fadeOut(duration: 1200.ms)
                  ),
                Container(
                  width: 84, height: 84,
                  decoration: BoxDecoration(color: _isListening ? const Color(0xFF6C91FF) : Colors.black, shape: BoxShape.circle),
                  child: Icon(_isListening ? Icons.mic : Icons.mic_none, color: Colors.white, size: 38),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(_isListening ? "Listening..." : "Hold to repeat", style: const TextStyle(fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black45)),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity, height: 64,
            child: ElevatedButton(onPressed: _next, style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6C91FF), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))), child: const Text("Continue", style: TextStyle(fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
