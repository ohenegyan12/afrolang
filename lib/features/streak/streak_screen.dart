import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flag/flag.dart';

class StreakScreen extends StatefulWidget {
  const StreakScreen({super.key});

  @override
  State<StreakScreen> createState() => _StreakScreenState();
}

class _StreakScreenState extends State<StreakScreen> {
  DateTime _displayedMonth = DateTime.now();

  void _changeMonth(int delta) {
    setState(() {
      _displayedMonth = DateTime(_displayedMonth.year, _displayedMonth.month + delta, 1);
    });
  }

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
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF1A1200).withOpacity(0.4),
                          offset: const Offset(0, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: SvgPicture.asset(
                      'assets/share.svg',
                      width: 48,
                      height: 48,
                    ),
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
                              _CalendarNavButton(
                                assetPath: 'assets/Prev.svg',
                                onTap: () => _changeMonth(-1),
                              ),
                              Text(
                                _getMonthName(_displayedMonth.month),
                                style: GoogleFonts.familjenGrotesk(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF2B2B2B),
                                ),
                              ),
                              _CalendarNavButton(
                                assetPath: 'assets/Next.svg',
                                onTap: () => _changeMonth(1),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          _CalendarGrid(displayedMonth: _displayedMonth),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Streak Goal Card
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Streak Goal",
                            style: GoogleFonts.familjenGrotesk(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2B2B2B),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              SvgPicture.asset(
                                'assets/start-date.svg',
                                width: 44,
                                height: 44,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Container(
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF7E6),
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                  child: Stack(
                                    children: [
                                      FractionallySizedBox(
                                        widthFactor: 25 / 75,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            gradient: const LinearGradient(
                                              colors: [
                                                Color(0xFFFFC55A),
                                                Color(0xFFFFDB91)
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(22),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              SvgPicture.asset(
                                'assets/end-date.svg',
                                width: 44,
                                height: 44,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(24, 0, 24, 30),
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF2B1D00).withOpacity(0.2),
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _NavBarIcon(icon: Icons.home_rounded, color: const Color(0xFF464E53)),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFFFF7E6),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.whatshot_rounded,
                color: Color(0xFFFF8B3F),
                size: 32,
              ),
            ),
            _NavBarIcon(icon: Icons.videocam_rounded, color: const Color(0xFF464E53)),
            _NavBarIcon(icon: Icons.emoji_events_rounded, color: const Color(0xFF464E53)),
            _NavBarIcon(icon: Icons.person_rounded, color: const Color(0xFF464E53)),
          ],
        ),
      ),
    );
  }

  String _getMonthName(int month) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    return monthNames[month - 1];
  }
}

class _NavBarIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _NavBarIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Icon(icon, color: color, size: 28);
  }
}

class _CalendarNavButton extends StatelessWidget {
  final String assetPath;
  final bool isInactive;
  final VoidCallback? onTap;

  const _CalendarNavButton({
    required this.assetPath,
    this.isInactive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isPrev = assetPath.contains('Prev');
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isInactive ? const Color(0xFFFEF7E6) : const Color(0xFFFFC55A),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: isInactive ? const Color(0xFFF1E6CC) : const Color(0xFFB38B3F),
              offset: const Offset(0, 4),
              blurRadius: 0,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            isPrev ? Icons.chevron_left_rounded : Icons.chevron_right_rounded,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class _CalendarGrid extends StatelessWidget {
  final DateTime displayedMonth;

  const _CalendarGrid({required this.displayedMonth});

  @override
  Widget build(BuildContext context) {
    final List<String> weekdays = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
    
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month, 1);
    final lastDayOfMonth = DateTime(displayedMonth.year, displayedMonth.month + 1, 0);
    
    final int offset = firstDayOfMonth.weekday % 7; // Sunday is 7 in DateTime, we want 0
    final int daysInMonth = lastDayOfMonth.day;
    final int currentDay = now.day;
    final bool isCurrentMonth = now.year == displayedMonth.year && now.month == displayedMonth.month;

    return Column(
      children: [
        // Weekday Headers
        Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: weekdays.map((day) => Expanded(
              child: Center(
                child: Text(
                  day,
                  style: GoogleFonts.familjenGrotesk(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2B2B2B),
                  ),
                ),
              ),
            )).toList(),
          ),
        ),
        
        // Date Grid
        Column(
          children: List.generate((daysInMonth + offset + 6) ~/ 7, (weekIndex) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: List.generate(7, (dayIndex) {
                  final int absoluteIndex = weekIndex * 7 + dayIndex;
                  final int date = absoluteIndex - offset + 1;
                  final bool isDate = date >= 1 && date <= daysInMonth;
                  final bool isToday = isCurrentMonth && isDate && date == currentDay;

                  return Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Date Widget
                        if (isDate)
                          SizedBox(
                            height: 44,
                            child: Center(
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  if (isToday)
                                    SvgPicture.asset(
                                      'assets/highlight-start-flame.svg',
                                      width: 42,
                                      height: 42,
                                    ),
                                  Text(
                                    date.toString(),
                                    style: GoogleFonts.familjenGrotesk(
                                      fontSize: 18,
                                      fontWeight: isToday ? FontWeight.bold : FontWeight.w500,
                                      color: const Color(0xFF2B2B2B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                }),
              ),
            );
          }),
        ),
      ],
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
