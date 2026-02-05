import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2B1D00),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "My Streak",
                        style: GoogleFonts.familjenGrotesk(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Flag.fromString('GB', height: 18, width: 28, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "English",
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white.withOpacity(0.5),
                            size: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SvgPicture.asset(
                    'assets/share.svg',
                    width: 48,
                    height: 48,
                  ),
                ],
              ),
            ),

            // Scrollable Content (Flame & Calendar)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    // Large Flame Section
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        // We'll use the fire-component.svg but scaled up
                        SvgPicture.asset(
                          'assets/fire-component.svg',
                          width: 180,
                          height: 180,
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    Text(
                      "25",
                      style: GoogleFonts.familjenGrotesk(
                        fontSize: 64,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      "Day Streak",
                      style: GoogleFonts.familjenGrotesk(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Calendar Card Container
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF2B1D00).withOpacity(0.3),
                            offset: const Offset(8, 8),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Month Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const _CalendarNavButton(
                                assetPath: 'assets/Prev.svg',
                              ),
                              Text(
                                "February",
                                style: GoogleFonts.familjenGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2B2B2B),
                                ),
                              ),
                              const _CalendarNavButton(
                                assetPath: 'assets/Next.svg',
                                isInactive: true,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CalendarNavButton extends StatelessWidget {
  final String assetPath;
  final bool isInactive;

  const _CalendarNavButton({
    required this.assetPath,
    this.isInactive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isInactive ? 0.5 : 1.0,
      child: SvgPicture.asset(
        assetPath,
        width: 44,
        height: 44,
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> days = [
      "", "", "1", "2", "3", "4", "5",
      "6", "7", "8", "9", "10", "11", "12",
      "13", "14", "15", "16", "17", "18", "19",
      "20", "21", "22", "23", "24", "25", "26",
      "27", "28"
    ];

    return Wrap(
      spacing: (MediaQuery.of(context).size.width - 48 - 48 - (32 * 7)) / 6,
      runSpacing: 20,
      children: List.generate(days.length, (index) {
        final day = days[index];
        final bool isStreakRange = index >= 2 && index <= 26;
        final bool isStart = index == 2;
        final bool isEnd = index == 26;
        
        // Determine if it's start or end of a ROW for rounded corners
        final bool isRowStart = index % 7 == 0;
        final bool isRowEnd = index % 7 == 6;

        return Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            if (isStreakRange && day.isNotEmpty)
              Container(
                width: 46,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D1),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFFB6A06F).withOpacity(0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 1,
                    ),
                  ],
                  borderRadius: BorderRadius.horizontal(
                    left: (isStart || isRowStart) ? const Radius.circular(20) : Radius.zero,
                    right: (isEnd || isRowEnd) ? const Radius.circular(20) : Radius.zero,
                  ),
                ),
              ),
            if (isStart || isEnd)
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF4D1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: const Color(0xFF8B6B23),
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2B1D00).withOpacity(0.4),
                      offset: const Offset(4, 4),
                      blurRadius: 0,
                    ),
                  ],
                ),
              ),
            Container(
              width: 32,
              height: 32,
              child: Center(
                child: Text(
                  day,
                  style: GoogleFonts.familjenGrotesk(
                    fontSize: 16,
                    color: const Color(0xFF2B2B2B),
                    fontWeight: (isStart || isEnd) ? FontWeight.bold : FontWeight.w600,
                  ),
                ),
              ),
            ),
            if (isStart || isEnd)
              Positioned(
                top: -12,
                child: _SmallFlameBadge(),
              ),
          ],
        );
      }),
    );
  }
}

class _SmallFlameBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/fire-component.svg',
      width: 20,
      height: 20,
    );
  }
}

class _SmallFlame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: 0.2,
      child: SvgPicture.asset(
        'assets/fire-component.svg',
        width: 14,
        height: 14,
      ),
    );
  }
}
