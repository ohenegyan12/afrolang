import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:languageapp/features/home/screens/level_details_screen.dart';

class ExploreLevelsScreen extends StatelessWidget {
  const ExploreLevelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFF2F2F2), width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFF2F2F2),
                            offset: const Offset(0, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
                    ),
                  ),
                  Text(
                    "Explore Levels",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B2B2B),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: const Color(0xFF38B6FF).withOpacity(0.3), width: 2),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/diamond.svg', height: 24, width: 24),
                        const SizedBox(width: 8),
                        Text(
                          "245",
                          style: GoogleFonts.familjenGrotesk(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF7B7B7B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 20),

            // Levels List
            Expanded(
              child: Stack(
                children: [
                  // Levels
                  ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    children: [
                      _LevelItem(
                        title: "Incredible Cave",
                        subtitle: "Level 4, Total Units 12",
                        iconPath: 'assets/level-icon.svg',
                        bannerPath: 'assets/level-cover-image.jpg',
                        iconBgColor: const Color(0xFFD47400),
                        status: LevelStatus.completed,
                        isFirst: true,
                      ),
                      _LevelItem(
                        title: "The Unpredictable Park",
                        subtitle: "Level 5, Total Units 12",
                        iconPath: 'assets/Level icon 2.svg',
                        bannerPath: 'assets/Level Cover Image 2.png',
                        iconBgColor: const Color(0xFF8B6A56),
                        status: LevelStatus.active,
                      ),
                      _LevelItem(
                        title: "The Flaming Desert",
                        subtitle: "Level 6, Total Units 8",
                        iconPath: 'assets/Level icon locked.svg',
                        bannerPath: 'assets/Level Cover Image 3.png',
                        iconBgColor: const Color(0xFFA5A5A5),
                        status: LevelStatus.locked,
                        isLast: true,
                      ),
                      const SizedBox(height: 100),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum LevelStatus { locked, active, completed }

class _LevelItem extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final String bannerPath;
  final Color iconBgColor;
  final LevelStatus status;
  final bool isFirst;
  final bool isLast;

  const _LevelItem({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.bannerPath,
    required this.iconBgColor,
    this.status = LevelStatus.completed,
    this.isFirst = false,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isLocked = status == LevelStatus.locked;
    final bool isCompleted = status == LevelStatus.completed;
    final bool isActive = status == LevelStatus.active;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Timeline Column
          SizedBox(
            width: 36,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                // Base Light Blue Track
                Positioned(
                  top: 0,
                  bottom: 0,
                  width: 28,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F9FF),
                      borderRadius: BorderRadius.only(
                        topLeft: isFirst ? const Radius.circular(14) : Radius.zero,
                        topRight: isFirst ? const Radius.circular(14) : Radius.zero,
                        bottomLeft: isLast ? const Radius.circular(14) : Radius.zero,
                        bottomRight: isLast ? const Radius.circular(14) : Radius.zero,
                      ),
                    ),
                  ),
                ),

                // Highlighted Line (Blue Fill)
                if (!isLocked)
                  Positioned(
                    top: 0,
                    bottom: 0, 
                    width: 28,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF38B6FF),
                        borderRadius: BorderRadius.only(
                          topLeft: isFirst ? const Radius.circular(14) : Radius.zero,
                          topRight: isFirst ? const Radius.circular(14) : Radius.zero,
                          bottomLeft: ((isActive && !isCompleted && !isLocked) || isLast) 
                              ? const Radius.circular(14) : Radius.zero,
                          bottomRight: ((isActive && !isCompleted && !isLocked) || isLast) 
                              ? const Radius.circular(14) : Radius.zero,
                        ),
                      ),
                    ),
                  ),
                
                // Dot
                Positioned(
                  top: 36,
                  child: Container(
                    width: 14,
                    height: 14,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: (isLocked) ? const Color(0xFF38B6FF) : Colors.white,
                        width: 3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // Card Content
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LevelDetailsScreen(
                      title: title,
                      subtitle: subtitle,
                      iconPath: iconPath,
                      bannerPath: bannerPath,
                      iconBgColor: iconBgColor,
                      isLocked: isLocked,
                    ),
                  ),
                );
              },
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header Row
                  Row(
                    children: [
                      SizedBox(
                        width: 52,
                        height: 52,
                        child: SvgPicture.asset(
                          iconPath,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF2B2B2B),
                              ),
                            ),
                            Text(
                              subtitle,
                              style: GoogleFonts.familjenGrotesk(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF38B6FF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: !isLocked ? const Color(0xFFE1F5FF) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: !isLocked 
                          ? const Icon(
                              Icons.chevron_right_rounded,
                              color: Color(0xFF38B6FF),
                              size: 24,
                            )
                          : Center(
                              child: SvgPicture.asset(
                                'assets/level-locked.svg',
                                width: 44,
                                height: 44,
                                fit: BoxFit.contain,
                              ),
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // Banner Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.asset(
                      bannerPath,
                      width: double.infinity,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
