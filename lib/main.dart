import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile_project/navigation_screen.dart';
import 'package:mobile_project/widgets/theme.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'screens/registerScreen.dart';
import 'services/database_helper.dart';
import 'services/user_preferences_services.dart';

void main() async {
  // Initialize sqflite for desktop platforms
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  final UserPreferencesService _userService = UserPreferencesService.instance;
  bool _isChecking = true;
  bool _hasUser = false;
  bool _isFirstLaunch = true;

  @override
  void initState() {
    super.initState();
    _checkUserStatus();
    _loadThemePreference();
  }

  Future<void> _checkUserStatus() async {
    _hasUser = await _userService.hasUser();
    _isFirstLaunch = await _userService.isFirstLaunch();

    setState(() => _isChecking = false);
  }

  Future<void> _loadThemePreference() async {
    final isDarkMode = await _userService.getThemePreference();
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void toggleTheme() async {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });

    // Save theme preference
    await _userService.saveThemePreference(_themeMode == ThemeMode.dark);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: _themeMode,
      home: _buildHomeScreen(),
      routes: {
        '/home': (context) => NavigationScreen(onToggleTheme: toggleTheme),
      },
    );
  }

  Widget _buildHomeScreen() {
    if (_isChecking) {
      return const SplashScreen();
    }

    // If no user exists or it's first launch, show registration screen
    if (!_hasUser || _isFirstLaunch) {
      return const UserProfileScreen(isEditing: false);
    }

    // User exists, go to main navigation screen
    return NavigationScreen(onToggleTheme: toggleTheme);
  }
}

// Add a simple splash screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo or icon
            Icon(Icons.school, size: 80, color: Theme.of(context).primaryColor),
            const SizedBox(height: 20),
            // App name
            Text(
              'Learning App',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Loading indicator
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
