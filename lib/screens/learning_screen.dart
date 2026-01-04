import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/screens/course_info_screen.dart';
import 'package:mobile_project/models/data.dart';
import '../services/database_helper.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  List<Course> _registeredCourses = [];
  bool _isLoading = true;
  final DatabaseService _databaseService = DatabaseService();
  final Map<String, int> _courseProgress = {};

  @override
  void initState() {
    super.initState();
    _loadRegisteredCourses();
  }

  Future<void> _loadRegisteredCourses() async {
    setState(() => _isLoading = true);
    try {
      final courses = await _databaseService.getCourses();
      for (var course in courses) {
        _courseProgress[course.title] = course.lessonsFinished;
      }
      setState(() {
        _registeredCourses = courses;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      print("Error loading registered courses: $e");
    }
  }

  bool _isCourseRegistered(String courseTitle) {
    return _registeredCourses.any((course) => course.title == courseTitle);
  }

  int _getLessonsFinished(String courseTitle) {
    return _courseProgress[courseTitle] ?? 0;
  }

  int _getTotalLessons(String courseTitle) {
    try {
      final courseIndex = registeredCoursesWithProgress.indexWhere(
        (course) => course.title == courseTitle,
      );

      if (courseIndex >= 0 && courseIndex < allCourseLessons.length) {
        return allCourseLessons[courseIndex].length;
      }
    } catch (e) {
      print("Error getting total lessons: $e");
    }

    final course = registeredCoursesWithProgress.firstWhere(
      (course) => course.title == courseTitle,
      orElse: () => registeredCoursesWithProgress.first,
    );

    return course.sections.length;
  }

  IconData _getCourseIcon(String courseTitle) {
    switch (courseTitle.toLowerCase()) {
      case 'cybersecurity':
        return Icons.security;
      case 'mobile development':
        return Icons.phone_android;
      case 'physics':
        return Icons.science;
      case 'philosophy':
        return Icons.psychology;
      default:
        return Icons.school;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;

    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 8,
          ),
          child: GridView.builder(
            itemCount: registeredCoursesWithProgress.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: screenWidth * 0.03,
              crossAxisSpacing: screenWidth * 0.03,
              childAspectRatio: 0.9, // Slightly taller for single line text
            ),
            itemBuilder: (context, index) {
              final isDark = theme.brightness == Brightness.dark;
              final sampleCourse = registeredCoursesWithProgress[index];
              final isRegistered = _isCourseRegistered(sampleCourse.title);
              final lessonsFinished = _getLessonsFinished(sampleCourse.title);
              final totalLessons = _getTotalLessons(sampleCourse.title);
              final progress =
                  totalLessons > 0 ? lessonsFinished / totalLessons : 0.0;

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CourseInfoScreen(course: sampleCourse),
                    ),
                  ).then((_) => _loadRegisteredCourses());
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(
                        isDark ? 0.1 : 0.15,
                      ),
                      width: 1,
                    ),
                    boxShadow:
                        isDark
                            ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ]
                            : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Course icon and title - single line
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(screenWidth * 0.025),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D5CFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(
                              _getCourseIcon(sampleCourse.title),
                              color: const Color(0xFF3D5CFF),
                              size: screenWidth * 0.05,
                            ),
                          ),
                          SizedBox(width: screenWidth * 0.02),
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                sampleCourse.title,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                      // Progress or Start button
                      if (isRegistered)
                        Column(
                          children: [
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: theme.colorScheme.outline
                                  .withOpacity(0.2),
                              color: const Color(0xFF3D5CFF),
                              borderRadius: BorderRadius.circular(4),
                              minHeight: screenWidth * 0.01,
                            ),
                            SizedBox(height: screenWidth * 0.015),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$lessonsFinished/$totalLessons',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.032,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: screenWidth * 0.032,
                                    fontWeight: FontWeight.w600,
                                    color: const Color(0xFF3D5CFF),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      else
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.03,
                            vertical: screenWidth * 0.02,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? const Color(0xFF18193C)
                                    : const Color(0xFFE6F2FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: const Color(0xFF3D5CFF).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Start',
                              style: GoogleFonts.poppins(
                                fontSize: screenWidth * 0.038,
                                color: const Color(0xFF3D5CFF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
  }
}
