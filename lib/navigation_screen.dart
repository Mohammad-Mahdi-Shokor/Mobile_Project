import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_project/profile_screen.dart';
import 'package:mobile_project/screenAppBar.dart';
import 'learning_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;
  Widget currentScreen = const LearningScreen();
  bool coursesExpanded = false;
  final List<String> courses = const [
    'Philosophy',
    'Physics',
    'Cybersecurity',
    'Mobile',
    'Agile',
  ];

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
      drawer:
          _selectedIndex == 0
              ? Drawer(
                backgroundColor: const Color(0xFF1F1F39),

                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          'Menu',
                          style: GoogleFonts.poppins(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.book, color: Colors.white),
                        title: Text(
                          'Courses',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        trailing: Icon(
                          coursesExpanded
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        onTap: () {
                          setState(() {
                            coursesExpanded = !coursesExpanded;
                          });
                        },
                      ),
                      if (coursesExpanded)
                        ...courses.map(
                          (course) => Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: ListTile(
                              leading: const Icon(
                                Icons.circle,
                                color: Colors.white,
                              ),
                              title: Text(
                                course,
                                style: GoogleFonts.poppins(color: Colors.white),
                              ),
                              onTap: () {},
                            ),
                          ),
                        ),
                      ListTile(
                        leading: const Icon(Icons.chat, color: Colors.white),
                        title: Text(
                          'Chats',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.group, color: Colors.white),
                        title: Text(
                          'Groups',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      ListTile(
                        leading: const Icon(Icons.public, color: Colors.white),
                        title: Text(
                          'Communities',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                      const Spacer(),
                      ListTile(
                        leading: const Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                        title: Text(
                          'Settings',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              )
              : null,
      body: currentScreen,
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
