import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              child: Container(
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Text(
                        course,
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF0F0D28),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF1F1F39),
                        ),
                        onPressed: () {},
                        child: Text(
                          'View Course',
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
