import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_project/models/data.dart';
import 'package:mobile_project/screens/lesson_path_screen.dart';
import 'package:mobile_project/services/registered_course.dart';

import '../services/database_helper.dart';

class CourseInfoScreen extends StatefulWidget {
  final RegisteredCourse course;
  const CourseInfoScreen({super.key, required this.course});

  @override
  State<CourseInfoScreen> createState() => _CourseInfoScreenState();
}

class _CourseInfoScreenState extends State<CourseInfoScreen> {
  final RegisteredCourseDatabaseHelper _dbHelper =
      RegisteredCourseDatabaseHelper.instance;

  late List<RegisteredCourse> registeredCourses = [];
  bool isLoading = true;
  bool isCourseRegistered = false;

  @override
  void initState() {
    super.initState();
    _checkIfRegistered();
  }

  Future<void> _checkIfRegistered() async {
    setState(() => isLoading = true);

    try {
      // Load all registered courses
      registeredCourses = await _dbHelper.getAllCourses();

      // Check if this specific course is already registered
      // Compare by title since ID might be null for new courses
      isCourseRegistered = registeredCourses.any(
        (registeredCourse) => registeredCourse.title == widget.course.title,
      );

      print(
        '📊 Course "${widget.course.title}" is registered: $isCourseRegistered',
      );
      print('📚 Total registered courses: ${registeredCourses.length}');
    } catch (e) {
      print('❌ Error checking registration: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _registerCourse() async {
    if (isCourseRegistered) {
      print('⚠️ Course already registered!');
      return;
    }

    setState(() => isLoading = true);

    try {
      // Check again to make sure it's not already registered
      final alreadyRegistered = await _dbHelper.isCourseRegistered(
        widget.course.title,
      );

      if (alreadyRegistered) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'You already registered for "${widget.course.title}"',
            ),
            backgroundColor: Colors.orange,
          ),
        );
        setState(() {
          isCourseRegistered = true;
          isLoading = false;
        });
        return;
      }

      // Create a new RegisteredCourse with proper values
      final newCourse = RegisteredCourse(
        title: widget.course.title,
        description: widget.course.description,
        numberOfFinishedLessons: 0, // Start with 0
        totalLessons: widget.course.sections.length, // Use sections count
        about: widget.course.about,
        imageUrl: widget.course.imageUrl,
        sections: widget.course.sections, // Set current date
      );

      // Insert into database
      final insertedId = await _dbHelper.insertCourse(newCourse);
      print('✅ Course registered successfully! ID: $insertedId');

      // Update state
      setState(() {
        isCourseRegistered = true;
        isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '🎉 Successfully registered for "${widget.course.title}"',
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('❌ Error registering course: $e');
      setState(() => isLoading = false);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to register: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _continueToLessonPath() async {
    // Find the registered course from database
    final registeredCourse = await _dbHelper.getCourseByTitle(
      widget.course.title,
    );

    if (registeredCourse != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder:
              (_) => LessonPathScreen(
                course: registeredCourse,
                // Pass the original course for lessons if needed
                originalCourse: _findOriginalCourse(widget.course.title),
              ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Course not found in registered courses'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Helper method to find original course from sample data
  RegisteredCourse? _findOriginalCourse(String title) {
    try {
      return registeredCoursesWithProgress.firstWhere(
        (course) => course.title == title,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme.textTheme.bodyLarge!.color!,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.course.title,
          style: GoogleFonts.poppins(color: theme.textTheme.bodyLarge!.color!),
        ),
      ),
      body:
          isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Course Image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child:
                          widget.course.imageUrl.startsWith('http')
                              ? Image.network(
                                widget.course.imageUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 180,
                                    width: double.infinity,
                                    color: Colors.grey[200],
                                    child: Icon(
                                      Icons.book,
                                      size: 60,
                                      color: Colors.grey,
                                    ),
                                  );
                                },
                              )
                              : Image.asset(
                                widget.course.imageUrl,
                                height: 180,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                    ),
                    const SizedBox(height: 24),

                    // About Section
                    Text(
                      "About the course",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.course.about,
                      style: GoogleFonts.poppins(
                        color: theme.textTheme.bodyLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          icon: Icons.menu_book,
                          label: 'Lessons',
                          value: widget.course.sections.length.toString(),
                        ),
                        _buildStatItem(
                          icon: Icons.schedule,
                          label: 'Duration',
                          value: '${widget.course.sections.length * 30} min',
                        ),
                        _buildStatItem(
                          icon: Icons.people,
                          label: 'Level',
                          value: 'Beginner',
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Course Sections
                    Text(
                      "Course Sections",
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: theme.textTheme.bodyLarge!.color!,
                      ),
                    ),
                    const SizedBox(height: 12),

                    ...widget.course.sections.map(
                      (section) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 18,
                              color:
                                  isCourseRegistered
                                      ? Color(0xFF3D5CFF)
                                      : Colors.grey,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                section,
                                style: GoogleFonts.poppins(
                                  color: theme.textTheme.bodyLarge!.color!,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Action Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed:
                            isLoading
                                ? null
                                : isCourseRegistered
                                ? _continueToLessonPath
                                : _registerCourse,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF3D5CFF),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child:
                            isLoading
                                ? SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                )
                                : Text(
                                  isCourseRegistered
                                      ? "Continue Learning"
                                      : "Register Now",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                      ),
                    ),

                    // Already registered message
                    if (isCourseRegistered)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                              size: 16,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Already registered',
                              style: GoogleFonts.poppins(
                                color: Colors.green,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, size: 30, color: Color(0xFF3D5CFF)),
        SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.grey),
        ),
      ],
    );
  }
}
