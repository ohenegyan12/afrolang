import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageapp/features/scenario/widgets/scenario_card.dart';
import 'package:languageapp/features/home/widgets/menu_sheet.dart';
import 'package:languageapp/features/scenario/screens/scenario_detail_screen.dart';

class ScenarioPage extends StatefulWidget {
  const ScenarioPage({super.key});

  @override
  State<ScenarioPage> createState() => _ScenarioPageState();
}

class _ScenarioPageState extends State<ScenarioPage> {
  // Define color palettes
  final List<Map<String, Color>> _cardColors = [
    {'bg': const Color(0xFFD4E8E4), 'btn': const Color(0xFFB8D9D3)}, // Greenish
    {'bg': const Color(0xFFE8D9D0), 'btn': const Color(0xFFD9C4B5)}, // Brownish
    {'bg': const Color(0xFFE8E4D9), 'btn': const Color(0xFFD9D4C4)}, // Beige
    {'bg': const Color(0xFFE0E0FF), 'btn': const Color(0xFFD0D0EF)}, // Bluish
  ];

  final List<String> _sections = [
    "GREETINGS",
    "DAILY LIFE",
    "TRAVEL",
    "FOOD AND DRINK",
    "HOME",
    "PREFERENCES",
    "WORK",
    "SHOPPING",
    "SOCIAL LIFE",
    "FRIENDS AND FAMILY",
    "CULTURE",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SafeArea(
        child: Column(
          children: [
            // Fixed Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Burger Menu
                  IconButton(
                    icon: const Icon(Icons.menu, size: 28, color: Colors.black),
                    onPressed: () {
                      showMenuSheet(context);
                    },
                  ),
                  
                  // Logo
                  SvgPicture.asset(
                    'assets/images/afrolingo-logo.svg',
                    height: 32,
                  ),
                  
                  // Streak Counter
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/streak.svg',
                          height: 20,
                          width: 20,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          "0",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF5D686F),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Page Title
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        "Lets get started with your first lesson!",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          height: 1.2,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    
                    ..._sections.map((section) => _buildSection(section)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text(
            title,
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24, // Matches homepage section titles
              fontWeight: FontWeight.w700, // Matches homepage bold font weight
              color: Colors.black,
              letterSpacing: 0.5,
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 320, // Reduced height for smaller cards
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: 4, // 4 cards per section as requested
            itemBuilder: (context, index) {
              // Cycle through colors
              final colors = _cardColors[index % _cardColors.length];
              
              return Padding(
                padding: const EdgeInsets.only(right: 16, bottom: 16),
                child: ScenarioCard(
                  width: 280,
                  imageUrl: 'assets/images/coffee-scenario.jpg', // Placeholder image
                  duration: '${(index + 3) * 2} min',
                  title: '$title ${index + 1}',
                  description: 'This is a scenario about ${title.toLowerCase()} and practicing your skills.',
                  backgroundColor: colors['bg']!,
                  buttonColor: colors['btn']!,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScenarioDetailScreen(
                          title: '$title ${index + 1}',
                          description: 'This is a scenario about ${title.toLowerCase()} and practicing your skills.',
                          duration: '${(index + 3) * 2} min',
                          imageUrl: 'assets/images/ronaldstilting-fisherman-5704299_1280.jpg',
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
