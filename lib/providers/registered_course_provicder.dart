// import 'package:flutter/material.dart';

// import '../services/database_helper.dart';
// import '../services/registered_course.dart';

// class RegisteredCourseProvider extends ChangeNotifier {
//   final RegisteredCourseDatabaseHelper _dbHelper =
//       RegisteredCourseDatabaseHelper.instance;
//   List<Course> _courses = [];

//   List<Course> get courses => _courses;

//   Future<void> loadCourses() async {
//     _courses = await _dbHelper.getAllCourses();
//     notifyListeners();
//   }

//   Future<void> addCourse(Course course) async {
//     await _dbHelper.insertCourse(course);
//     await loadCourses();
//   }

//   Future<void> updateCourseProgress(
//     int courseId,
//     int newFinishedLessons,
//   ) async {
//     final course = _courses.firstWhere((c) => c.id == courseId);
//     final updatedCourse = Course(
//       id: course.id,
//       title: course.title,
//       description: course.description,
//       numberOfFinishedLessons: newFinishedLessons,
//       about: course.about,
//       imageUrl: course.imageUrl,
//     );
//     await _dbHelper.updateCourse(updatedCourse);
//     await loadCourses();
//   }

//   Future<void> deleteCourse(int id) async {
//     await _dbHelper.deleteCourse(id);
//     await loadCourses();
//   }

//   // Get course by ID
//   Course? getCourseById(int id) {
//     try {
//       return _courses.firstWhere((course) => course.id == id);
//     } catch (e) {
//       return null;
//     }
//   }
// }
