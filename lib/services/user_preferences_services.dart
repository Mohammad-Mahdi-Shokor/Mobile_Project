// services/user_preferences_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/data.dart';
import '../models/user.dart';

class UserPreferencesService {
  // Singleton pattern
  UserPreferencesService._privateConstructor();
  static final UserPreferencesService instance =
      UserPreferencesService._privateConstructor();

  static const String _userKey = 'user_data';
  static const String _isFirstLaunchKey = 'is_first_launch';
  static const String _themeKey = 'theme_preference';

  // Save user data
  Future<bool> saveUser(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Convert user to map then to JSON
      final userMap = user.toMap();

      // Add the complex fields that aren't in basic toMap()
      userMap['achievementsScores'] = jsonEncode(user.achievementsScores);
      userMap['registedCoursesIndexes'] = jsonEncode(
        user.registedCoursesIndexes,
      );

      // Convert to JSON string
      final userJson = jsonEncode(userMap);

      return await prefs.setString(_userKey, userJson);
    } catch (e) {
      print('Error saving user: $e');
      return false;
    }
  }

  // Get user data
  Future<User?> getUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);

      if (userJson == null || userJson.isEmpty) {
        return null;
      }

      final userMap = jsonDecode(userJson) as Map<String, dynamic>;

      return User(
        username: userMap['username'] ?? '',
        FirstName: userMap['firstName'] ?? '',
        tag: userMap['tag'] ?? '',
        age: userMap['age'] ?? 0,
        Gender: userMap['gender'] ?? '',
        profilePicture: userMap['profilePicture'] ?? '',
        achievementsScores:
            userMap['achievementsScores'] != null
                ? (jsonDecode(userMap['achievementsScores']) as List)
                    .map((e) => (e as num).toDouble())
                    .toList()
                : [],
        registeredCourses: [], // Will be loaded separately from database
        registedCoursesIndexes:
            userMap['registedCoursesIndexes'] != null
                ? (jsonDecode(userMap['registedCoursesIndexes']) as List)
                    .map((e) => (e as num).toInt())
                    .toList()
                : [],
      );
    } catch (e) {
      print('Error loading user: $e');
      return null;
    }
  }

  // Check if it's first launch
  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isFirstLaunchKey) ?? true;
  }

  // Mark first launch as completed
  Future<void> setFirstLaunchCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isFirstLaunchKey, false);
  }

  // Check if user exists
  Future<bool> hasUser() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  // Delete user data
  Future<bool> deleteUser() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.remove(_userKey);
  }

  // Update specific user fields
  Future<bool> updateUser({
    String? username,
    String? firstName,
    String? tag,
    int? age,
    String? gender,
    String? profilePicture,
    List<double>? achievementsScores,
    List<int>? registedCoursesIndexes,
  }) async {
    try {
      // Get current user
      final currentUser = await getUser();
      if (currentUser == null) return false;

      // Create updated user
      final updatedUser = currentUser.copyWith(
        username: username,
        FirstName: firstName,
        tag: tag,
        age: age,
        Gender: gender,
        profilePicture: profilePicture,
        achievementsScores: achievementsScores,
        registedCoursesIndexes: registedCoursesIndexes,
      );

      // Save updated user
      return await saveUser(updatedUser);
    } catch (e) {
      print('Error updating user: $e');
      return false;
    }
  }

  // Save theme preference
  Future<void> saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, isDarkMode);
  }

  // Get theme preference
  Future<bool> getThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_themeKey) ?? false; // Default to light mode
  }

  // Clear all user data
  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
