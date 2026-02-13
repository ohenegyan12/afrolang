import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:languageapp/features/home/widgets/welcome_modal.dart';
import 'package:languageapp/features/scenario/screens/scenario_page.dart';
import 'package:languageapp/features/home/widgets/menu_sheet.dart';
import 'package:languageapp/features/scenario/screens/scenario_detail_screen.dart';
import 'package:languageapp/features/padiman/screens/padiman_screen.dart';
import 'package:languageapp/features/scenario/screens/create_scenario_screen.dart';

class HomeScreen extends StatefulWidget {
  final bool showWelcomeModal;
  
  const HomeScreen({
    super.key,
    this.showWelcomeModal = false,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  DateTime _selectedProgressMonth = DateTime(2026, 2);

  @override
  void initState() {
    super.initState();
    
    // Show welcome modal after first frame if needed
    if (widget.showWelcomeModal) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showWelcomeModal();
      });
    }
  }

  void _showWelcomeModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => const WelcomeModal(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: _buildBody(),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItemWithSvg(
                  svgPath: 'assets/icons/home.svg',
                  label: 'home',
                  isActive: _currentIndex == 0,
                  onTap: () => setState(() => _currentIndex = 0),
                ),
                _buildNavItemWithSvg(
                  svgPath: 'assets/icons/scenarios.svg',
                  label: 'scenarios',
                  isActive: _currentIndex == 1,
                  onTap: () => setState(() => _currentIndex = 1),
                ),
                _buildNavItemWithSvg(
                  svgPath: 'assets/icons/tutor.svg',
                  label: 'Padiman',
                  isActive: _currentIndex == 2,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PadimanScreen(),
                      ),
                    );
                  },
                ),
                _buildNavItemWithSvg(
                  svgPath: 'assets/icons/progress.svg',
                  label: 'progress',
                  isActive: _currentIndex == 3,
                  onTap: () => setState(() => _currentIndex = 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 1:
        return const ScenarioPage();
      case 3:
        return _buildProgressContent();
      default:
        return _buildHomeContent();
    }
  }

  Widget _buildHomeContent() {
    return SafeArea(
      child: Column(
        children: [
          // Custom Header
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
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Select a scenario to start your first lesson",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Suggested Section
                  const Text(
                    "SUGGESTED FOR YOU",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Horizontal Scrolling Cards
                  SizedBox(
                    height: 410,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.only(bottom: 8, top: 4),
                      children: [
                        _buildScenarioCard(
                          context,
                          width: 320,
                          imageUrl: 'assets/images/lapping-butre-1936882_640.jpg',
                          duration: '5 min',
                          title: 'Order a coffee',
                          description: 'Get a cup at your local\ncoffee shop.',
                          backgroundColor: const Color(0xFFD4E8E4),
                          buttonColor: const Color(0xFFB8D9D3),
                        ),
                        const SizedBox(width: 16),
                        _buildScenarioCard(
                          context,
                          width: 320,
                          imageUrl: 'assets/images/pexels-clothes-1839935_640.jpg',
                          duration: '7 min',
                          title: 'A day in the life',
                          description: 'Describe your typical daily\nroutine.',
                          backgroundColor: const Color(0xFFE8D9D0),
                          buttonColor: const Color(0xFFD9C4B5),
                        ),
                        const SizedBox(width: 16),
                        _buildScenarioCard(
                          context,
                          width: 320,
                          imageUrl: 'assets/images/helenjank-bags-6145811_640.jpg',
                          duration: '6 min',
                          title: 'At the market',
                          description: 'Buy fresh produce and\npractice bargaining.',
                          backgroundColor: const Color(0xFFE8E4D9),
                          buttonColor: const Color(0xFFD9D4C4),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Start your first chat card
                  GestureDetector(
                    onTap: () {
                      setState(() => _currentIndex = 1);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start your first chat",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Take one of our suggestions or tap here to pick from the full scenario library instead",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Custom Scenario Section
                  const Text(
                    "CUSTOM SCENARIO",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateScenarioScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF9E6),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: const Offset(4, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                "Create a scenario",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 24,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_forward, size: 24),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Use your imagination to create a scenario about whatever you want",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.black.withOpacity(0.7),
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Placeholder images
                          SizedBox(
                            height: 100,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/lapping-butre-1936882_640.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/pexels-clothes-1839935_640.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      image: const DecorationImage(
                                        image: AssetImage('assets/images/helenjank-bags-6145811_640.jpg'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Quick Chat Section
                  const Text(
                    "QUICK CHAT",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  GestureDetector(
                    onTap: () {
                      // Navigate to quick chat
                    },
                    child: Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black,
                            offset: const Offset(4, 4),
                            blurRadius: 0,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Image placeholder
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                image: AssetImage('assets/images/yourialka-marble-7728245_640.jpg'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Expanded(
                                      child: Text(
                                        "How's your day going?",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Icon(Icons.arrow_forward, size: 24),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Chat with Padiman about your day",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(0.7),
                                    height: 1.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 48),
                  
                  // Streak Section
                  const Text(
                    "TWI STREAK",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: const Offset(4, 4),
                          blurRadius: 0,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Streak Count & Message
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/icons/streak.svg',
                              height: 48,
                              width: 48,
                              colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 64,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(width: 24),
                            Expanded(
                              child: const Text(
                                "Do your first chat\nto start a streak!",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        
                        // Weekly Progress
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDayCircle('M', false),
                            _buildDayCircle('T', false),
                            _buildDayCircle('W', false),
                            _buildDayCircle('T', false),
                            _buildDayCircle('F', false),
                            _buildDayCircle('S', false),
                            _buildDayCircle('S', false),
                          ],
                        ),
                        const SizedBox(height: 32),
                        
                        // Reminder Toggle Card
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Want practice reminders?",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "Get a heads up tomorrow so you don't forget your streak",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black.withOpacity(0.6),
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Switch(
                                value: true,
                                onChanged: (value) {},
                                activeColor: Colors.black,
                                activeTrackColor: Colors.grey[300],
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildProgressContent() {
    return SafeArea(
      child: Column(
        children: [
          // Custom Header
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
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "You're on your way to conversational Twi.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    "Come back after a few chats to see your progress over time.",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 18,
                      color: Colors.black.withOpacity(0.7),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Badges Progress Section
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            const Text(
                              "0",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 84,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              " / 30",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 32,
                                fontWeight: FontWeight.w400,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "badges earned",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.3),
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  // Level Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE0E7FF),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "current level",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5D686F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "From Scratch",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F1F1),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: const Text(
                              "next level",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF5D686F),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            "Beginner",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),
                  
                  // Comprehension Summary Card
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.location_on, color: Color(0xFF6366F1)),
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          "0",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          " / 30",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.2),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          "Comprehension",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 64),
                  
                  // Detailed Metrics Section
                  Row(
                    children: [
                      const Icon(Icons.bar_chart, size: 18, color: Colors.black),
                      const SizedBox(width: 8),
                      Text(
                        "METRICS",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.4),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Here's how you're doing on your key metric:",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Detailed Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "COMPREHENSION",
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.black,
                              ),
                            ),
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: const Color(0xFFD7DFFF),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(Icons.location_on, color: Color(0xFF6C91FF)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "You're given a goal in every scenario to try to complete by the end of the chat.",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            color: Colors.black.withOpacity(0.7),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 32),
                        
                        // Progress visualization
                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE0E7FF).withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(10, (index) {
                              bool isActive = index == 0;
                              return Column(
                                children: [
                                  Container(
                                    width: 16,
                                    height: 16,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: isActive ? const Color(0xFF6C91FF) : Colors.black.withOpacity(0.05),
                                      border: isActive ? Border.all(color: Colors.black, width: 1.5) : null,
                                    ),
                                  ),
                                  if (isActive) 
                                    Container(
                                      height: 20,
                                      width: 1,
                                      color: Colors.black,
                                      margin: const EdgeInsets.only(top: 4),
                                    ),
                                ],
                              );
                            }),
                          ),
                        ),
                        
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 64),
                  
                  // Streak Section
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/icons/streak.svg',
                        height: 18,
                        colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "STREAK",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.4),
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "You're on a 0 day streak!",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Calendar Card
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Calendar Header with Nav
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${_monthNames[_selectedProgressMonth.month]} ${_selectedProgressMonth.year}",
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedProgressMonth = DateTime(
                                        _selectedProgressMonth.year,
                                        _selectedProgressMonth.month - 1,
                                      );
                                    });
                                  },
                                  icon: const Icon(Icons.chevron_left, color: Colors.black),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _selectedProgressMonth = DateTime(
                                        _selectedProgressMonth.year,
                                        _selectedProgressMonth.month + 1,
                                      );
                                    });
                                  },
                                  icon: const Icon(Icons.chevron_right, color: Colors.black),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildMonthCalendar(_selectedProgressMonth),
                      ],
                    ),
                  ),
                  const SizedBox(height: 64),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const List<String> _monthNames = [
    "", "January", "February", "March", "April", "May", "June",
    "July", "August", "September", "October", "November", "December"
  ];

  Widget _buildMonthCalendar(DateTime date) {
    final int daysInMonth = DateTime(date.year, date.month + 1, 0).day;
    final int startWeekday = DateTime(date.year, date.month, 1).weekday % 7; // 0=Sun, 1=Mon...

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: ['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) => Expanded(
            child: Center(
              child: Text(
                day,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.3),
                ),
              ),
            ),
          )).toList(),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: daysInMonth + startWeekday,
          itemBuilder: (context, index) {
            if (index < startWeekday) {
              return const SizedBox.shrink();
            }
            int dayNumber = index - startWeekday + 1;
            
            // Check if this cell is "today"
            final now = DateTime.now();
            bool isToday = dayNumber == now.day && 
                           date.month == now.month && 
                           date.year == now.year;
                           
            bool hasStreak = false; // Mocking streak

            return Container(
              decoration: BoxDecoration(
                color: isToday ? const Color(0xFF6C91FF) : (hasStreak ? const Color(0xFFFFD54F) : Colors.transparent),
                shape: BoxShape.circle,
                border: isToday ? Border.all(color: Colors.black, width: 1.5) : null,
              ),
              child: Center(
                child: Text(
                  dayNumber.toString(),
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: isToday || hasStreak ? FontWeight.bold : FontWeight.w400,
                    color: isToday ? Colors.white : (hasStreak ? Colors.black : Colors.black),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildNavItemWithSvg({
    required String svgPath,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 28,
            width: 28,
            colorFilter: const ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(
    BuildContext context, {
    required double width,
    required String imageUrl,
    required String duration,
    required String title,
    required String description,
    required Color backgroundColor,
    required Color buttonColor,
  }) {
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            offset: const Offset(4, 4),
            blurRadius: 0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image Section
          Stack(
            children: [
              Container(
                width: width,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.cover,
                    onError: (exception, stackTrace) {
                      // Fallback if image doesn't exist
                    },
                  ),
                ),
              ),
              // Duration Badge
              Positioned(
                top: 16,
                right: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB8D9D3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    duration,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ],
          ),
          
          // Content Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  maxLines: 2,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Colors.black87,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                
                // Start Button
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScenarioDetailScreen(
                            title: title,
                            description: description,
                            duration: duration,
                            imageUrl: 'assets/images/ronaldstilting-fisherman-5704299_1280.jpg',
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "start",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDayCircle(String day, bool completed) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: completed ? Colors.black : const Color(0xFFE0E0E0),
            shape: BoxShape.circle,
            border: Border.all(
              color: completed ? Colors.black : Colors.transparent,
              width: 2,
            ),
          ),
          child: completed
              ? const Icon(Icons.check, size: 20, color: Colors.white)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

class GaugePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFFFF7E6) // Very light orange/yellow
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2;

    // Draw the semi-circle arc
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      math.pi, // Start angle (left side)
      math.pi, // Sweep angle (180 degrees)
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
