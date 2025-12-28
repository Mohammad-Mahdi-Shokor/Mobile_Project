import 'package:curved_navigation_bar/curved_navigation_bar.dart'
    show CurvedNavigationBar;
import 'package:flutter/material.dart';
import 'package:mobile_project/profile_screen.dart';
import 'package:mobile_project/screenAppBar.dart';
import 'learning_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  Widget currentScreen = const LearningScreen();

  void switchScreen() {
    if (_selectedIndex == 0) {
      currentScreen = const LearningScreen();
    } else {
      currentScreen = const ProfileScreen();
    }
  }

  Widget _navItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: isSelected ? 0 : 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: Colors.white),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: ScreenAppBar(_selectedIndex),
      body: currentScreen,
      // hayde el navigator bar yale ta7et ( we modify color later)
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF161632),
        buttonBackgroundColor: const Color(0xFF18193C),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        items: [
          _navItem(
            icon: Icons.school,
            label: 'Learning',
            isSelected: _selectedIndex == 0,
          ),
          _navItem(
            icon: Icons.person,
            label: 'Profile',
            isSelected: _selectedIndex == 1,
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            switchScreen();
          });
        },
      ),
    );
  }
}
