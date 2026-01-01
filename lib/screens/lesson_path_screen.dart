import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'test_screen.dart';

class LessonPathScreen extends StatefulWidget {
  final Course course;

  const LessonPathScreen({super.key, required this.course});

  @override
  State<LessonPathScreen> createState() => _LessonPathScreenState();
}

class _LessonPathScreenState extends State<LessonPathScreen> {
  late List<int> scores;
  late List<bool> unlocked;

  @override
  void initState() {
    super.initState();
    scores = List.generate(widget.course.lessons.length, (_) => 0);
    unlocked = List.generate(
      widget.course.lessons.length,
      (index) => index == 0,
    );
  }

  void startTest(int index) async {
    final lesson = widget.course.lessons[index];
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
        if (index + 1 < unlocked.length && score >= 50)
          unlocked[index + 1] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final nodeSpacing = 140.0;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: widget.course.lessons.length * nodeSpacing,
          child: Stack(
            children: [
              CustomPaint(
                size: Size(
                  double.infinity,
                  widget.course.lessons.length * nodeSpacing,
                ),
                painter: LessonPathPainter(
                  widget.course.lessons.length,
                  unlocked: unlocked,
                ),
              ),
              for (int i = 0; i < widget.course.lessons.length; i++)
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
                        title: widget.course.lessons[i].title,
                        index: i + 1,
                        locked: !unlocked[i],
                        percentage: scores[i],
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

class CourseNode extends StatefulWidget {
  final String title;
  final int index;
  final bool locked;
  final int percentage;

  const CourseNode({
    super.key,
    required this.title,
    required this.index,
    required this.locked,
    this.percentage = 0,
  });

  @override
  State<CourseNode> createState() => _CourseNodeState();
}

class _CourseNodeState extends State<CourseNode> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    final nodeSize = 80.0;

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
                    gradient:
                        widget.locked
                            ? LinearGradient(
                              colors: [
                                Colors.grey.shade700,
                                Colors.grey.shade900,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : LinearGradient(
                              colors: [Colors.blue, Colors.lightBlueAccent],
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
                if (!widget.locked && widget.percentage > 0)
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.percentage < 50
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
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.black87),
          ),
        ),
      ],
    );
  }
}

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
