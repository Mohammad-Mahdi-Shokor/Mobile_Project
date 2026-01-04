import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/widgets/circular_indicator.dart';
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
    const double cardWidth = 160;
    const double cardHeight = 160;
    const Color cardColor = Color(0xFFCDEBFD);

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            itemCount: registeredCoursesWithProgress.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final sampleCourse = registeredCoursesWithProgress[index];
              final isRegistered = _isCourseRegistered(sampleCourse.title);

              return Center(
                child: SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (_) => CourseInfoScreen(course: sampleCourse),
                        ),
                      ).then((_) {
                        // Refresh data when returning
                        _loadRegisteredCourses();
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Course Title
                          SizedBox(
                            height: 80,
                            child: Center(
                              child: Text(
                                sampleCourse.title,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF0F0D28),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          // Bottom Section - View Course or Progress
                          isRegistered
                              ? continueCourse(sampleCourse.title, context)
                              : viewCourse(),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
  }

  Row viewCourse() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Color(0xFF0F0D28),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'View Course',
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    );
  }

  Widget continueCourse(String courseTitle, BuildContext context) {
    // Get actual progress for this course
    final lessonsFinished = _getLessonsFinished(courseTitle);
    final totalLessons = _getTotalLessons(courseTitle);

    return Row(
      children: [
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: lessonsFinished / totalLessons),
          duration: const Duration(milliseconds: 800),
          builder: (context, value, _) {
            return SizedBox(
              width: 30,
              height: 30,
              child: CircularPercentage(percentage: value),
            );
          },
        ),
        const Spacer(),
        Text(
          "$lessonsFinished ",
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F0D28),
          ),
        ),
        Text(
          "/ $totalLessons",
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Color(0xFF0F0D28),
          ),
        ),
      ],
    );
  }
}
