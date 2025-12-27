import 'package:curved_navigation_bar/curved_navigation_bar.dart'
    show CurvedNavigationBar;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:mobile_project/profile_screen.dart';
import 'package:mobile_project/screenAppBar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'learning_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  Widget currentScreen = LearningScreen();
  void SwitchScreen() {
    if (_selectedIndex == 0) {
      currentScreen = LearningScreen();
    } else {
      currentScreen = ProfileScreen();
    }
  }

  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w600,
  );
  static const List<Widget> _widgetOptions = <Widget>[
    Text('My Learning', style: optionStyle),
    Text('Profile', style: optionStyle),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1F1F39),
      appBar: ScreenAppBar(_selectedIndex),
      body: currentScreen,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60.0,
        backgroundColor: Colors.transparent,
        color: const Color(0xFF3D5CFF),
        buttonBackgroundColor: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        items: const <Widget>[
          Icon(Icons.school, size: 30, color: Colors.black),
          Icon(Icons.person, size: 30, color: Colors.black),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            SwitchScreen();
          });
        },
      ),
    );
  }
}
