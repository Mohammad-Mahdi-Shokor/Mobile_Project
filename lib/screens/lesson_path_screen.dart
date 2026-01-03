import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/services/registered_course.dart';
import '../services/database_helper.dart';
import 'test_screen.dart';

class LessonPathScreen extends StatefulWidget {
  final RegisteredCourse course;
  final RegisteredCourse?
  originalCourse; // Add this to get lessons from original course

  const LessonPathScreen({
    super.key,
    required this.course,
    this.originalCourse,
  });

  @override
  State<LessonPathScreen> createState() => _LessonPathScreenState();
}

class _LessonPathScreenState extends State<LessonPathScreen> {
  late List<int> scores;
  late List<bool> unlocked;
  late List<Lesson> lessons;

  @override
  void initState() {
    super.initState();

    // Get lessons from original course if available
    if (widget.originalCourse != null) {
      lessons =
          allCourseLessons[registeredCoursesWithProgress.indexOf(
            widget.originalCourse!,
          )];
    } else {
      // Find the course from sampleCourses
      lessons = _findCourseLessons(widget.course.title);
    }

    // Initialize scores and unlocked
    scores = List.generate(lessons.length, (_) => 0);

    // Unlock based on number of finished lessons
    unlocked = List.generate(
      lessons.length,
      (index) => index < widget.course.numberOfFinishedLessons,
    );

    // Always unlock first lesson
    if (unlocked.isNotEmpty) {
      unlocked[0] = true;
    }
  }

  // Helper method to find lessons from sampleCourses
  List<Lesson> _findCourseLessons(String courseTitle) {
    try {
      final course = registeredCoursesWithProgress.firstWhere(
        (course) => course.title == courseTitle,
      );
      return allCourseLessons[registeredCoursesWithProgress.indexOf(course)];
    } catch (e) {
      print('Error finding course lessons: $e');

      // Create placeholder lessons from sections
      return widget.course.sections.map((section) {
        return Lesson(
          title: section,
          done: false,
          questions: [
            Question(
              question: "What is $section?",
              answers: [
                Answer(answer: "Answer 1"),
                Answer(answer: "Answer 2"),
                Answer(answer: "Answer 3"),
              ],
            ),
          ],
        );
      }).toList();
    }
  }

  void startTest(int index) async {
    if (index >= lessons.length) return;

    final lesson = lessons[index];
    final score = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) =>
                TestScreen(section: lesson.title, questions: lesson.questions),
      ),
    );

    if (score != null && score is int) {
      setState(() {
        if (score > scores[index]) scores[index] = score;

        // Unlock next lesson if score is good enough
        if (index + 1 < unlocked.length && score >= 50) {
          unlocked[index + 1] = true;

          // Update course progress in database
          _updateCourseProgress(index + 1);
        }
      });
    } else {
      debugPrint('Score is null or not an integer');
    }
  }

  // Update course progress in database
  Future<void> _updateCourseProgress(int completedLessons) async {
    try {
      // Create updated course
      final updatedCourse = RegisteredCourse(
        id: widget.course.id,
        title: widget.course.title,
        description: widget.course.description,
        numberOfFinishedLessons: completedLessons,
        totalLessons: lessons.length,
        about: widget.course.about,
        imageUrl: widget.course.imageUrl,
        sections: widget.course.sections,
      );

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Progress saved!'),
          duration: Duration(seconds: 1),
        ),
      );
    } catch (e) {
      print('Error updating progress: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final nodeSpacing = 140.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: Colors.blue,
        actions: [
          // Show progress
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${widget.course.numberOfFinishedLessons}/${lessons.length}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: lessons.length * nodeSpacing,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(double.infinity, lessons.length * nodeSpacing),
                painter: LessonPathPainter(lessons.length, unlocked: unlocked),
              ),
              for (int i = 0; i < lessons.length; i++)
                Positioned(
                  top: i * nodeSpacing,
                  left:
                      i % 2 == 0
                          ? MediaQuery.of(context).size.width * 0.15
                          : MediaQuery.of(context).size.width * 0.55,
                  child: MouseRegion(
                    cursor:
                        unlocked[i]
                            ? SystemMouseCursors.click
                            : SystemMouseCursors.forbidden,
                    child: GestureDetector(
                      onTap: unlocked[i] ? () => startTest(i) : null,
                      child: CourseNode(
                        title: lessons[i].title,
                        index: i + 1,
                        locked: !unlocked[i],
                        percentage: scores[i],
                        isCompleted: i < widget.course.numberOfFinishedLessons,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Updated CourseNode with proper logic
class CourseNode extends StatefulWidget {
  final String title;
  final int index;
  final bool locked;
  final int percentage;
  final bool isCompleted;

  const CourseNode({
    super.key,
    required this.title,
    required this.index,
    required this.locked,
    this.percentage = 0,
    this.isCompleted = false,
  });

  @override
  State<CourseNode> createState() => _CourseNodeState();
}

class _CourseNodeState extends State<CourseNode> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final nodeSize = 80.0;

    // Determine node color
    Color primaryColor;
    if (widget.locked) {
      primaryColor = Colors.grey;
    } else if (widget.isCompleted) {
      primaryColor = Colors.green;
    } else {
      primaryColor = Colors.blue;
    }

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              hovering
                  ? (Matrix4.identity()
                    ..scale(1.1)
                    ..rotateX(-0.2))
                  : (Matrix4.identity()..rotateX(-0.2)),
          child: MouseRegion(
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, primaryColor.withOpacity(0.8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 6,
                        offset: const Offset(3, 3),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        widget.locked
                            ? const Icon(
                              Icons.lock,
                              color: Colors.white,
                              size: 30,
                            )
                            : Text(
                              widget.index.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),
                // Show checkmark if completed
                if (widget.isCompleted && !widget.locked)
                  Positioned(
                    top: 4,
                    left: 4,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: Icon(Icons.check, size: 16, color: Colors.white),
                    ),
                  ),
                // Show percentage if test taken
                if (!widget.locked && widget.percentage > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color:
                            widget.percentage < 50
                                ? Colors.red.withOpacity(0.8)
                                : widget.percentage < 80
                                ? Colors.yellow.withOpacity(0.8)
                                : Colors.green.withOpacity(0.8),
                      ),
                      child: Text(
                        '${widget.percentage}%',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 120,
          child: Column(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.isCompleted)
                Text(
                  'Completed',
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.green),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// LessonPathPainter remains the same
class LessonPathPainter extends CustomPainter {
  final int nodeCount;
  final List<bool> unlocked;

  LessonPathPainter(this.nodeCount, {required this.unlocked});

  @override
  void paint(Canvas canvas, Size size) {
    final spacing = size.height / nodeCount;

    for (int i = 0; i < nodeCount - 1; i++) {
      final isSegmentUnlocked = unlocked[i] && unlocked[i + 1];
      final paint =
          Paint()
            ..color =
                isSegmentUnlocked ? Colors.blue.shade200 : Colors.grey.shade400
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4;

      final startX =
          i % 2 == 0 ? size.width * 0.15 + 40 : size.width * 0.55 + 40;
      final startY = i * spacing + 40;

      final endX =
          (i + 1) % 2 == 0 ? size.width * 0.15 + 40 : size.width * 0.55 + 40;
      final endY = (i + 1) * spacing + 40;

      final controlX = size.width / 2;
      final controlY = startY + spacing / 2;

      final path = Path();
      path.moveTo(startX, startY);
      path.quadraticBezierTo(controlX, controlY, endX, endY);

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant LessonPathPainter oldDelegate) {
    return oldDelegate.unlocked != unlocked;
  }
}
