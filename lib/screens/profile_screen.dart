import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/screens/achievements_screen.dart';
import 'package:mobile_project/services/user_stats_service.dart';

import '../services/user_preferences_services.dart';
import '../services/database_helper.dart';
import 'package:share_plus/share_plus.dart';

class ProfileScreen extends StatefulWidget {
  final VoidCallback? onProfileUpdated;

  const ProfileScreen({super.key, this.onProfileUpdated});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserPreferencesService _userService = UserPreferencesService.instance;
  final DatabaseService _dbService = DatabaseService();
  final UserStatsService _statsService = UserStatsService();
  User? _currentUser;
  bool _isLoading = true;
  List<Achievement> _achievements = [];
  Map<String, bool> get achievementCompletionMap {
    return {for (var a in _achievements) a.name: a.isCompleted};
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final statsService = UserStatsService();
      await statsService.updateLoginStreak();
    });
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    _currentUser = await _userService.getUser();
    _achievements = await _calculateAchievementsProgress();
    setState(() => _isLoading = false);
  }

  Future<List<Achievement>> _calculateAchievementsProgress() async {
    final achievements = List<Achievement>.from(sampleAchievements);
    final courses = await _dbService.getCourses();

    // Calculate total lessons completed
    int totalLessonsCompleted = 0;
    for (var course in courses) {
      totalLessonsCompleted += course.lessonsFinished;
    }

    // Calculate registered courses count
    int registeredCoursesCount = courses.length;

    // Update achievements based on actual progress
    for (int i = 0; i < achievements.length; i++) {
      final achievement = achievements[i];
      double newProgress = 0;

      switch (achievement.name) {
        case "First Step":
          newProgress = totalLessonsCompleted >= 1 ? 1 : 0;
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
        case "Completionist":
          newProgress =
              registeredCoursesCount >= 4
                  ? 4
                  : registeredCoursesCount.toDouble();
          break;
        // Add more conditions as needed
        default:
          newProgress = achievement.progress;
      }

      achievements[i] = achievement.copyWith(
        progress: newProgress,
        isUnlocked: newProgress >= achievement.target,
      );
    }

    return achievements;
  }

  void refresh() {
    _loadUserData();
  }

  Future<void> _shareProgress() async {
    try {
      // Get user's progress data
      final courses = await _dbService.getCourses();
      int totalLessonsCompleted = 0;
      int totalCourses = courses.length;

      for (var course in courses) {
        totalLessonsCompleted += course.lessonsFinished;
      }

      // Calculate completed achievements
      final achievements = await _calculateAchievementsProgress();
      final completedAchievements =
          achievements.where((a) => a.isCompleted).length;
      final totalAchievements = achievements.length;

      // Create share message
      final shareText = '''
🎯 My Learning Progress 📚

👤 User: ${_currentUser?.username ?? 'Student'}
📊 Courses: $totalCourses registered
✅ Lessons: $totalLessonsCompleted completed
🏆 Achievements: $completedAchievements/$totalAchievements unlocked

Keep learning with me! 💪

#LearningApp #Progress #AchievementUnlocked
''';

      // Share the progress
      await Share.share(shareText, subject: 'My Learning Progress');

      // Track the share for Social Learner achievement
      await _statsService.incrementShareCount();

      // Show success message
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Progress shared successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error sharing: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Map<String, bool> getAchievementCompletionMap() {
    return {
      for (var achievement in _achievements)
        achievement.name: achievement.isCompleted,
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final displayUser = _currentUser ?? sampleUser;
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final isDark = theme.brightness == Brightness.dark;
    final isSmallScreen = screenWidth < 360;

    return Container(
      constraints: BoxConstraints(minHeight: screenHeight),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 16,
          ),
          child: Column(
            children: [
              // Profile avatar with border
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                        isDark
                            ? const Color.fromRGBO(217, 217, 217, 100)
                            : const Color(0xFF3D5CFF),
                    width: 3,
                  ),
                ),
                child: CircleAvatar(
                  radius:
                      isSmallScreen ? screenWidth * 0.18 : screenWidth * 0.15,
                  backgroundImage:
                      displayUser.profilePicture.startsWith('http')
                          ? NetworkImage(displayUser.profilePicture)
                          : FileImage(File(displayUser.profilePicture))
                              as ImageProvider,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Username
              Text(
                displayUser.username,
                style: GoogleFonts.poppins(
                  fontSize:
                      isSmallScreen ? screenWidth * 0.065 : screenWidth * 0.06,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: screenHeight * 0.008),

              // Tag/Profession
              Text(
                displayUser.tag,
                style: GoogleFonts.spaceGrotesk(
                  fontSize: screenWidth * 0.05,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.008),

              // Age and Gender
              Text(
                "${displayUser.age}, ${displayUser.Gender}",
                style: GoogleFonts.poppins(
                  fontSize:
                      isSmallScreen ? screenWidth * 0.037 : screenWidth * 0.039,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Achievements section with View All button
              Container(
                padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Achievements',
                          style: GoogleFonts.poppins(
                            fontSize: isSmallScreen ? 18 : 20,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AchievementsScreen(),
                              ),
                            ).then((_) => _loadUserData());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D5CFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'View All',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color(0xFF3D5CFF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 14,
                                  color: Color(0xFF3D5CFF),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Achievements Grid
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          _achievements.length > 6 ? 6 : _achievements.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final achievement = _achievements[index];
                        final isCompleted =
                            achievementCompletionMap[achievement.name] ?? false;

                        return _buildAchievementPreview(
                          achievement: achievement,
                          isCompleted: isCompleted,
                          context: context,
                          isSmallScreen: isSmallScreen,
                        );
                      },
                    ),

                    if (_achievements.length > 6)
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: Text(
                            '+ ${_achievements.length - 6} more achievements',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.6,
                              ),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.03),
              SizedBox(height: screenHeight * 0.02),
              Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _shareProgress,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3D5CFF),
                    padding: EdgeInsets.symmetric(
                      vertical: screenHeight * 0.015,
                      horizontal: screenWidth * 0.05,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: Icon(
                    Icons.share,
                    color: Colors.white,
                    size:
                        isSmallScreen
                            ? screenWidth * 0.05
                            : screenWidth * 0.045,
                  ),
                  label: Text(
                    'Share My Progress',
                    style: GoogleFonts.poppins(
                      fontSize:
                          isSmallScreen
                              ? screenWidth * 0.04
                              : screenWidth * 0.038,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementPreview({
    required Achievement achievement,
    required bool isCompleted,
    required BuildContext context,
    required bool isSmallScreen,
  }) {
    final theme = Theme.of(context);

    return Tooltip(
      message: achievement.description,
      child: Container(
        padding: EdgeInsets.all(isSmallScreen ? 8 : 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              isCompleted
                  ? achievement.color.withOpacity(0.15)
                  : theme.colorScheme.surfaceVariant.withOpacity(0.5),
          border: Border.all(
            color:
                isCompleted
                    ? achievement.color.withOpacity(0.3)
                    : theme.colorScheme.outline.withOpacity(0.2),
            width: isCompleted ? 1.5 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        isCompleted
                            ? achievement.color.withOpacity(0.2)
                            : Colors.grey.withOpacity(0.2),
                  ),
                  child: Icon(
                    achievement.icon,
                    size: isSmallScreen ? 20 : 24,
                    color: isCompleted ? achievement.color : Colors.grey,
                  ),
                ),
                if (isCompleted)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 8),

            FittedBox(
              child: Text(
                achievement.name,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: isSmallScreen ? 10 : 12,
                  fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

            // if (isCompleted)
            //   Padding(
            //     padding: const EdgeInsets.only(top: 4),
            //     child: Text(
            //       'Completed',
            //       style: GoogleFonts.poppins(
            //         fontSize: 9,
            //         color: Colors.green,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
