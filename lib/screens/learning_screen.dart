import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/services/dataBase.dart';
import 'package:mobile_project/widgets/circularIndicator.dart';
import 'package:mobile_project/screens/course_info_screen.dart';
import 'package:mobile_project/models/data.dart' hide User;

class LearningScreen extends StatefulWidget {
  const LearningScreen({super.key});

  @override
  State<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends State<LearningScreen> {
  final userRepo = UserRepository();

  User? user;
  final courseRepo = CourseRepository();
  List<Map<String, dynamic>> registeredCourses = [];
  void _loadRegisteredCourses() async {
    if (user != null) {
      final courseRepo = CourseRepository();
      final lessonRepo = LessonRepository();

      // Fetch registered courses for the user
      List<Map<String, dynamic>> registeredCourses = await courseRepo
          .getUserCourses(user!.id!);

      // Fetch progress for each course
      for (var course in registeredCourses) {
        int finishedLessons = await lessonRepo.countFinishedLessons(
          user!.id!,
          course['id'],
        );
        int totalLessons =
            course['total_lessons']; // Ensure this is fetched in `getUserCourses`

        print(
          'Course: ${course['title']}, Finished: $finishedLessons, Total: $totalLessons',
        );
      }

      setState(() {}); // Update the UI if needed
    }
  }

  void _initializeUser() async {
    user = await userRepo.getUser(1);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initializeUser();
    _loadRegisteredCourses();
  }

  Widget build(BuildContext context) {
    final List<String> courses =
        sampleCourses.map((course) => course.title).toList();
    const double cardWidth = 160;
    const double cardHeight = 160;
    const Color cardColor = Color(0xFFCDEBFD);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: courses.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // exactly 2 per row
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1, // square cards
        ),
        itemBuilder: (context, index) {
          final course = courses[index];
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
                          (_) => CourseInfoScreen(course: sampleCourses[index]),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(
                        height: 100,
                        child: Center(
                          child: Text(
                            course,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0F0D28),
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: double.infinity,
                        child:
                            registeredCourses.any(
                                  (course) => course['id'] == index,
                                )
                                ? continueCourse(
                                  sampleUser
                                      .registeredCourses[index]
                                      .NumberOfFinished,
                                  sampleUser
                                      .registeredCourses[index]
                                      .lessons
                                      .length,
                                  context,
                                )
                                : viewCourse(),
                      ),
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
