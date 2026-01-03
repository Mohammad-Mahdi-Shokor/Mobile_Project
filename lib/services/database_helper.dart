import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/course.dart';

class DatabaseService {
  // Singleton instance
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;
  DatabaseService._internal();

  static Database? _database;
  static const int _databaseVersion = 2; // Incremented version for migration

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
      version: _databaseVersion,
      onCreate: _createDatabase,
      onUpgrade: _upgradeDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registeredcourses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        course_index INTEGER NOT NULL,
        lessons_finished INTEGER NOT NULL DEFAULT 0
      )
    ''');
  }

  // Database migration from version 1 to 2
  Future<void> _upgradeDatabase(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      await db.execute(
        'ALTER TABLE registeredcourses ADD COLUMN lessons_finished INTEGER NOT NULL DEFAULT 0',
      );
    }
  }

  // CRUD Operations with lessons_finished
  Future<int> insertCourse(Course course) async {
    Database db = await database;
    return await db.insert('registeredcourses', course.toMap());
  }

  Future<List<Course>> getCourses() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'registeredcourses',
      orderBy: 'course_index ASC',
    );

    return results.map((map) => Course.fromMap(map)).toList();
  }

  Future<int> updateCourse(Course course) async {
    Database db = await database;
    return await db.update(
      'registeredcourses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  // NEW: Update just the lessons_finished count
  Future<int> updateLessonsFinished(int id, int lessonsFinished) async {
    Database db = await database;
    return await db.update(
      'registeredcourses',
      {'lessons_finished': lessonsFinished},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // NEW: Increment lessons_finished by 1
  Future<int> incrementLessonsFinished(int id) async {
    Database db = await database;

    // Get current value
    final result = await db.query(
      'registeredcourses',
      columns: ['lessons_finished'],
      where: 'id = ?',
      whereArgs: [id],
    );

    if (result.isNotEmpty) {
      int current = result.first['lessons_finished'] as int;
      return await db.update(
        'registeredcourses',
        {'lessons_finished': current + 1},
        where: 'id = ?',
        whereArgs: [id],
      );
    }
    return 0;
  }

  // NEW: Reset lessons_finished to 0
  Future<int> resetLessonsFinished(int id) async {
    Database db = await database;
    return await db.update(
      'registeredcourses',
      {'lessons_finished': 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteCourse(int id) async {
    Database db = await database;
    return await db.delete(
      'registeredcourses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Additional useful methods
  Future<Course?> getCourseById(int id) async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      'registeredcourses',
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (results.isNotEmpty) {
      return Course.fromMap(results.first);
    }
    return null;
  }

  // NEW: Get progress for all courses
  Future<Map<int, double>> getAllCourseProgress() async {
    Database db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
      SELECT id, lessons_finished 
      FROM registeredcourses
    ''');

    final progress = <int, double>{};
    for (var row in results) {
      final id = row['id'] as int;
      final lessonsFinished = row['lessons_finished'] as int;

      // You need to know total lessons per course. This requires additional logic.
      // For now, we'll return the raw count. You'll need to map this to total lessons.
      progress[id] = lessonsFinished.toDouble();
    }

    return progress;
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}

class Course {
  int? id;
  final String title;
  final int courseIndex;
  final int lessonsFinished; // New field

  Course({
    this.id,
    required this.title,
    required this.courseIndex,
    this.lessonsFinished = 0, // Default to 0
  });

  // Convert Course object to Map for database operations
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'course_index': courseIndex,
      'lessons_finished': lessonsFinished, // Added
    };
  }

  // Create Course object from Map (database result)
  factory Course.fromMap(Map<String, dynamic> map) {
    return Course(
      id: map['id'],
      title: map['title'],
      courseIndex: map['course_index'],
      lessonsFinished:
          map['lessons_finished'] ?? 0, // Handle null for old records
    );
  }

  // Helper method to create a copy with updated values
  Course copyWith({
    int? id,
    String? title,
    int? courseIndex,
    int? lessonsFinished,
  }) {
    return Course(
      id: id ?? this.id,
      title: title ?? this.title,
      courseIndex: courseIndex ?? this.courseIndex,
      lessonsFinished: lessonsFinished ?? this.lessonsFinished,
    );
  }

  // Calculate progress percentage (if you know total lessons)
  double calculateProgress(int totalLessons) {
    if (totalLessons <= 0) return 0.0;
    return (lessonsFinished / totalLessons).clamp(0.0, 1.0);
  }
}
