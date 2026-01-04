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
              SizedBox(height: screenHeight * 0.01),

              // Tag/Profession
              Text(
                displayUser.tag,
                style: GoogleFonts.poppins(
                  fontSize:
                      isSmallScreen ? screenWidth * 0.04 : screenWidth * 0.045,
                  color: theme.colorScheme.onSurface.withOpacity(0.8),
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.005),

              // Age and Gender
              Text(
                "${displayUser.age}, ${displayUser.Gender}",
                style: GoogleFonts.poppins(
                  fontSize:
                      isSmallScreen ? screenWidth * 0.032 : screenWidth * 0.035,
                  color: theme.colorScheme.onSurface.withOpacity(0.6),
                ),
              ),
              SizedBox(height: screenHeight * 0.03),

              // Achievements section with View All button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Achievements',
                    style: GoogleFonts.poppins(
                      fontSize:
                          isSmallScreen
                              ? screenWidth * 0.055
                              : screenWidth * 0.05,
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AchievementsScreen(),
                        ),
                      ).then((_) {
                        // Refresh achievements when returning
                        _loadUserData();
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          'View All',
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF3D5CFF),
                            fontWeight: FontWeight.w600,
                            fontSize:
                                isSmallScreen
                                    ? screenWidth * 0.032
                                    : screenWidth * 0.035,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.01),
                        Icon(
                          Icons.arrow_forward_ios,
                          size:
                              isSmallScreen
                                  ? screenWidth * 0.032
                                  : screenWidth * 0.035,
                          color: const Color(0xFF3D5CFF),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.015),

              // Achievements preview grid (first 6 achievements)
              Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  maxHeight: screenHeight * 0.3,
                  minHeight: screenHeight * 0.25,
                ),
                padding: EdgeInsets.all(screenWidth * 0.03),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: theme.colorScheme.surface,
                  border: Border.all(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:
                      _achievements.length > 6 ? 6 : _achievements.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: screenWidth * 0.02,
                    crossAxisSpacing: screenWidth * 0.02,
                    childAspectRatio: 0.9,
                  ),
                  itemBuilder: (context, index) {
                    final Achievement a = _achievements[index];
                    final isCompleted = a.isCompleted;

                    return Tooltip(
                      message: a.description,
                      child: Container(
                        padding: EdgeInsets.all(screenWidth * 0.025),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color:
                              isCompleted
                                  ? a.color.withOpacity(0.2)
                                  : isDark
                                  ? theme.colorScheme.secondary.withOpacity(0.2)
                                  : theme.colorScheme.secondary.withOpacity(
                                    0.3,
                                  ),
                          border: Border.all(
                            color:
                                isCompleted
                                    ? a.color.withOpacity(0.5)
                                    : theme.colorScheme.outline.withOpacity(
                                      0.3,
                                    ),
                            width: isCompleted ? 2 : 1,
                          ),
                          boxShadow:
                              isCompleted
                                  ? [
                                    BoxShadow(
                                      color: a.color.withOpacity(0.3),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                  : null,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  a.icon,
                                  size:
                                      isSmallScreen
                                          ? screenWidth * 0.07
                                          : screenWidth * 0.06,
                                  color:
                                      isCompleted
                                          ? a.color
                                          : theme.colorScheme.primary,
                                ),
                                if (isCompleted)
                                  Positioned(
                                    top: 0,
                                    right: 0,
                                    child: Container(
                                      padding: EdgeInsets.all(
                                        screenWidth * 0.008,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        size: screenWidth * 0.025,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            SizedBox(height: screenHeight * 0.008),
                            Expanded(
                              child: Text(
                                a.name,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize:
                                      isSmallScreen
                                          ? screenWidth * 0.028
                                          : screenWidth * 0.025,
                                  color: theme.colorScheme.onSurface,
                                  fontWeight:
                                      isCompleted
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (isCompleted)
                              Padding(
                                padding: EdgeInsets.only(
                                  top: screenHeight * 0.004,
                                ),
                                child: Text(
                                  '${(a.percentage * 100).toInt()}%',
                                  style: GoogleFonts.poppins(
                                    fontSize:
                                        isSmallScreen
                                            ? screenWidth * 0.022
                                            : screenWidth * 0.02,
                                    color: Colors.green,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Show "View More" text if there are more than 6 achievements
              if (_achievements.length > 6)
                Padding(
                  padding: EdgeInsets.only(top: screenHeight * 0.012),
                  child: Text(
                    '+ ${_achievements.length - 6} more achievements',
                    style: GoogleFonts.poppins(
                      fontSize:
                          isSmallScreen
                              ? screenWidth * 0.032
                              : screenWidth * 0.03,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      fontStyle: FontStyle.italic,
                    ),
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
}
