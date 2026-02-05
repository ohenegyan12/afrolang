import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';
import 'package:languageapp/features/streak/streak_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  int _completedNodes = 0; // Tracks which node the mascot is currently at

  void _nextLevel() {
    if (_completedNodes < 4) {
      setState(() => _completedNodes++);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IndexedStack(
            index: _currentIndex,
            children: [
              _HomeView(
                completedNodes: _completedNodes,
              ),
              const StreakScreen(),
              const Center(child: Text("Tasks")),
              const Center(child: Text("Leaderboard")),
              const Center(child: Text("Profile")),
            ],
          ),
          // 4. Floating Bottom Navigation
          Positioned(
            left: 20,
            right: 20,
            bottom: 30,
            child: _FloatingBottomNav(
              currentIndex: _currentIndex,
              onTap: (index) => setState(() => _currentIndex = index),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeView extends StatelessWidget {
  final int completedNodes;

  const _HomeView({required this.completedNodes});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1. Background Gradient
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFB6EAFF),
                Colors.white,
              ],
              stops: [0.0, 0.4],
            ),
          ),
        ),

        // 2. Large Cloud Background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: SvgPicture.asset(
            'assets/cloud-home.svg',
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),

        // 2.5 Path Background & Content (Scrollable)
        Positioned.fill(
          child: ListView(
            padding: const EdgeInsets.only(top: 280),
            children: [
              _LearningPath(
                completedCount: completedNodes,
              ),
            ],
          ),
        ),

        // 3. Header Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                // Top Row: Greeting & Stats
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Greeting & Language
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Good Morning",
                          style: GoogleFonts.familjenGrotesk(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2B2B2B),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: Flag.fromString('DE', height: 18, width: 28, fit: BoxFit.cover),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "German",
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 18,
                                color: const Color(0xFF7B7B7B),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF7B7B7B)),
                          ],
                        ),
                      ],
                    ),
                    
                    // Stats Bubbles
                    Row(
                      children: [
                        _StatBubble(
                          iconPath: 'assets/diamond.svg',
                          value: "245",
                          color: const Color(0xFF38B6FF),
                        ),
                        const SizedBox(width: 8),
                        _StatBubble(
                          iconPath: 'assets/heart-component.svg',
                          value: "5",
                          color: const Color(0xFFFF4B4B),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 32),

                // Unit Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: const Color(0xFFE1F5FF), width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF38B6FF).withOpacity(0.1),
                        offset: const Offset(0, 8),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Level Icon
                      Container(
                        width: 64,
                        height: 64,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset(
                          'assets/level-icon.svg',
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Text Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Level 5, Unit 2",
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF38B6FF),
                              ),
                            ),
                            Text(
                              "The Unpredictable Park",
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2B2B2B),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Action Button
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE1F5FF).withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.segment_rounded,
                          color: Color(0xFF38B6FF),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _FloatingBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const _FloatingBottomNav({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _NavIcon(
            index: 0,
            currentIndex: currentIndex,
            assetPath: 'assets/home.svg',
            onTap: () => onTap(0),
          ),
          _NavIcon(
            index: 1,
            currentIndex: currentIndex,
            assetPath: 'assets/fire-component.svg',
            onTap: () => onTap(1),
          ),
          _NavIcon(
            index: 2,
            currentIndex: currentIndex,
            assetPath: 'assets/task.svg',
            onTap: () => onTap(2),
          ),
          _NavIcon(
            index: 3,
            currentIndex: currentIndex,
            assetPath: 'assets/leaderboard.svg',
            onTap: () => onTap(3),
          ),
          _NavIcon(
            index: 4,
            currentIndex: currentIndex,
            assetPath: 'assets/profile.svg',
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final int index;
  final int currentIndex;
  final String assetPath;
  final VoidCallback onTap;

  const _NavIcon({
    required this.index,
    required this.currentIndex,
    required this.assetPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = index == currentIndex;
    
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFFE1F5FF) : Colors.transparent,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          assetPath,
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}

class _LearningPath extends StatefulWidget {
  final int completedCount;

  const _LearningPath({
    required this.completedCount,
  });

  @override
  State<_LearningPath> createState() => _LearningPathState();
}

class _LearningPathState extends State<_LearningPath> {
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    
    // Define mascot positions for each step
    final List<Offset> mascotPositions = [
      const Offset(120, 0.15), // Initial
      const Offset(210, 0.18), // Above Node 1
      const Offset(330, 0.3),  // Above Node 2
      const Offset(450, 0.57), // Above Node 3
      const Offset(610, 0.39), // Above Node 4
    ];

    final currentPos = mascotPositions[widget.completedCount];

    return Stack(
      children: [
        // The Path Background
        SvgPicture.asset(
          'assets/Body.svg',
          width: width,
          fit: BoxFit.fitWidth,
        ),

        // Animated Mascot
        AnimatedPositioned(
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOutQuart,
          top: currentPos.dx,
          left: width * currentPos.dy,
          child: AnimatedScale(
            scale: 1.0,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOutQuart,
            child: SvgPicture.asset(
              'assets/mascot.svg',
              width: 130,
            ),
          ),
        ),

        // First Activity Node (Project)
        _PathNode(
          top: 300,
          left: width * 0.22,
          icon: Icons.menu_book_rounded,
          status: widget.completedCount > 0 ? 'completed' : 'locked',
        ),

        // Second Activity Node
        _PathNode(
          top: 420,
          left: width * 0.34,
          icon: Icons.fitness_center_rounded,
          status: widget.completedCount > 1 ? 'completed' : 'locked',
        ),

        // Third Activity Node
        _PathNode(
          top: 540,
          left: width * 0.61,
          icon: Icons.extension_rounded,
          status: widget.completedCount > 2 ? 'completed' : 'locked',
        ),

        // Fourth Activity Node
        _PathNode(
          top: 700,
          left: width * 0.43,
          icon: Icons.emoji_events_rounded,
          status: widget.completedCount > 3 ? 'completed' : 'locked',
        ),
        
        const SizedBox(height: 800),
      ],
    );
  }
}

class _PathNode extends StatelessWidget {
  final double top;
  final double left;
  final IconData icon;
  final String status;
  final double progress;

  const _PathNode({
    required this.top,
    required this.left,
    required this.icon,
    required this.status,
    this.progress = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    final bool isActive = status == 'active';
    final bool isCompleted = status == 'completed';

    return Positioned(
      top: top,
      left: left,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Progress Ring for Active
          if (isActive)
            SizedBox(
              width: 92,
              height: 92,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 8,
                backgroundColor: Colors.white.withOpacity(0.3),
                color: Colors.white,
                strokeCap: StrokeCap.round,
              ),
            ),
          
          // Main Circle
          Container(
            width: isActive ? 64 : 75,
            height: isActive ? 64 : 75,
            decoration: BoxDecoration(
              color: isCompleted || isActive ? Colors.white : Colors.white.withOpacity(0.4),
              shape: BoxShape.circle,
              boxShadow: [
                if (isCompleted || isActive)
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 10,
                  ),
              ],
            ),
            child: Icon(
              icon,
              size: isActive ? 30 : 36,
              color: isCompleted || isActive ? const Color(0xFF8B5A2B) : Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBubble extends StatelessWidget {
  final String iconPath;
  final String value;
  final Color color;

  const _StatBubble({
    required this.iconPath,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.5), width: 2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(iconPath, height: 20, width: 20),
          const SizedBox(width: 6),
          Text(
            value,
            style: GoogleFonts.familjenGrotesk(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF7B7B7B),
            ),
          ),
        ],
      ),
    );
  }
}

