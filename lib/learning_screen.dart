import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  final List<Map<String, dynamic>> courses = const [
    {'name': 'Philosophy', 'color': Color(0xFFE57373)},
    {'name': 'Physics', 'color': Color(0xFF64B5F6)},
    {'name': 'Cybersecurity', 'color': Color(0xFF81C784)},
    {'name': 'Mobile', 'color': Color(0xFFFFB74D)},
    {'name': 'Agile', 'color': Color(0xFFBA68C8)},
  ];

  @override
  Widget build(BuildContext context) {
    // Set the width and height for each card
    const double cardWidth = 160;
    const double cardHeight = 160;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: courses.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: cardWidth,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: cardWidth / cardHeight,
        ),
        itemBuilder: (context, index) {
          final course = courses[index];
          return Container(
            decoration: BoxDecoration(
              color: course['color'],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Center(
                  child: Text(
                    course['name'],
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                    ),
                    onPressed: () {},
                    child: Text(
                      'View Course',
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
