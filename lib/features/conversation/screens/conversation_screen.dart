import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  // Demo states
  bool _isListening = false;
  bool _isProcessing = false;
  String _transcript = "Tap the microphone to start talking...";
  String _aiState = "Idle"; // Idle, Listening, Thinking, Speaking

  void _toggleListening() {
    setState(() {
      _isListening = !_isListening;
      _aiState = _isListening ? "Listening..." : "Thinking...";
      
      if (!_isListening) {
        // Simulate processing and response
        _processResponse();
      } else {
        _transcript = "Listening...";
      }
    });
  }

  void _processResponse() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(seconds: 2)); // Simulate network
    setState(() {
      _isProcessing = false;
      _aiState = "Speaking";
      _transcript = "Maakye! Wo ho te sɛn? (Good morning! How are you?)"; // Twi example
    });
    
    await Future.delayed(const Duration(seconds: 4));
    if (mounted) setState(() => _aiState = "Idle");
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Twi Conversation",
          style: GoogleFonts.familjenGrotesk(
            fontWeight: FontWeight.w600,
            fontSize: 18,
            color: isDark ? Colors.white : Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. Conversation History / Transcript Area
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.center,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _transcript,
                  key: ValueKey(_transcript),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.familjenGrotesk(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                    color: isDark ? Colors.white.withOpacity(0.9) : Colors.black87,
                  ),
                ),
              ),
            ),
          ),

          // 2. Visualizer / AI Avatar Area
          Expanded(
            flex: 2,
            child: _buildVisualizer(theme),
          ),

          // 3. Controls
          _buildControls(theme),
        ],
      ),
    );
  }

  Widget _buildVisualizer(ThemeData theme) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary.withOpacity(0.2),
              theme.colorScheme.secondary.withOpacity(0.2),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.1),
              blurRadius: 40,
              spreadRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
             // Pulsing rings
            ...List.generate(3, (index) {
              return Container(
                width: 200.0 - (index * 40),
                height: 200.0 - (index * 40),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.1 + (index * 0.1)),
                    width: 2,
                  ),
                ),
              )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .scale(
                duration: Duration(milliseconds: 2000 + (index * 500)),
                begin: const Offset(0.9, 0.9),
                end: const Offset(1.1, 1.1),
                curve: Curves.easeInOut,
              );
            }),
            
            // Core Circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _isListening ? 140 : 120,
              height: _isListening ? 140 : 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primary,
                    theme.colorScheme.secondary,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.4),
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: Icon(
                _isListening ? Icons.mic : Icons.graphic_eq,
                color: Colors.white,
                size: 48,
              ),
            ).animate(target: _isListening ? 1 : 0)
            .shimmer(duration: 1500.ms, color: Colors.white54),
          ],
        ),
      ),
    );
  }

  Widget _buildControls(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(
            icon: Icons.keyboard,
            label: "Type",
            onTap: () {},
            theme: theme,
          ),
          
          // Main Action Button (Mic)
          GestureDetector(
            onTap: _toggleListening,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _isListening ? Colors.redAccent : theme.colorScheme.primary,
                boxShadow: [
                  BoxShadow(
                    color: (_isListening ? Colors.redAccent : theme.colorScheme.primary).withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  )
                ],
              ),
              child: Icon(
                _isListening ? Icons.stop : Icons.mic_none,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          
          _controlButton(
            icon: Icons.history, // Or 'Tips'
            label: "History",
            onTap: () {},
            theme: theme,
          ),
        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ThemeData theme,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: theme.colorScheme.onSurface.withOpacity(0.6),
          iconSize: 28,
        ),
        Text(
          label,
          style: GoogleFonts.familjenGrotesk(
            fontSize: 12,
            color: theme.colorScheme.onSurface.withOpacity(0.6),
          ),
        ),
      ],
    );
  }
}
