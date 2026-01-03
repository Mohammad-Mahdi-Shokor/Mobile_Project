import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/widgets/circularIndicator.dart';
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

  @override
  void initState() {
    super.initState();
    _loadRegisteredCourses();
  }

  Future<void> _loadRegisteredCourses() async {
    setState(() => _isLoading = true);
    try {
      final courses = await _databaseService.getCourses();
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
                              ? continueCourse(
                                0,
                                allCourseLessons[index].length,
                                context,
                              )
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

  Positioned continueCourse(int done, int total, BuildContext context) {
    return Positioned(
      right: 8,
      left: 8,
      bottom: 8,
      child: Row(
        children: [
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: done / total),
            duration: const Duration(milliseconds: 800),
            builder: (context, value, _) {
              return CircularPercentage(percentage: value);
            },
          ),

          Spacer(),
          Text(
            "$done ",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F0D28),
            ),
          ),
          Text(
            "/ $total",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Color(0xFF0F0D28),
            ),
          ),
        ],
      ),
    );
  }
}
