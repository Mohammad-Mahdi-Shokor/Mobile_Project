import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import '../services/database_helper.dart';
import '../services/registered_course.dart';
import '../services/scores_repo.dart';
import 'test_screen.dart';
import '../services/user_stats_service.dart';

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
  List<int> courseScores = [];
  int courseIndex = 0;
  late List<bool> unlocked;
  late List<Lesson> lessons;
  final DatabaseService _dbService = DatabaseService();
  int? _databaseCourseId;
  int _completedLessons = 0;
  bool _isLoading = true;
  final UserStatsService _statsService = UserStatsService();

  Future<void> _loadScores() async {
    // Get the course index
    final int currentCourseIndex = registeredCoursesWithProgress.indexOf(
      widget.course,
    );
    courseIndex = currentCourseIndex; // Store in class variable

    // Initialize if needed
    await ScoresRepository.initializeScores(
      registeredCoursesWithProgress.length,
      lessons.length,
    );

    // Load scores for this course
    final courseScoresList = await ScoresRepository.getCourseScores(
      currentCourseIndex,
    );

    setState(() {
      // If no scores exist, initialize with zeros
      if (courseScoresList.isEmpty) {
        courseScores = List.filled(lessons.length, 0);
      } else {
        // Ensure the list matches lesson count
        if (courseScoresList.length < lessons.length) {
          courseScores = [
            ...courseScoresList,
            ...List.filled(lessons.length - courseScoresList.length, 0),
          ];
        } else {
          courseScores = courseScoresList;
        }
      }
    });

    // Debug: print scores
    await ScoresRepository.debugPrintScores();
  }

  @override
  void initState() {
    super.initState();
    _initializeScreen();
  }

  // Modified _initializeScreen to load scores after lessons are found
  Future<void> _initializeScreen() async {
    setState(() => _isLoading = true);

    // Get lessons
    if (widget.originalCourse != null) {
      lessons = _findCourseLessons(widget.originalCourse!.title);
    } else {
      lessons = _findCourseLessons(widget.course.title);
    }

    await _findDatabaseCourse();

    // DON'T initialize courseScores here - let _loadScores handle it
    // courseScores = List.generate(lessons.length, (_) => 0); // REMOVE THIS LINE

    // Now load scores
    await _loadScores();

    // FIX: Only unlock lessons that are truly completed
    // If _completedLessons = 1, that means lesson 0 is completed, lesson 1 should be unlocked but not completed
    unlocked = List.generate(lessons.length, (index) {
      // Lesson is unlocked if:
      // 1. It's the first lesson (always)
      // 2. The previous lesson is completed (index <= _completedLessons)
      return index == 0 || index <= _completedLessons;
    });

    setState(() => _isLoading = false);
  }

  // Add a method to reload scores when needed
  Future<void> _reloadScores() async {
    await _loadScores();
    setState(() {});
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
      print("Found ${allCourses.length} courses in database"); // Debug

      final databaseCourse = allCourses.firstWhere(
        (course) => course.title == widget.course.title,
        orElse: () {
          print(
            "Course not found in database: ${widget.course.title}",
          ); // Debug
          return Course(
            title: widget.course.title,
            courseIndex: 0,
            lessonsFinished: 0,
          );
        },
      );

      _databaseCourseId = databaseCourse.id;
      _completedLessons = databaseCourse.lessonsFinished;
      print(
        "Loaded from DB: courseId=$_databaseCourseId, completedLessons=$_completedLessons",
      ); // Debug
    } catch (e) {
      print('Error finding database course: $e');
      _completedLessons = 0;
    }
  }

  Future<void> startTest(int index) async {
    if (index >= lessons.length || !unlocked[index]) return;

    final lesson = lessons[index];

    // Track if this is the first lesson of the first registered course
    final isFirstLessonOfFirstCourse = index == 0 && _completedLessons == 0;

    // Start tracking time for fast completion (only track first lesson timing)
    DateTime? startTime;
    if (isFirstLessonOfFirstCourse) {
      startTime = DateTime.now();
      print("Starting timer for fast completion tracking");
    }

    final score = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder:
            (_) => TestScreen(
              section: lesson.title,
              questions: lesson.questions,
              courseId: _databaseCourseId ?? 0,
              totalLessons: lessons.length,
              onTestCompleted: () {},
            ),
      ),
    );

    if (score != null && mounted) {
      // Update score for this lesson - FIX: Use courseScores not scores
      final updatedScores = List<int>.from(
        courseScores,
      ); // CHANGED: courseScores not scores
      if (score > updatedScores[index]) {
        updatedScores[index] = score;
      }

      // CRITICAL FIX: Only unlock/save if score is passing
      final isPassingScore = score >= 70;
      final shouldUnlockNext = isPassingScore && index + 1 < lessons.length;

      setState(() {
        courseScores = updatedScores; // CHANGED: courseScores not scores

        if (shouldUnlockNext) {
          // Only unlock next lesson if passing score
          final updatedUnlocked = List<bool>.from(unlocked);
          updatedUnlocked[index + 1] = true;
          unlocked = updatedUnlocked;
        }
      });

      // Also save the score to ScoresRepository
      final currentCourseIndex = registeredCoursesWithProgress.indexOf(
        widget.course,
      );
      await ScoresRepository.addScore(currentCourseIndex, index, score);

      // CRITICAL FIX: Only save progress to database if passing
      if (isPassingScore) {
        // Calculate how many lessons are completed (all up to current index)
        final newCompletedCount = index + 1;

        // Only update if this increases progress
        if (newCompletedCount > _completedLessons) {
          _completedLessons = newCompletedCount;

          // ========== ACHIEVEMENT TRACKING ==========

          // 1. Track lesson completion
          await _statsService.recordLessonCompletion(
            widget.course.title,
            lesson.title,
          );

          // 2. Check for perfect score (100%)
          if (score == 100) {
            print("Perfect score recorded!");
            await _statsService.recordPerfectScore();
          }

          // 3. Track correct answers (for Quick Thinker achievement)
          if (score >= 70) {
            // Increment correct answers count - you need to know how many questions were correct
            // For simplicity, we'll increment by the number of questions in this lesson
            final correctCount =
                (lesson.questions.length * (score / 100)).round();
            for (int i = 0; i < correctCount; i++) {
              await _statsService.incrementCorrectAnswers();
            }
          }

          // 4. Check for fast starter (first lesson in under 5 minutes)
          if (isFirstLessonOfFirstCourse && startTime != null) {
            final completionTime =
                DateTime.now().difference(startTime).inMinutes;
            print("Lesson completed in $completionTime minutes");

            if (completionTime <= 5) {
              print("Fast starter achievement unlocked!");
              await _statsService.recordFastCompletion();
            }
          }

          // 5. Check if course is now fully completed (for Master Student)
          if (newCompletedCount >= lessons.length) {
            print("Course fully completed!");
            // This will be detected in the achievements calculation
          }

          // ========== UPDATE DATABASE ==========
          await _updateCourseProgress(_completedLessons);
        }
      } else {
        // Failed the test - show message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Score below 70%. Try again to unlock next lesson.'),
            backgroundColor: Colors.orange,
          ),
        );
      }
    }
  }

  // Update course progress in database
  Future<void> _updateCourseProgress(int completedLessons) async {
    try {
      if (_databaseCourseId != null) {
        final course = await _dbService.getCourseById(_databaseCourseId!);
        if (course != null) {
          final updatedCourse = Course(
            id: course.id,
            title: course.title,
            courseIndex: course.courseIndex,
            lessonsFinished: completedLessons,
          );
          await _dbService.updateCourse(updatedCourse);
        }
      } else {
        final newCourse = Course(
          title: widget.course.title,
          courseIndex: 0,
          lessonsFinished: completedLessons,
        );
        final newId = await _dbService.insertCourse(newCourse);
        _databaseCourseId = newId;
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Progress saved!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      print('Error updating progress: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      // REMOVE: || scores == null
      return Scaffold(
        appBar: AppBar(title: Text(widget.course.title)),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    final theme = Theme.of(context);
    final nodeSpacing = 120.0;
    final totalLessons = lessons.length;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course.title,
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF3D5CFF),
        foregroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$_completedLessons/$totalLessons',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          // Optional: Add refresh button for debugging
          if (kDebugMode)
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _reloadScores,
              tooltip: 'Refresh scores',
            ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: totalLessons * nodeSpacing + 30,
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(double.infinity, totalLessons * nodeSpacing),
                  painter: LessonPathPainter(
                    totalLessons,
                    unlocked: unlocked,
                    theme: theme,
                  ),
                ),
                for (int i = 0; i < totalLessons; i++)
                  Positioned(
                    top: i * nodeSpacing,
                    left:
                        i % 2 == 0
                            ? MediaQuery.of(context).size.width * 0.18
                            : MediaQuery.of(context).size.width * 0.62,
                    child: MouseRegion(
                      cursor:
                          unlocked[i]
                              ? SystemMouseCursors.click
                              : SystemMouseCursors.basic,
                      child: GestureDetector(
                        onTap: unlocked[i] ? () => startTest(i) : null,
                        child: CourseNode(
                          title: lessons[i].title,
                          index: i + 1,
                          locked: !unlocked[i],
                          percentage: courseScores[i],
                          isCompleted: i < _completedLessons,
                          theme: theme,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Updated CourseNode with better UI
class CourseNode extends StatefulWidget {
  final String title;
  final int index;
  final bool locked;
  final int percentage;
  final bool isCompleted;
  final ThemeData theme;

  const CourseNode({
    super.key,
    required this.title,
    required this.index,
    required this.locked,
    this.percentage = 0,
    this.isCompleted = false,
    required this.theme,
  });

  @override
  State<CourseNode> createState() => _CourseNodeState();
}

class _CourseNodeState extends State<CourseNode> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final nodeSize = 70.0;
    final isDark = widget.theme.brightness == Brightness.dark;

    // Determine node colors based on state
    Color nodeColor;
    Color borderColor;
    Color textColor = Colors.white;

    if (widget.locked) {
      nodeColor = isDark ? Colors.grey[800]! : Colors.grey[300]!;
      borderColor = isDark ? Colors.grey[600]! : Colors.grey[400]!;
      textColor = isDark ? Colors.grey[400]! : Colors.grey[600]!;
    } else if (widget.isCompleted) {
      nodeColor = const Color(0xFF4CAF50); // Green for completed
      borderColor = const Color(0xFF388E3C);
    } else if (hovering) {
      nodeColor = const Color(0xFF5C6BC0); // Hover state
      borderColor = const Color(0xFF3D5CFF);
    } else {
      nodeColor = const Color(0xFF3D5CFF); // Primary blue
      borderColor = const Color(0xFF1E40AF);
    }

    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          transform:
              Matrix4.identity()
                ..scale(hovering && !widget.locked ? 1.15 : 1.0),
          child: MouseRegion(
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Outer glow for unlocked nodes
                if (!widget.locked && hovering)
                  Container(
                    width: nodeSize + 12,
                    height: nodeSize + 12,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: nodeColor.withOpacity(0.2),
                    ),
                  ),

                // Main node
                Container(
                  width: nodeSize,
                  height: nodeSize,
                  decoration: BoxDecoration(
                    color: nodeColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: borderColor, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(
                          widget.locked ? 0.1 : 0.25,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child:
                        widget.locked
                            ? Icon(Icons.lock, color: textColor, size: 24)
                            : Text(
                              widget.index.toString(),
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ),
                ),

                // Completion checkmark
                if (widget.isCompleted && !widget.locked)
                  Positioned(
                    top: 2,
                    right: 2,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(color: Colors.green, width: 1.5),
                      ),
                      child: const Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.green,
                      ),
                    ),
                  ),

                // Score badge
                if (!widget.locked && widget.percentage > 0)
                  Positioned(
                    bottom: -4,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color:
                            widget.percentage < 50
                                ? Colors.red
                                : widget.percentage < 80
                                ? Colors.orange
                                : Colors.green,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Text(
                        '${widget.percentage}%',
                        style: GoogleFonts.poppins(
                          fontSize: 10,
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
        const SizedBox(height: 8),
        SizedBox(
          width: 100,
          child: Column(
            children: [
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color:
                      widget.locked
                          ? (isDark ? Colors.grey[500] : Colors.grey[600])
                          : (isDark ? Colors.white : Colors.black87),
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (widget.isCompleted && !widget.locked)
                const SizedBox(height: 2),
              if (widget.isCompleted && !widget.locked)
                Text(
                  'Completed',
                  style: GoogleFonts.poppins(
                    fontSize: 9,
                    color: Colors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

// Updated LessonPathPainter with better curves
class LessonPathPainter extends CustomPainter {
  final int nodeCount;
  final List<bool> unlocked;
  final ThemeData theme;

  LessonPathPainter(
    this.nodeCount, {
    required this.unlocked,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final spacing = size.height / nodeCount;
    final isDark = theme.brightness == Brightness.dark;

    for (int i = 0; i < nodeCount - 1; i++) {
      final isSegmentUnlocked = unlocked[i] && unlocked[i + 1];

      final paint =
          Paint()
            ..color =
                isSegmentUnlocked
                    ? const Color(0xFF3D5CFF).withOpacity(0.7)
                    : (isDark ? Colors.grey[700]! : Colors.grey[300]!)
            ..style = PaintingStyle.stroke
            ..strokeWidth = isSegmentUnlocked ? 3.5 : 2.5
            ..strokeCap = StrokeCap.round;

      // Calculate positions
      final startX =
          i % 2 == 0 ? size.width * 0.18 + 35 : size.width * 0.62 + 35;
      final startY = i * spacing + 35;

      final endX =
          (i + 1) % 2 == 0 ? size.width * 0.18 + 35 : size.width * 0.62 + 35;
      final endY = (i + 1) * spacing + 35;

      // Control points for smoother curve
      final controlX1 = startX + (endX - startX) * 0.5;
      final controlY1 = startY + spacing * 0.3;
      final controlX2 = startX + (endX - startX) * 0.5;
      final controlY2 = startY + spacing * 0.7;

      // Draw curved path
      final path = Path();
      path.moveTo(startX, startY);
      path.cubicTo(controlX1, controlY1, controlX2, controlY2, endX, endY);

      canvas.drawPath(path, paint);

      // Add arrowhead for direction
      if (isSegmentUnlocked) {
        final arrowPaint =
            Paint()
              ..color = const Color(0xFF3D5CFF)
              ..style = PaintingStyle.fill;

        // Calculate arrow position at 70% of the path
        final t = 0.7;
        final arrowX = _cubicBezier(startX, controlX1, controlX2, endX, t);
        final arrowY = _cubicBezier(startY, controlY1, controlY2, endY, t);

        // Calculate tangent for arrow direction
        final dx = _cubicBezierDerivative(
          startX,
          controlX1,
          controlX2,
          endX,
          t,
        );
        final dy = _cubicBezierDerivative(
          startY,
          controlY1,
          controlY2,
          endY,
          t,
        );
        final angle = atan2(dy, dx);

        // Draw arrow
        canvas.save();
        canvas.translate(arrowX, arrowY);
        canvas.rotate(angle);

        final arrowPath = Path();
        arrowPath.moveTo(0, 0);
        arrowPath.lineTo(-8, -5);
        arrowPath.lineTo(-8, 5);
        arrowPath.close();

        canvas.drawPath(arrowPath, arrowPaint);
        canvas.restore();
      }
    }
  }

  // Cubic Bézier calculation
  double _cubicBezier(double a, double b, double c, double d, double t) {
    return pow(1 - t, 3) * a +
        3 * pow(1 - t, 2) * t * b +
        3 * (1 - t) * pow(t, 2) * c +
        pow(t, 3) * d;
  }

  // Cubic Bézier derivative
  double _cubicBezierDerivative(
    double a,
    double b,
    double c,
    double d,
    double t,
  ) {
    return 3 * pow(1 - t, 2) * (b - a) +
        6 * (1 - t) * t * (c - b) +
        3 * pow(t, 2) * (d - c);
  }

  @override
  bool shouldRepaint(covariant LessonPathPainter oldDelegate) {
    return oldDelegate.unlocked != unlocked || oldDelegate.theme != theme;
  }
}
