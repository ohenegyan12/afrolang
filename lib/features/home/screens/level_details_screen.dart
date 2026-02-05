import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LevelDetailsScreen extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final String bannerPath;
  final Color iconBgColor;
  final bool isLocked;

  const LevelDetailsScreen({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.bannerPath,
    required this.iconBgColor,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Banner Section
            Stack(
              children: [
                // Banner Image
                Image.asset(
                  bannerPath,
                  width: double.infinity,
                  height: 380,
                  fit: BoxFit.cover,
                ),
                // Overlay Header
                SafeArea(
                  bottom: false,
                  child: Padding(
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
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0xFFEAEAEA),
                                  offset: Offset(0, 4),
                                  blurRadius: 0,
                                ),
                              ],
                            ),
                            child: const Icon(Icons.arrow_back, color: Color(0xFF2B2B2B)),
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
                ),
                // Level Info Card (Positioned partly over image)
                Positioned(
                  left: 20,
                  right: 20,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(0, -4),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 52,
                          height: 52,
                          decoration: BoxDecoration(
                            color: isLocked ? const Color(0xFFA5A5A5) : iconBgColor,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(10),
                          child: SvgPicture.asset(iconPath),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: GoogleFonts.familjenGrotesk(
                                  fontSize: 22,
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
                            color: const Color(0xFFF2F2F2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.share_outlined, color: Color(0xFF7B7B7B), size: 24),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            if (!isLocked) ...[
              // Performance Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Performance",
                      style: GoogleFonts.familjenGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF2B2B2B),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        _PerformanceCard(
                          iconPath: 'assets/fire-component.svg',
                          value: "234",
                          label: "Total XP",
                          accentColor: const Color(0xFFFFC55A),
                        ),
                        const SizedBox(width: 12),
                        _PerformanceCard(
                          icon: Icons.track_changes_rounded,
                          value: "64%",
                          label: "Good",
                          accentColor: const Color(0xFF38B6FF),
                        ),
                        const SizedBox(width: 12),
                        _PerformanceCard(
                          icon: Icons.timer_outlined,
                          value: "34",
                          label: "Days",
                          accentColor: const Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // About Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "About this level",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF2B2B2B),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "This level is for very beginners level users to get start with their basic words and info\n\nLorem ipsum is a dummy or placeholder text commonly used in graphic design, publishing, and web development\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                    style: GoogleFonts.familjenGrotesk(
                      fontSize: 16,
                      color: const Color(0xFF7B7B7B),
                      height: 1.6,
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Bottom Button
                  if (!isLocked)
                    Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF38B6FF), Color(0xFF7BD5FF)],
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF38B6FF).withOpacity(0.3),
                            offset: const Offset(0, 8),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          "Re-Start - 30XP",
                          style: GoogleFonts.familjenGrotesk(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  else
                    Container(
                      width: double.infinity,
                      height: 64,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color(0xFFEAEAEA), width: 2),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0xFF2B2B2B),
                            offset: Offset(0, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Unlock with ",
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B2B2B),
                            ),
                          ),
                          SvgPicture.asset('assets/diamond.svg', height: 24, width: 24),
                          Text(
                            " 350",
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B3C44),
                            ),
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PerformanceCard extends StatelessWidget {
  final IconData? icon;
  final String? iconPath;
  final String value;
  final String label;
  final Color accentColor;

  const _PerformanceCard({
    this.icon,
    this.iconPath,
    required this.value,
    required this.label,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: accentColor.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: accentColor.withOpacity(0.2),
              offset: const Offset(0, 6),
              blurRadius: 0,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconPath != null)
              SvgPicture.asset(iconPath!, height: 32, width: 32, colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn))
            else
              Icon(icon, size: 32, color: accentColor),
            const SizedBox(height: 8),
            Text(
              value,
              style: GoogleFonts.familjenGrotesk(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF2B2B2B),
              ),
            ),
            Text(
              label,
              style: GoogleFonts.familjenGrotesk(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: accentColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
