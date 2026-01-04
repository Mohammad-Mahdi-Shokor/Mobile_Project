import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/screens/profile_screen.dart';
import 'package:mobile_project/services/registered_course.dart';
import 'package:mobile_project/widgets/screen_app_bar.dart';
import 'package:mobile_project/screens/settings_screen.dart';
import 'screens/course_info_screen.dart';
import 'screens/learning_screen.dart';
import 'services/user_preferences_services.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key, required this.onToggleTheme});
  final void Function() onToggleTheme;
  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  bool coursesExpanded = false;
  final List<RegisteredCourse> courses = registeredCoursesWithProgress;
  late List<RegisteredCourse> registeredCourses = [];
  late Widget currentScreen;

  @override
  void initState() {
    super.initState();
    currentScreen = LearningScreen();
    _loadUserData();
  }

  void switchScreen() {
    if (_selectedIndex == 0) {
      currentScreen = LearningScreen();
    } else {
      currentScreen = ProfileScreen(
        key: UniqueKey(), // Add a unique key to force rebuild
      );
      // Refresh user data when ProfileScreen is shown
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _loadUserData();
        }
      });
    }
  }

  List<String> MenuItems = ["Chats", "Groups", "Communities"];
  Widget _navItem({
    required IconData icon,
    required String label,
    required bool isSelected,
  }) {
    return Padding(
      padding: EdgeInsets.only(
        top: isSelected ? 5 : 10,
        bottom: isSelected ? 10 : 0,
      ),
      child: Center(
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
      ),
    );
  }

  Drawer _buildDrawer() {
    final theme = Theme.of(context);
    return Drawer(
      backgroundColor: theme.drawerTheme.backgroundColor,
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
                  color: theme.textTheme.bodyLarge!.color!,
                ),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.book,
                color: theme.textTheme.bodyLarge!.color!,
              ),
              title: Text(
                'Courses',
                style: GoogleFonts.poppins(
                  color: theme.textTheme.bodyLarge!.color!,
                ),
              ),
              trailing: Icon(
                coursesExpanded
                    ? Icons.keyboard_arrow_up
                    : Icons.keyboard_arrow_down,
                color: theme.textTheme.bodyLarge!.color!,
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
                  padding: const EdgeInsets.only(left: 40),
                  child: ListTile(
                    leading: Icon(
                      Icons.circle,
                      size: 10,
                      color: theme.textTheme.bodyLarge!.color!,
                    ),
                    title: Text(
                      course.title,
                      style: GoogleFonts.poppins(
                        color: theme.textTheme.bodyLarge!.color!,
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) {
                            return CourseInfoScreen(course: course);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ...MenuItems.map((item) {
              return ListTile(
                leading: Icon(
                  Icons.chat,
                  color: theme.textTheme.bodyLarge!.color!,
                ),
                title: Text(
                  item,
                  style: GoogleFonts.poppins(
                    color: theme.textTheme.bodyLarge!.color!,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              );
            }),
            const Spacer(),
            ListTile(
              leading: Icon(
                Icons.settings,
                color: theme.textTheme.bodyLarge!.color!,
              ),
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(
                  color: theme.textTheme.bodyLarge!.color!,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  final UserPreferencesService _userService = UserPreferencesService.instance;
  User? _currentUser;
  bool _isLoading = true;

  Future<void> _loadUserData() async {
    if (!mounted) return;

    setState(() => _isLoading = true);
    try {
      _currentUser = await _userService.getUser();
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      appBar: ScreenAppBar(context, _selectedIndex, widget.onToggleTheme),
      drawer: _selectedIndex == 0 ? _buildDrawer() : null,
      body: currentScreen,
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedIndex,
        height: 60,
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

          // Force refresh when tapping Profile tab
          if (index == 1) {
            Future.delayed(const Duration(milliseconds: 200), () {
              if (mounted) {
                _loadUserData();
              }
            });
          }
        },
      ),
    );
  }
}
