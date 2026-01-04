import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import '../services/database_helper.dart';
import '../services/registered_course.dart';
import 'test_screen.dart';

class LessonPathScreen extends StatefulWidget {
  final RegisteredCourse course;
  final RegisteredCourse? originalCourse;

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
  final DatabaseService _dbService = DatabaseService();
  int? _databaseCourseId;
  int _completedLessons = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  Future<void> _initializeScreen() async {
    setState(() => _isLoading = true);

    // Get lessons from original course if available
    if (widget.originalCourse != null) {
      lessons = _findCourseLessons(widget.originalCourse!.title);
    } else {
      lessons = _findCourseLessons(widget.course.title);
    }

    // Try to find the course in database by title
    await _findDatabaseCourse();

    // Initialize scores and unlocked
    scores = List.generate(lessons.length, (_) => 0);

    // Unlock based on number of finished lessons
    unlocked = List.generate(
      lessons.length,
      (index) => index < _completedLessons,
    );

    // Always unlock first lesson
    if (unlocked.isNotEmpty && lessons.isNotEmpty) {
      unlocked[0] = true;
    }

    setState(() => _isLoading = false);
  }

  // Helper method to find lessons
  List<Lesson> _findCourseLessons(String courseTitle) {
    try {
      final courseIndex = registeredCoursesWithProgress.indexWhere(
        (course) => course.title == courseTitle,
      );

      if (courseIndex >= 0 && courseIndex < allCourseLessons.length) {
        return allCourseLessons[courseIndex];
      }
    } catch (e) {
      print('Error finding course lessons: $e');
    }

    // Create placeholder lessons from sections
    return widget.course.sections.map((section) {
      return Lesson(
        title: section,
        done: false,
        questions: [
          Question(
            question: "What is $section?",
            answers: [
              Answer(answer: "Correct Answer"),
              Answer(answer: "Wrong Answer 1"),
              Answer(answer: "Wrong Answer 2"),
              Answer(answer: "Wrong Answer 3"),
            ],
          ),
        ],
      );
    }).toList();
  }

  // Find course in database by title
  Future<void> _findDatabaseCourse() async {
    try {
      final allCourses = await _dbService.getCourses();
      final databaseCourse = allCourses.firstWhere(
        (course) => course.title == widget.course.title,
        orElse:
            () => Course(
              title: widget.course.title,
              courseIndex: 0,
              lessonsFinished: 0,
            ),
      );

      _databaseCourseId = databaseCourse.id;
      _completedLessons = databaseCourse.lessonsFinished;
    } catch (e) {
      print('Error finding database course: $e');
      _completedLessons = 0;
    }
  }

  Future<void> startTest(int index) async {
    if (index >= lessons.length || !unlocked[index]) return;

    final lesson = lessons[index];
    final score = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder:
            (_) => TestScreen(
              section: lesson.title,
              questions: lesson.questions,
              courseId: _databaseCourseId ?? 0,
              totalLessons: lessons.length,
              onTestCompleted: () {
                // Optional callback
              },
            ),
      ),
    );

    if (score != null) {
      // Update the score for this lesson
      final updatedScores = List<int>.from(scores);
      if (score > updatedScores[index]) {
        updatedScores[index] = score;
      }

      // Determine if we should unlock next lesson
      final shouldUnlockNext = score >= 70 && index + 1 < lessons.length;

      // Update completed lessons count
      final newCompletedCount =
          shouldUnlockNext
              ? index +
                  2 // +2 because index is 0-based and we want to unlock next
              : _completedLessons;

      setState(() {
        scores = updatedScores;

        if (shouldUnlockNext) {
          final updatedUnlocked = List<bool>.from(unlocked);
          updatedUnlocked[index + 1] = true;
          unlocked = updatedUnlocked;
          _completedLessons = newCompletedCount;
        }
      });

      // Update progress in database
      if (shouldUnlockNext) {
        await _updateCourseProgress(newCompletedCount);
      }
    }
  }

  // Update course progress in database
  Future<void> _updateCourseProgress(int completedLessons) async {
    try {
      if (_databaseCourseId != null) {
        // Get the current course from database
        final course = await _dbService.getCourseById(_databaseCourseId!);
        if (course != null) {
          // Update lessons finished
          final updatedCourse = Course(
            id: course.id,
            title: course.title,
            courseIndex: course.courseIndex,
            lessonsFinished: completedLessons,
          );

          await _dbService.updateCourse(updatedCourse);
        } else {
          // Course not found in database, insert new one
          final newCourse = Course(
            title: widget.course.title,
            courseIndex: 0,
            lessonsFinished: completedLessons,
          );

          final newId = await _dbService.insertCourse(newCourse);
          _databaseCourseId = newId;
        }
      } else {
        // No database course yet, create one
        final newCourse = Course(
          title: widget.course.title,
          courseIndex: 0,
          lessonsFinished: completedLessons,
        );

        final newId = await _dbService.insertCourse(newCourse);
        _databaseCourseId = newId;
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Progress saved!'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error updating progress: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error saving progress: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.course.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final nodeSpacing = 140.0;
    final totalLessons = lessons.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          // Show progress
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '$_completedLessons/$totalLessons',
                style: const TextStyle(
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
          height: totalLessons * nodeSpacing,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(double.infinity, totalLessons * nodeSpacing),
                painter: LessonPathPainter(totalLessons, unlocked: unlocked),
              ),
              for (int i = 0; i < totalLessons; i++)
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
                        isCompleted: i < _completedLessons,
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

// CourseNode Widget (unchanged from your code)
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
      primaryColor = Theme.of(context).primaryColor;
    }

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform:
              hovering
                  ? (Matrix4.identity()
                    ..scale(1.1, 1.1, 1.0)
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.green,
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 16,
                        color: Colors.white,
                      ),
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

// LessonPathPainter (unchanged from your code)
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
