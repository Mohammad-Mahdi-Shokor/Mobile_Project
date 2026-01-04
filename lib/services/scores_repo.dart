import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ScoresRepository {
  static const String _key = 'scores';

  // Initialize scores for all registered courses
  static Future<void> initializeScores(
    int courseCount,
    int lessonsPerCourse,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_key);

    if (encodedData == null) {
      // Create initial scores structure with zeros
      final List<List<int>> initialScores = List.generate(
        courseCount,
        (_) => List.filled(lessonsPerCourse, 0),
      );
      await saveScores(initialScores);
    }
  }

  // Save the entire scores list
  static Future<void> saveScores(List<List<int>> scores) async {
    final prefs = await SharedPreferences.getInstance();
    final String encodedData = jsonEncode(scores);
    await prefs.setString(_key, encodedData);
  }

  // Get the entire scores list
  static Future<List<List<int>>?> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    final String? encodedData = prefs.getString(_key);

    if (encodedData == null) return null;

    try {
      final List<dynamic> decodedData = jsonDecode(encodedData);
      final List<List<int>> scores =
          decodedData.map<List<int>>((innerList) {
            return (innerList as List<dynamic>).map<int>((item) {
              return item is int ? item : (item as num).toInt();
            }).toList();
          }).toList();

      return scores;
    } catch (e) {
      print('Error decoding scores: $e');
      return null;
    }
  }

  // ========== MAIN METHODS FOR SPECIFIC COURSE/LESSON ==========

  // Add or update score for a specific course and lesson
  static Future<void> addScore(
    int courseIndex,
    int lessonIndex,
    int score,
  ) async {
    return _updateScore(courseIndex, lessonIndex, score);
  }

  // Update score for specific course and lesson (alias for addScore)
  static Future<void> updateScore(
    int courseIndex,
    int lessonIndex,
    int newScore,
  ) async {
    return _updateScore(courseIndex, lessonIndex, newScore);
  }

  // Change score for specific course and lesson (same as update)
  static Future<void> changeScore(
    int courseIndex,
    int lessonIndex,
    int newScore,
  ) async {
    return _updateScore(courseIndex, lessonIndex, newScore);
  }

  // Internal method to update score
  static Future<void> _updateScore(
    int courseIndex,
    int lessonIndex,
    int score,
  ) async {
    final List<List<int>>? currentScores = await getScores();

    if (currentScores == null) {
      // Initialize with empty structure
      final newScores = List.generate(
        courseIndex + 1,
        (_) => List.filled(lessonIndex + 1, 0),
      );
      newScores[courseIndex][lessonIndex] = score;
      await saveScores(newScores);
      print(
        'Created new scores structure and set score at [$courseIndex][$lessonIndex] to $score',
      );
    } else {
      // Create a mutable copy
      final List<List<int>> updatedScores = List.from(currentScores);

      // Ensure course index exists
      while (updatedScores.length <= courseIndex) {
        updatedScores.add([]);
      }

      // Ensure lesson index exists in the course
      while (updatedScores[courseIndex].length <= lessonIndex) {
        updatedScores[courseIndex].add(0);
      }

      // Update the score
      updatedScores[courseIndex][lessonIndex] = score;
      await saveScores(updatedScores);
      print('Updated score at [$courseIndex][$lessonIndex] to $score');
    }
  }

  // Get score for specific course and lesson
  static Future<int?> getScore(int courseIndex, int lessonIndex) async {
    final List<List<int>>? allScores = await getScores();

    if (allScores == null ||
        courseIndex >= allScores.length ||
        lessonIndex >= allScores[courseIndex].length) {
      return null;
    }

    return allScores[courseIndex][lessonIndex];
  }

  // Get scores for a specific course
  static Future<List<int>> getCourseScores(int courseIndex) async {
    final List<List<int>>? allScores = await getScores();

    if (allScores == null || courseIndex >= allScores.length) {
      return [];
    }

    return List<int>.from(allScores[courseIndex]);
  }

  // Get all courses scores
  static Future<List<List<int>>> getAllCoursesScores() async {
    final scores = await getScores();
    return scores ?? [];
  }

  // Reset score for specific course and lesson to 0
  static Future<void> resetScore(int courseIndex, int lessonIndex) async {
    await _updateScore(courseIndex, lessonIndex, 0);
  }

  // Delete score for specific course and lesson (sets to 0)
  static Future<void> deleteScore(int courseIndex, int lessonIndex) async {
    await resetScore(courseIndex, lessonIndex);
  }

  // Clear all scores
  static Future<void> clearScores() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    print('Cleared all scores');
  }

  // ========== HELPER METHODS ==========

  // Get the highest score for a specific course
  static Future<int> getHighestScoreForCourse(int courseIndex) async {
    final scores = await getCourseScores(courseIndex);
    return scores.isNotEmpty ? scores.reduce((a, b) => a > b ? a : b) : 0;
  }

  // Get average score for a specific course
  static Future<double> getAverageScoreForCourse(int courseIndex) async {
    final scores = await getCourseScores(courseIndex);
    if (scores.isEmpty) return 0.0;

    final sum = scores.reduce((a, b) => a + b);
    return sum / scores.length;
  }

  // Check if a specific lesson is completed (score >= passing threshold)
  static Future<bool> isLessonCompleted(
    int courseIndex,
    int lessonIndex, {
    int passingScore = 70,
  }) async {
    final score = await getScore(courseIndex, lessonIndex);
    return score != null && score >= passingScore;
  }

  // Get completed lessons count for a specific course
  static Future<int> getCompletedLessonsCount(
    int courseIndex, {
    int passingScore = 70,
  }) async {
    final scores = await getCourseScores(courseIndex);
    return scores.where((score) => score >= passingScore).length;
  }

  // Debug method to print all scores
  static Future<void> debugPrintScores() async {
    final scores = await getScores();
    if (scores == null) {
      print('No scores stored');
      return;
    }

    print('=== SCORES DEBUG ===');
    for (int i = 0; i < scores.length; i++) {
      print('Course $i: ${scores[i]}');
    }
    print('===================');
  }
}
