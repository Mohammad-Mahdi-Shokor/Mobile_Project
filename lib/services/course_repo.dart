import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'database_helper.dart';

class CourseRepository {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initializeDatabase();
    return _database!;
  }

  Future<Database> _initializeDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'courses.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE registeredcourses (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            course_index INTEGER NOT NULL
          )
        ''');
      },
    );
  }

  Future<List<Course>> getAllCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT * FROM registeredcourses ORDER BY course_index ASC',
    );

    return results.map((map) => Course.fromMap(map)).toList();
  }

  Future<Course?> getCourseById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT * FROM registeredcourses WHERE id = ?',
      [id],
    );

    if (results.isNotEmpty) {
      return Course.fromMap(results.first);
    }
    return null;
  }

  Future<List<Course>> getCoursesByIndex(int index) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT * FROM registeredcourses WHERE course_index = ?',
      [index],
    );

    return results.map((map) => Course.fromMap(map)).toList();
  }

  Future<List<Course>> searchCourses(String keyword) async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.rawQuery(
      'SELECT * FROM registeredcourses WHERE title LIKE ?',
      ['%$keyword%'],
    );

    return results.map((map) => Course.fromMap(map)).toList();
  }

  Future<int> addCourse(String title, int index) async {
    final db = await database;
    final result = await db.rawInsert(
      'INSERT INTO registeredcourses (title, course_index) VALUES (?, ?)',
      [title, index],
    );
    return result;
  }

  Future<int> updateCourse(Course course) async {
    final db = await database;
    final result = await db.rawUpdate(
      'UPDATE registeredcourses SET title = ?, course_index = ? WHERE id = ?',
      [course.title, course.courseIndex, course.id],
    );
    return result;
  }

  Future<int> updateCourseTitle(int id, String newTitle) async {
    final db = await database;
    final result = await db.rawUpdate(
      'UPDATE registeredcourses SET title = ? WHERE id = ?',
      [newTitle, id],
    );
    return result;
  }

  Future<int> updateCourseIndex(int id, int newIndex) async {
    final db = await database;
    final result = await db.rawUpdate(
      'UPDATE registeredcourses SET course_index = ? WHERE id = ?',
      [newIndex, id],
    );
    return result;
  }

  Future<int> removeCourse(int id) async {
    final db = await database;
    final result = await db.rawDelete(
      'DELETE FROM registeredcourses WHERE id = ?',
      [id],
    );
    return result;
  }

  Future<int> removeAllCourses() async {
    final db = await database;
    final result = await db.rawDelete('DELETE FROM registeredcourses');
    return result;
  }

  Future<int> removeCoursesByIndex(int index) async {
    final db = await database;
    final result = await db.rawDelete(
      'DELETE FROM registeredcourses WHERE course_index = ?',
      [index],
    );
    return result;
  }

  Future<void> reorderCourses(List<Course> courses) async {
    final db = await database;

    await db.transaction((txn) async {
      for (int i = 0; i < courses.length; i++) {
        await txn.rawUpdate(
          'UPDATE registeredcourses SET course_index = ? WHERE id = ?',
          [i, courses[i].id],
        );
      }
    });
  }

  Future<Map<String, dynamic>> getCourseStats() async {
    final db = await database;
    final countResult = await db.rawQuery(
      'SELECT COUNT(*) as count FROM registeredcourses',
    );
    final avgResult = await db.rawQuery(
      'SELECT AVG(course_index) as average FROM registeredcourses',
    );

    return {
      'count': countResult.first['count'] ?? 0,
      'average_index': avgResult.first['average'] ?? 0,
    };
  }
}
