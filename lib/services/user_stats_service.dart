// user_stats_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserStatsService {
  static UserStatsService? _instance;
  
  factory UserStatsService() => _instance ??= UserStatsService._();
  UserStatsService._();
  
  Future<SharedPreferences> get _prefs async => await SharedPreferences.getInstance();
  
  // ========== STREAK TRACKING ==========
  Future<void> updateLoginStreak() async {
    final prefs = await _prefs;
    final lastLogin = prefs.getString('last_login_date');
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    
    if (lastLogin == null) {
      // First login
      await prefs.setInt('current_streak', 1);
      await prefs.setString('last_login_date', today.toString());
      await prefs.setString('first_login_date', today.toString());
      return;
    }
    
    final lastDate = DateTime.parse(lastLogin);
    final difference = today.difference(lastDate).inDays;
    
    if (difference == 0) {
      // Already logged in today
      return;
    } else if (difference == 1) {
      // Consecutive day
      final currentStreak = prefs.getInt('current_streak') ?? 0;
      await prefs.setInt('current_streak', currentStreak + 1);
    } else {
      // Streak broken
      await prefs.setInt('current_streak', 1);
    }
    
    await prefs.setString('last_login_date', today.toString());
  }
  
  Future<int> getCurrentStreak() async {
    final prefs = await _prefs;
    await updateLoginStreak(); // Update streak first
    return prefs.getInt('current_streak') ?? 0;
  }
  
  Future<int> getLongestStreak() async {
    final prefs = await _prefs;
    return prefs.getInt('longest_streak') ?? 0;
  }
  
  // ========== ACHIEVEMENT METRICS ==========
  // Perfect score tracking
  Future<void> recordPerfectScore() async {
    final prefs = await _prefs;
    await prefs.setBool('has_perfect_score', true);
  }
  
  Future<bool> hasPerfectScore() async {
    final prefs = await _prefs;
    return prefs.getBool('has_perfect_score') ?? false;
  }
  
  // Fast completion tracking (first lesson in under 5 minutes)
  Future<void> recordFastCompletion() async {
    final prefs = await _prefs;
    await prefs.setBool('fast_completion', true);
  }
  
  Future<bool> hasFastCompletion() async {
    final prefs = await _prefs;
    return prefs.getBool('fast_completion') ?? false;
  }
  
  // Daily lessons tracking (for Speed Learner)
  Future<void> incrementDailyLessons() async {
    final prefs = await _prefs;
    final today = DateTime.now().toString().split(' ')[0]; // YYYY-MM-DD
    final key = 'daily_lessons_$today';
    final count = prefs.getInt(key) ?? 0;
    await prefs.setInt(key, count + 1);
  }
  
  Future<int> getTodayLessonCount() async {
    final prefs = await _prefs;
    final today = DateTime.now().toString().split(' ')[0];
    final key = 'daily_lessons_$today';
    return prefs.getInt(key) ?? 0;
  }
  
  // Social shares tracking
  Future<void> incrementShareCount() async {
    final prefs = await _prefs;
    final count = prefs.getInt('share_count') ?? 0;
    await prefs.setInt('share_count', count + 1);
  }
  
  Future<int> getShareCount() async {
    final prefs = await _prefs;
    return prefs.getInt('share_count') ?? 0;
  }
  
  // Correct answers tracking (for Quick Thinker)
  Future<void> incrementCorrectAnswers() async {
    final prefs = await _prefs;
    final count = prefs.getInt('correct_answers_count') ?? 0;
    await prefs.setInt('correct_answers_count', count + 1);
  }
  
  Future<int> getCorrectAnswersCount() async {
    final prefs = await _prefs;
    return prefs.getInt('correct_answers_count') ?? 0;
  }
  
  // ========== STATISTICS ==========
  Future<void> recordLessonCompletion(String courseTitle, String lessonTitle) async {
    final prefs = await _prefs;
    
    // Track lesson completion time
    final now = DateTime.now().toIso8601String();
    
    // Get current completions
    final completionsJson = prefs.getString('lesson_completions') ?? '[]';
    final completions = jsonDecode(completionsJson) as List;
    
    completions.add({
      'course': courseTitle,
      'lesson': lessonTitle,
      'timestamp': now,
      'date': DateTime.now().toString().split(' ')[0],
    });
    
    await prefs.setString('lesson_completions', jsonEncode(completions));
    
    // Update daily lesson count
    await incrementDailyLessons();
  }
  
  Future<List<Map<String, dynamic>>> getLessonCompletions() async {
    final prefs = await _prefs;
    final completionsJson = prefs.getString('lesson_completions') ?? '[]';
    final completions = jsonDecode(completionsJson) as List;
    return completions.cast<Map<String, dynamic>>();
  }
  
  // Clear all stats (for testing or account deletion)
  Future<void> clearAllStats() async {
    final prefs = await _prefs;
    await prefs.remove('last_login_date');
    await prefs.remove('current_streak');
    await prefs.remove('longest_streak');
    await prefs.remove('has_perfect_score');
    await prefs.remove('fast_completion');
    await prefs.remove('share_count');
    await prefs.remove('correct_answers_count');
    await prefs.remove('lesson_completions');
    
    // Remove all daily lesson keys
    final keys = prefs.getKeys();
    for (final key in keys) {
      if (key.startsWith('daily_lessons_')) {
        await prefs.remove(key);
      }
    }
  }
}