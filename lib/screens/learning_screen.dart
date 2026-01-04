import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/widgets/circular_indicator.dart';
import 'package:mobile_project/screens/course_info_screen.dart';
import 'package:mobile_project/models/data.dart';
import '../services/database_helper.dart';

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

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

  // Get total lessons for a course (from sample data)
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

    // Fallback to sections count if lessons not found
    final course = registeredCoursesWithProgress.firstWhere(
      (course) => course.title == courseTitle,
      orElse: () => registeredCoursesWithProgress.first,
    );

    return course.sections.length;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: registeredCoursesWithProgress.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,    // Reduced from 12
              crossAxisSpacing: 10,   // Reduced from 12
              childAspectRatio: 0.9,  // Slightly taller
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
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  margin: const EdgeInsets.all(0),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow:
                        isDark
                            ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ]
                            : [
                              BoxShadow(
                                color: const Color(
                                  0xFF1F1F39,
                                ).withOpacity(0.08),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                    border: Border.all(
                      color: theme.colorScheme.outline.withOpacity(
                        isDark ? 0.1 : 0.15,
                      ),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Course icon/title row
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color(0xFF3D5CFF).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              widget._getCourseIcon(sampleCourse.title),
                              color: const Color(0xFF3D5CFF),
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              sampleCourse.title,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: theme.colorScheme.onSurface,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // Description
                      Text(
                        sampleCourse.description,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(
                            isDark ? 0.7 : 0.6,
                          ),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 16),

                      // Progress bar or register button
                      if (isRegistered)
                        Column(
                          children: [
                            LinearProgressIndicator(
                              value: progress,
                              backgroundColor: theme.colorScheme.outline
                                  .withOpacity(0.2),
                              color: const Color(0xFF3D5CFF),
                              borderRadius: BorderRadius.circular(4),
                              minHeight: 6,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '$lessonsFinished/$totalLessons lessons',
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: theme.colorScheme.onSurface
                                        .withOpacity(0.6),
                                  ),
                                ),
                                Text(
                                  '${(progress * 100).toInt()}%',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
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
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                isDark
                                    ? const Color(0xFF18193C)
                                    : const Color(0xFFE6F2FF),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFF3D5CFF).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Start Learning',
                                style: GoogleFonts.poppins(
                                  fontSize: 13,
                                  color: const Color(0xFF3D5CFF),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Icon(
                                Icons.arrow_forward,
                                size: 14,
                                color: const Color(0xFF3D5CFF),
                              ),
                            ],
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
