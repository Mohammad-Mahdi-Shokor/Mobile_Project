import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/services/user_stats_service.dart';
import 'package:share_plus/share_plus.dart';
import '../models/achievements.dart';
import '../models/user.dart';
import '../services/user_preferences_services.dart';
import '../services/database_helper.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final UserPreferencesService _userService = UserPreferencesService.instance;
  final DatabaseService _dbService = DatabaseService();
  List<Achievement> _achievements = [];
  User? currentUser;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => _isLoading = true);

    currentUser = await _userService.getUser();
    final courses = await _dbService.getCourses();

    _achievements = await _calculateAchievementsProgress(courses);

    setState(() => _isLoading = false);
  }

  Future<List<Achievement>> _calculateAchievementsProgress(
    List<Course> courses,
  ) async {
    final achievements = List<Achievement>.from(Achievements);
    final statsService = UserStatsService();

    final totalLessonsCompleted = courses.fold(
      0,
      (sum, course) => sum + course.lessonsFinished,
    );
    final registeredCoursesCount = courses.length;
    final hasPerfectScore = await statsService.hasPerfectScore();
    final currentStreak = await statsService.getCurrentStreak();
    final todayLessonCount = await statsService.getTodayLessonCount();
    final shareCount = await statsService.getShareCount();
    final correctAnswersCount = await statsService.getCorrectAnswersCount();
    final hasFastCompletion = await statsService.hasFastCompletion();

    bool hasMasteredCourse = courses.any((course) {
      try {
        final courseIndex = CoursesInfo.indexWhere(
          (c) => c.title == course.title,
        );
        if (courseIndex >= 0 && courseIndex < Lessons.length) {
          final totalLessonsInCourse = Lessons[courseIndex].length;
          return course.lessonsFinished >= totalLessonsInCourse;
        }
      } catch (e) {
        print("Error checking course completion: $e");
      }
      return false;
    });

    for (int i = 0; i < achievements.length; i++) {
      final achievement = achievements[i];
      double newProgress = 0;

      switch (achievement.name) {
        case "First Step":
          newProgress = totalLessonsCompleted >= 1 ? 1 : 0;
          break;

        case "Completionist":
          newProgress =
              registeredCoursesCount >= CoursesInfo.length
                  ? CoursesInfo.length.toDouble()
                  : registeredCoursesCount.toDouble();
          break;

        case "Perfect Score":
          newProgress = hasPerfectScore ? 1 : 0;
          break;

        case "3-Day Streak":
          newProgress = currentStreak >= 3 ? 3 : currentStreak.toDouble();
          break;

        case "Speed Learner":
          newProgress = todayLessonCount >= 5 ? 5 : todayLessonCount.toDouble();
          break;

        case "Consistent":
          newProgress =
              totalLessonsCompleted >= 10
                  ? 10
                  : totalLessonsCompleted.toDouble();
          break;

        case "Course Explorer":
          newProgress =
              registeredCoursesCount >= 3
                  ? 3
                  : registeredCoursesCount.toDouble();
          break;

        case "Master Student":
          newProgress = hasMasteredCourse ? 1 : 0;
          break;

        case "Social Learner":
          newProgress = shareCount >= 5 ? 5 : shareCount.toDouble();
          break;

        case "Quick Thinker":
          newProgress =
              correctAnswersCount >= 20 ? 20 : correctAnswersCount.toDouble();
          break;

        case "Fast Starter":
          newProgress = hasFastCompletion ? 1 : 0;
          break;

        case "Perfect Week":
          newProgress = currentStreak >= 7 ? 7 : currentStreak.toDouble();
          break;

        default:
          newProgress = achievement.progress;
      }

      achievements[i] = achievement.copyWith(progress: newProgress);
    }

    return achievements;
  }

  Widget _buildAchievementCard(Achievement achievement) {
    final theme = Theme.of(context);
    final isCompleted = achievement.isCompleted;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              isCompleted
                  ? achievement.color.withOpacity(0.5)
                  : Colors.transparent,
          width: 2,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient:
              isCompleted
                  ? LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      achievement.color.withOpacity(0.1),
                      achievement.color.withOpacity(0.05),
                    ],
                  )
                  : null,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color:
                          isCompleted
                              ? achievement.color.withOpacity(0.2)
                              : achievement.color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      achievement.icon,
                      color:
                          isCompleted
                              ? achievement.color
                              : achievement.color.withOpacity(0.7),
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          achievement.name,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          achievement.type.name.toUpperCase(),
                          style: GoogleFonts.poppins(
                            fontSize: 11,
                            color: achievement.color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (isCompleted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.check, size: 20, color: Colors.green),
                    ),
                ],
              ),

              const SizedBox(height: 12),

              Text(
                achievement.description,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),

              const SizedBox(height: 16),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Progress',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      Text(
                        '${achievement.progress.toInt()}/${achievement.target.toInt()}',
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: achievement.percentage,
                    backgroundColor: theme.colorScheme.outline.withOpacity(0.2),
                    color: achievement.color,
                    borderRadius: BorderRadius.circular(4),
                    minHeight: 8,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${(achievement.percentage * 100).toInt()}% complete',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatsCard() {
    final theme = Theme.of(context);
    final completedCount = _achievements.where((a) => a.isCompleted).length;
    final totalCount = _achievements.length;
    final completionPercentage =
        totalCount > 0 ? (completedCount / totalCount * 100).toInt() : 0;

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'Achievement Stats',
              style: GoogleFonts.poppins(
                fontSize: 26,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem(
                  value: completedCount.toString(),
                  label: 'Completed',
                  icon: Icons.check_circle,
                  color: Colors.green,
                ),
                VerticalDivider(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                  thickness: 1,
                  width: 20,
                ),
                _buildStatItem(
                  value: (totalCount - completedCount).toString(),
                  label: 'In Progress',
                  icon: Icons.timelapse,
                  color: Colors.orange,
                ),
                VerticalDivider(
                  color: theme.colorScheme.outline.withOpacity(0.2),
                  thickness: 1,
                  width: 20,
                ),
                _buildStatItem(
                  value: '$completionPercentage%',
                  label: 'Overall',
                  icon: Icons.percent,
                  color: Colors.blue,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey[600]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Achievements',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF3D5CFF),
        foregroundColor: Colors.white,
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                onRefresh: _loadData,
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    _buildStatsCard(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Achievements',
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF3D5CFF).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_achievements.where((a) => a.isCompleted).length}/${_achievements.length}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF3D5CFF),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    ..._achievements.map((achievement) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _buildAchievementCard(achievement),
                      );
                    }),
                  ],
                ),
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final statsService = UserStatsService();
          await statsService.getShareCount();

          final shareText = '''
🏆 My Achievements Progress 🏆

✅ Completed: ${_achievements.where((a) => a.isCompleted).length}/${_achievements.length} achievements

🎯 Top Achievements:
${_achievements.where((a) => a.isCompleted).take(3).map((a) => '• ${a.name}').join('\n')}

Keep pushing for greatness! 💪

#Achievements #LearningGoals #Progress
''';

          await Share.share(shareText);
          await statsService.incrementShareCount();
        },
        icon: const Icon(Icons.share),
        label: const Text('Share'),
        backgroundColor: const Color(0xFF3D5CFF),
      ),
    );
  }
}
