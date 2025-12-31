import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';

class LessonPathScreen extends StatelessWidget {
  final Course course;

  const LessonPathScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: LessonPath(course: course),
      ),
    );
  }
}

class LessonPath extends StatelessWidget {
  final Course course;
  final double nodeSpacing = 140; // closer spacing

  const LessonPath({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: course.sections.length * nodeSpacing,
      child: Stack(
        children: [
          // Curved path behind nodes
          CustomPaint(
            size: Size(double.infinity, course.sections.length * nodeSpacing),
            painter: LessonPathPainter(course.sections.length),
          ),
          // Nodes
          for (int i = 0; i < course.sections.length; i++)
            Positioned(
              top: i * nodeSpacing,
              left: i % 2 == 0
                  ? MediaQuery.of(context).size.width * 0.15
                  : MediaQuery.of(context).size.width * 0.55,
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: i > 2
                      ? null
                      : () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content:
                                    Text('Clicked lesson ${i + 1} - ${course.sections[i]}')),
                          );
                        },
                  child: CourseNode(
                    title: course.sections[i],
                    index: i + 1,
                    locked: i > 2,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class CourseNode extends StatefulWidget {
  final String title;
  final int index;
  final bool locked;

  const CourseNode({
    super.key,
    required this.title,
    required this.index,
    required this.locked,
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
          transform: hovering
              ? (Matrix4.identity()
                ..scale(1.1)
                ..rotateX(-0.2))
              : (Matrix4.identity()..rotateX(-0.2)),
          child: MouseRegion(
            onEnter: (_) => setState(() => hovering = true),
            onExit: (_) => setState(() => hovering = false),
            child: Container(
              width: nodeSize,
              height: nodeSize,
              decoration: BoxDecoration(
                gradient: widget.locked
                    ? LinearGradient(
                        colors: [Colors.grey.shade700, Colors.grey.shade900],
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
                child: widget.locked
                    ? const Icon(Icons.lock, color: Colors.white, size: 30)
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
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: 120,
          child: Text(
            widget.title,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

// Curved path painter
class LessonPathPainter extends CustomPainter {
  final int nodeCount;

  LessonPathPainter(this.nodeCount);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;

    final path = Path();
    final spacing = size.height / nodeCount;

    for (int i = 0; i < nodeCount - 1; i++) {
      final startX = i % 2 == 0 ? size.width * 0.15 + 40 : size.width * 0.55 + 40;
      final startY = i * spacing + 40;

      final endX = (i + 1) % 2 == 0 ? size.width * 0.15 + 40 : size.width * 0.55 + 40;
      final endY = (i + 1) * spacing + 40;

      final controlX = size.width / 2;
      final controlY = startY + spacing / 2;

      path.moveTo(startX, startY);
      path.quadraticBezierTo(controlX, controlY, endX, endY);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
