// utils/registered_course_database_helper.dart
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:convert'; // ADD THIS
import 'registered_course.dart'; // Make sure this path is correct

class RegisteredCourseDatabaseHelper {
  // Singleton pattern
  RegisteredCourseDatabaseHelper._privateConstructor();
  static final RegisteredCourseDatabaseHelper instance =
      RegisteredCourseDatabaseHelper._privateConstructor();

  static Database? _database;
  static const int databaseVersion = 3; // CHANGE TO 3

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'registered_courses.db');

    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registered_courses(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        description TEXT NOT NULL,
        number_of_finished_lessons INTEGER NOT NULL,
        total_lessons INTEGER NOT NULL,
        about TEXT NOT NULL,
        image_url TEXT NOT NULL,
        sections TEXT NOT NULL,
        registered_date TEXT NOT NULL,
        is_completed INTEGER NOT NULL DEFAULT 0,
        progress REAL NOT NULL DEFAULT 0
      )
    ''');
    print('✅ Database created with version $version');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('🔄 Upgrading database from version $oldVersion to $newVersion');

    // Get current columns to avoid duplicate column errors
    final columns = await _getTableColumns(db, 'registered_courses');
    print('📋 Current columns: $columns');

    // Handle version 1 to 2 upgrade (only if needed)
    if (oldVersion == 1) {
      // Add columns only if they don't exist
      if (!columns.contains('total_lessons')) {
        await db.execute('''
          ALTER TABLE registered_courses 
          ADD COLUMN total_lessons INTEGER NOT NULL DEFAULT 0
        ''');
        print('✅ Added total_lessons column');
      }

      if (!columns.contains('registered_date')) {
        await db.execute('''
          ALTER TABLE registered_courses 
          ADD COLUMN registered_date TEXT NOT NULL DEFAULT ''
        ''');
        print('✅ Added registered_date column');
      }

      if (!columns.contains('is_completed')) {
        await db.execute('''
          ALTER TABLE registered_courses 
          ADD COLUMN is_completed INTEGER NOT NULL DEFAULT 0
        ''');
        print('✅ Added is_completed column');
      }

      if (!columns.contains('progress')) {
        await db.execute('''
          ALTER TABLE registered_courses 
          ADD COLUMN progress REAL NOT NULL DEFAULT 0
        ''');
        print('✅ Added progress column');
      }
    }

    // Handle version 2 to 3 upgrade
    if (oldVersion <= 2) {
      // Just ensure all columns exist and have default values
      print('📊 Database schema validated for version 3');

      // Update any existing records with default values for new columns
      if (columns.contains('total_lessons')) {
        await db.execute('''
          UPDATE registered_courses 
          SET total_lessons = 0 
          WHERE total_lessons IS NULL
        ''');
      }
    }
  }

  // Helper to get table columns
  Future<List<String>> _getTableColumns(Database db, String tableName) async {
    final List<Map<String, dynamic>> columns = await db.rawQuery(
      "PRAGMA table_info($tableName)",
    );

    return columns.map((col) => col['name'].toString()).toList();
  }

  // DEBUG METHOD: Check current schema
  Future<void> debugSchema() async {
    final db = await database;
    final columns = await _getTableColumns(db, 'registered_courses');

    print('🔍 Current table schema:');
    for (final column in columns) {
      print('  - $column');
    }
  }

  // RESET METHOD: For testing
  Future<void> resetDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }

    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'registered_courses.db');

    try {
      await deleteDatabase(path);
      print('🗑️ Database deleted');
    } catch (e) {
      print('⚠️ Error deleting database: $e');
    }

    _database = await _initDatabase();
    print('✅ New database created');
  }

  // ========== CRUD OPERATIONS ==========

  Future<RegisteredCourse?> getCourseByTitle(String title) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      where: 'title = ?',
      whereArgs: [title],
      limit: 1,
    );

    if (maps.isNotEmpty) {
      return RegisteredCourse.fromMap(maps.first);
    }
    return null;
  }

  // Insert a new course
  Future<int> insertCourse(RegisteredCourse course) async {
    final db = await database;
    final courseMap = course.toMap();
    print('📥 Inserting course: ${course.title}');
    print('📦 Data: $courseMap');

    try {
      final id = await db.insert(
        'registered_courses',
        courseMap,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('✅ Course inserted with ID: $id');
      return id;
    } catch (e) {
      print('❌ Error inserting course: $e');
      // Debug schema on error
      await debugSchema();
      rethrow;
    }
  }

  // Get all courses
  Future<List<RegisteredCourse>> getAllCourses() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      orderBy: 'registered_date DESC',
    );

    return List.generate(maps.length, (i) {
      return RegisteredCourse.fromMap(maps[i]);
    });
  }

  // Get a specific course by ID
  Future<RegisteredCourse?> getCourse(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return RegisteredCourse.fromMap(maps.first);
    }
    return null;
  }

  // Update a course
  Future<int> updateCourse(RegisteredCourse course) async {
    final db = await database;
    return await db.update(
      'registered_courses',
      course.toMap(),
      where: 'id = ?',
      whereArgs: [course.id],
    );
  }

  // Delete a course
  Future<int> deleteCourse(int id) async {
    final db = await database;
    return await db.delete(
      'registered_courses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Delete all courses
  Future<int> deleteAllCourses() async {
    final db = await database;
    return await db.delete('registered_courses');
  }

  // Check if course already exists (by title)
  Future<bool> isCourseRegistered(String courseTitle) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      where: 'title = ?',
      whereArgs: [courseTitle],
    );
    return maps.isNotEmpty;
  }

  // Get courses by completion status
  Future<List<RegisteredCourse>> getCoursesByStatus(bool completed) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      where: 'is_completed = ?',
      whereArgs: [completed ? 1 : 0],
      orderBy: 'registered_date DESC',
    );

    return List.generate(maps.length, (i) {
      return RegisteredCourse.fromMap(maps[i]);
    });
  }

  // Update lesson progress
  Future<int> updateLessonProgress(int courseId, int finishedLessons) async {
    final db = await database;

    // First get the current course
    final course = await getCourse(courseId);
    if (course == null) return 0;

    // Create updated course
    final updatedCourse = RegisteredCourse(
      id: course.id,
      title: course.title,
      description: course.description,
      numberOfFinishedLessons: finishedLessons,
      totalLessons: course.totalLessons,
      about: course.about,
      imageUrl: course.imageUrl,
      sections: course.sections,
    );

    // Update in database
    return await updateCourse(updatedCourse);
  }

  // Search courses
  Future<List<RegisteredCourse>> searchCourses(String query) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'registered_courses',
      where: 'title LIKE ? OR description LIKE ?',
      whereArgs: ['%$query%', '%$query%'],
      orderBy: 'title ASC',
    );

    return List.generate(maps.length, (i) {
      return RegisteredCourse.fromMap(maps[i]);
    });
  }

  // Get statistics
  Future<Map<String, dynamic>> getStatistics() async {
    final db = await database;

    final totalCourses = await db.rawQuery(
      'SELECT COUNT(*) as count FROM registered_courses',
    );

    final completedCourses = await db.rawQuery(
      'SELECT COUNT(*) as count FROM registered_courses WHERE is_completed = 1',
    );

    final totalProgress = await db.rawQuery(
      'SELECT AVG(progress) as avg FROM registered_courses',
    );

    return {
      'totalCourses': totalCourses.first['count'] ?? 0,
      'completedCourses': completedCourses.first['count'] ?? 0,
      'averageProgress': totalProgress.first['avg'] ?? 0,
    };
  }

  // Close the database
  Future<void> close() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
