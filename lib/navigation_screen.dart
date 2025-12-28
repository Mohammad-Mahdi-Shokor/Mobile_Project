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
  Widget currentScreen = LearningScreen();
  void switchScreen() {
    if (_selectedIndex == 0) {
      currentScreen = LearningScreen();
    } else {
      currentScreen = ProfileScreen();
    }
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
        buttonBackgroundColor: Color(0xFF1A1B3E),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        items: const <Widget>[
          Column(
            children: [
              Icon(Icons.school, size: 30, color: Color.fromARGB(255, 255, 255, 255)),
              Text(
                'Learning',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
              ),
            ],
          ),
          Column(
            children: [
              Icon(Icons.person, size: 30, color: Color.fromARGB(255, 255, 255, 255)),
              Text(
                'Profile',
                style: TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 12),
              ),
            ],
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
