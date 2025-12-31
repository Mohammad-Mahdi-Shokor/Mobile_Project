import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/circularIndicator.dart';
import 'package:mobile_project/course_info_screen.dart';
import 'package:mobile_project/data.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
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
                      Container(
                        width: double.infinity,
                        child:
                            sampleUser.registedCoursesIndexes.contains(index)
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
